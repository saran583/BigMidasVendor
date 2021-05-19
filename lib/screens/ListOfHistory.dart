
import 'dart:async';
import 'dart:math';
import 'package:bigmidasvendor/common.dart';
// import 'package:bigmidasvendor/model/modalvehicleorders.dart';
// import 'package:bigmidasvendor/model/modelserviceorders.dart';
// import 'package:bigmidasvendor/model/modelserviceorders.dart';

import 'package:bigmidasvendor/model/modelshoporders.dart';
import 'package:bigmidasvendor/model/modeluser.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/provider/providershop.dart';
import 'package:bigmidasvendor/provider/providersubscriptionplan.dart';
import 'package:bigmidasvendor/screens/Orderdescription.dart';
import 'package:bigmidasvendor/sharedpreference/loginpreferenc.dart';
import 'package:bigmidasvendor/widgets/drawer.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;

import 'StoreHistory.dart';

class ListOfHistory extends StatefulWidget {
  static String routeName="storeOrders";
  @override
  _ListOfHistoryState createState() => _ListOfHistoryState();
}

class _ListOfHistoryState extends State<ListOfHistory> {
  bool isLoading=true;
  int showDetails = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String dropdownValue;

//  static List<Widget> _widgetOptions1 = <Widget>[
//    StoreHistory(),
//    StoreHistory(),
//    StoreHistory(),
//  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async{
       String args = ModalRoute.of(context).settings.arguments;
       String args1 =Provider.of<ProviderLogin>(context,listen: false).userType; 
      if(args=="Orders")
        args="All Orders";
       dropdownValue=args;
      print("init state args $args");
      print("init state args1 are $args1");
    //  int filterBy=0;
    
       Provider.of<ProviderShop>(context,listen:false).getOrders(context, args);

    });

  }
  ModelShopOrders modelShopOrders;
  // ModalServiceOrdes modelServiceOrders;
  // ModalVehicleOrders modelVehicleOrders;
  @override
  Widget build(BuildContext context) {
//    final String args = ModalRoute.of(context).settings.arguments;
  Size size = MediaQuery.of(context).size;



  modelShopOrders = Provider.of<ProviderShop>(context,listen:true).modelShopOrders;  


//    String dropdownValue = 'All Orders';
//    String dropdownValue = args;
//    if(dropdownValue=="Orders")
//      dropdownValue="All Orders";

//print(args);
    return
      Scaffold(
          key: _scaffoldKey,
          appBar: getAppBar(_scaffoldKey,context),
          drawer: drawer(context, "username", "balance"),
          //body:modelShopOrders==null||modelShopOrders.products==null?Center(child: CircularProgressIndicator(),):Container(
          body:Provider.of<ProviderShop>(context,listen:true).isLoadingOrders?Center(child: CircularProgressIndicator(),):Container(
            // height: size.height,
            width: size.width,
            child:
            // child:Provider.of<ProviderShop>(context,listen:true).modelShopOrders==null||
            //     Provider.of<ProviderShop>(context,listen:true).modelShopOrders.products.length!=0?
                // Center(child: Text("No Orders For Now",style: TextStyle(fontSize: 20,color: Colors.red),),)
                // :
                //  SingleChildScrollView(child:
                ListView(children: [
              Container(
                margin: EdgeInsets.all(12),
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                        child: Container(
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                // borderRadius: BorderRadius.circular(9.0),
                                // side: BorderSide(
                                //     color: this.showDetails == 0
                                //         ? Colors.red
                                //         : Colors.white

                                //         )
                              ),
                              color: this.showDetails == 0
                                  ? Color.fromRGBO(118, 54, 152, 1)
                                  : Colors.white,
                              onPressed: () =>
                              {
                                this.setState(() {
                                  this.showDetails = 0;
                                })
                              },
                              child: Text(
                                "$dropdownValue",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: this.showDetails == 0
                                        ? Colors.white
                                        : Colors.black),
                              )),
                        )),

//                    Expanded(
//                        child: FlatButton(
//                            color: this.showDetails == 1
//                                ? Color.fromRGBO(118, 54, 152, 1)
//                                : Colors.white,
//                            // shape: RoundedRectangleBorder(
//                            //     borderRadius: BorderRadius.circular(9.0),
//                            //     side: BorderSide(
//                            //         color: this.showDetails == 1
//                            //             ? Colors.red
//                            //             : Colors.white)),
//                            onPressed: () =>
//                            {
//                              this.setState(() {
//                                this.showDetails = 1;
//                              })
//                            },
//                            child: Text(
//                              "Confirmed",
//                              style: TextStyle(
//                                  fontSize: 16,
//                                  fontWeight: FontWeight.bold,
//                                  color: this.showDetails == 1
//                                      ? Colors.white
//                                      : Colors.black),
//                            ))),

                  ],
                ),
              ),
              SizedBox(
                child: Column(children: <Widget>[

                 Provider.of<ProviderLogin>(context,listen: false).userType!="store"?Container(): DropdownButton<String>(
                  value: dropdownValue,
                    items: <String>['All Orders', 'Pending Orders',"Confirmed Orders","Delivered Orders"].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        Provider.of<ProviderShop>(context,listen:false).getOrders(context, newValue);
                      });
                    },
                  ),
                    
                  modelShopOrders.products.length==0?Center( child: Text("No Orders for Now",style: TextStyle(fontSize: 20,color: Colors.red))):Container(),
                 // _widgetOptions1.elementAt(0),
                //  _widgetOptions1.elementAt(0),
                  for(int i=0;i<modelShopOrders.products.length;i++)

                    getOrderWidget(i,modelShopOrders.products[i])

                

                ],
                ),
                // height: 900,
                width: 500,)
            ]
            ),
            // ),
          )
      );
  
  }
    void updatestatus(String orderid, String val, String cusid, String msg) async{

    String url=UPDATE_STORE_ORDER_STATUS;

    var request = http.Request('POST', Uri.parse(url));
    request.bodyFields = {
    "orderid":orderid,
    "stat":val,
    "cust":cusid,
    "message":msg,
    };

    http.StreamedResponse response = await request.send();


    // print("Service orders $url");

    if (response.statusCode == 200) {
      String strRes=await response.stream.bytesToString();
      print(strRes);
      
      
    }
    else {
    print(response.reasonPhrase);
    }

  }

  // void sendnotification(String cusid, String msg) async{
  //   String url='https://admin.bigmidas.com:7420/store/sendnotificationtocustomer';
  //   var request = http.Request('POST', Uri.parse(url));
  //   request.bodyFields = {
  //   "cust":cusid,
  //   "message":msg,
  //   };

  //   http.StreamedResponse response = await request.send();

  // }
  
//      Container(
//      child: Column(
//        children: [
//          VichileHistory(),
//          VichileHistory(),
//          VichileHistory(),
//        ],
//      ),
//    );

Widget getOrderWidget(int value,Products products){

    return SingleChildScrollView(child: GestureDetector(onTap: (){
      showAlert(context, products.sId,
      products.productname,products.quantity,products.customerid,products.customername,
      products.customerphone,products.prodctcost,products.discountedprodprice,
      products.status,products.ordernote, products.orederid,products.ordertime,value,products.totalprice,products.deliverycharges);
      // Navigator.pushNamed(context, Orderdescription.routeName,arguments: products );
    },  child:  Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
  // height: 215,
  margin: EdgeInsets.all(8),
  child: Container(
  padding: EdgeInsets.all(25),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("Order Id ${products.orederid}",
  style: TextStyle(
  fontWeight: FontWeight.bold,
  )),
  SizedBox(height: 10),
  Flex(
  direction: Axis.horizontal,
  children: [
  //   Expanded(
  // child: Text("INR ${products.discountedprodprice}",
  // textAlign: TextAlign.end,
  // style: TextStyle(
  // fontWeight: FontWeight.bold,
  // )),
  // ),
  Text("ProductName: ${products.productname}",
  style: TextStyle(
  fontWeight: FontWeight.bold,
  )),
  Expanded(
  child: Text("QTY ${products.quantity}",
  textAlign: TextAlign.end,
  style: TextStyle(
  fontWeight: FontWeight.bold,
  )),
  ),
  ],
  ),
  Text(
  "${products.customername}",
  textAlign: TextAlign.start,
  style: TextStyle(color: Colors.black),
  ),
  Text(
  "${products.customerphone}",
  textAlign: TextAlign.start,
  style: TextStyle(color: Colors.black),
  ),

  //Text("2021 02 02 11:43 AM", style: TextStyle(color: Colors.grey))
    Text("Date: ${products.ordertime.split("T")[0]}", style: TextStyle(color: Colors.grey)),
    Text("Time: ${products.ordertime.split("T")[1].split(".")[0]}", style: TextStyle(color: Colors.grey)),
              products.status=="3" || products.status=="0"?Container() : Row( children:[ RaisedButton(onPressed: ((){
                          var token="2";
                          if(products.status=="2"){
                            setState((){token="3";});
                          }
                          // sendnotification(products.customerid,products.status=="2"?"Your order ${products.orederid} has been delivered successfully!!":"Your order ${products.orederid} has been accepted by the vendor");
                          updatestatus(products.sId.toString(),token,products.customerid,products.status=="2"?"Your order ${products.orederid} has been delivered successfully!!":"Your order ${products.orederid} has been accepted by the vendor");
                          setState(() {
                          modelShopOrders.products.removeAt(value);
                          });
                }),child: products.status=="2"?Text("Completed"):Text("Accept"), ),
                SizedBox(width: 35,),
                RaisedButton(onPressed: ((){
                          var token="0";
                          // sendnotification(products.customerid,"Your order ${products.orederid} has been rejected by the Vendor");
                          updatestatus(products.sId.toString(),token,products.customerid,"Your order ${products.orederid} has been rejected by the Vendor");
                          setState(() {
                          modelShopOrders.products.removeAt(value);
                          });
                }),child: Text("Reject") )  ],)

  ],
  ),
  ),)),);

}

void showAlert(BuildContext context, pId,productname,int quantity,customerid,customername,customerphone,
      int cost,int discountedprodprice,status,ordernote,orederid,ordertime,val,totalprice,deliverycharges){
    // var tp= int.parse(cost) * int.parse(quantity);
    // print(totalprice);

  Widget okButton = status=="3"||status=="0"?Container():RaisedButton(child: status=="2"?Text("Completed"):Text("Accept"), onPressed:((){
                          var token="2";
                          if(status=="2"){
                            setState((){token="3";});
                          }
                          updatestatus(pId.toString(),token,customerid,status=="2"?"Your order $orederid has been delivered successfully!!":"Your order $orederid has been accepted by the vendor");
                          // sendnotification(customerid,status=="2"?"Your order $orederid has been delivered successfully!!":"Your order $orederid has been accepted by the vendor");
                          setState(() {
                          modelShopOrders.products.removeAt(val);
                          });
                          Navigator.of(context).pop();
                          }) );
  Widget rejectButton =  status=="3"||status=="0"?Container():RaisedButton(onPressed: ((){
                          var token="0";
                          updatestatus(pId.toString(),token,customerid,"Your order $orederid has been rejected by the Vendor");
                          // sendnotification(customerid,"Your order $orederid has been rejected by the Vendor");
                          setState(() {
                          modelShopOrders.products.removeAt(val);
                          });
                          Navigator.of(context).pop();
                }),child: Text("Reject") );
  Widget box = SizedBox(width: 75,);

  AlertDialog alert = AlertDialog(
    title: Center(child: Text("OrderId: $orederid")),
    content: Column(children: [
      Align(alignment: Alignment.centerLeft,
        child:    Text("ProductName:  $productname",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Quantity:  $quantity",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("CustomerName: $customername",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("CustomerPhone: $customerphone",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Price: $discountedprodprice",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Total Price: ${totalprice==null?discountedprodprice * quantity:totalprice}",textAlign: TextAlign.left,),),
       SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Delivery Charges of order ${orederid.split("-")[0]}: ${deliverycharges==null?0:deliverycharges}",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      // Align(alignment: Alignment.centerLeft,
      //   child:    Text("DiscountPrice:  $discountedprodprice",textAlign: TextAlign.left,),),
      // SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("OrderStatus:  ${status=="1"?'Pending':status=="2"?'Confirmed':status=="0"?'Rejected':'Completed'}",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Order note: ${ordernote==null?"None":ordernote}",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Date: ${ordertime.split("T")[0]}",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Time: ${ordertime.split("T")[1].split(".")[0]}",textAlign: TextAlign.left,),),



    ],),
    actions: [
      rejectButton,
      box,
      okButton,
    ],
  );

  showDialog(context: context,
  builder: (BuildContext context){
    return alert;
  });
}

}
