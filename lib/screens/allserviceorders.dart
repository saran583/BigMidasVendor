
import 'dart:convert';

import 'package:bigmidasvendor/common.dart';
import 'package:bigmidasvendor/model/modalmycurrentsubs.dart';
import 'package:bigmidasvendor/model/modelserviceorders.dart';
import 'package:bigmidasvendor/model/modeluser.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/provider/providersubscriptionplan.dart';
import 'package:bigmidasvendor/screens/serviceHistory.dart';
import 'package:bigmidasvendor/sharedpreference/loginpreferenc.dart';
import 'package:bigmidasvendor/widgets/drawer.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;
import 'package:share/share.dart';

class AllServiceOrders extends StatefulWidget {
  static String routeName="/allserviceorders";
  @override
  _AllServiceOrdersState createState() => _AllServiceOrdersState();
}

class _AllServiceOrdersState extends State<AllServiceOrders> {
  int showDetails = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int show=0;
  int load=0;
  String dropdownValue = "Completed Booking";

  static List<Widget> _widgetOptions1 = <Widget>[
    ServiceHistory(),
    ServiceHistory(),
    ServiceHistory(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders("3");
    // getMyCurrentSubscription()
  }
  ModalServiceOrdes modelServiceOrders;

  @override
  Widget build(BuildContext context) {
    ModalMySubs modalMySubs=Provider.of<ProviderSubscriptionPlans>(context,listen:true).modalMySubs;

    Size size=MediaQuery.of(context).size;
    return
      Scaffold(
          key: _scaffoldKey,
          appBar: getAppBar(_scaffoldKey,context),
          drawer: drawer(context, "username", "balance"),
          body:Container(
            height: size.height,
            width: size.width,
            child: ListView(children: [
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
                  ],
                ),
              ),
              Container(
                 margin: EdgeInsets.only(left: 92, right:92),

                child: DropdownButton<String>(
                  value: dropdownValue,
                    items: <String>['All Orders', 'Pending Orders',"Confirmed Orders","Completed Booking"].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        load=1;
                        dropdownValue = newValue;
                        if(newValue=='All Orders'){
                        getOrders("0");
                        }
                        else if(newValue == 'Pending Orders'){
                          getOrders("1");
                        }
                        else if(newValue == "Confirmed Orders"){
                          getOrders("2");
                        }
                        else if(newValue == "Completed Booking"){
                          getOrders("3");
                        }
                      });
                    },
                  ),),
//              SizedBox(
//                child: Column(children: <Widget>[
//                  _widgetOptions1.elementAt(0),
//                  _widgetOptions1.elementAt(0),
//                ],
//                ),
//                height: 900,
//                width: 500,)

//                                                                              modelServiceOrders.products.length==0
            load==1 || modelServiceOrders==null?Center(child: CircularProgressIndicator(),):show==1 || modelServiceOrders.products.length==0 ?Center(child: Text("No Orders at the moment",
              style: TextStyle(color: Colors.red,fontSize: 22
            ),
            ),
            )
            :Column(children: [
              for(int i=0;i<modelServiceOrders.products.length;i++)
                getProductWidget(i,modelServiceOrders.products[i].sId,
                    modelServiceOrders.products[i].custid,
                    modelServiceOrders.products[i].orderid,
                    modelServiceOrders.products[i].status,
                    modelServiceOrders.products[i].date,
                    modelServiceOrders.products[i].time,
                    modelServiceOrders.products[i].location,
                    modelServiceOrders.products[i].price,
                    modelServiceOrders.products[i].title,
                    modelServiceOrders.products[i].description,
                    modelServiceOrders.products[i].custname,
                    modelServiceOrders.products[i].custphone),
            ],),
            ]
            ),
          )
      );
  }
  void getOrders(String val) async{
    setState(() {
          show=0;
        });
    LoginPreference pref=LoginPreference();
    ModelUser modelUser=await pref.getUserPreference();
    Provider.of<ProviderSubscriptionPlans>(context,listen: false).getMyCurrentSubscription(modelUser.sId,context);

    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    String url=SERVICE_ORDERS+"/"+vendorId+"&&"+val;
    var request = http.Request('GET', Uri.parse(url));
    print("Service orders $url");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strRes=await response.stream.bytesToString();
      print(strRes);
      setState(() {
        modelServiceOrders=ModalServiceOrdes.fromJson(json.decode(strRes));
            });
      load=0;
      
      print(modelServiceOrders);
    }
    else {
    print(response.reasonPhrase);
    }

  }
    void sendnotification(String cusid, String msg) async{
    String url='https://admin.bigmidas.com:7420/store/sendnotificationtocustomer';
    var request = http.Request('POST', Uri.parse(url));
    request.bodyFields = {
    "cust":cusid,
    "message":msg,
    };

    http.StreamedResponse response = await request.send();

  }

  void updatestatus(String orderid, String val, String cusid, String msg) async{

    String url=UPDATE_SERVICE_ORDER_STATUS;
    var request = http.Request('POST', Uri.parse(url));
    request.bodyFields = {
    "orderid":orderid,
    "stat":val,
    "cust":cusid,
    "message":msg,
    };
    print("Service orders $url");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strRes=await response.stream.bytesToString();
      print(strRes);
      
    }
    else {
    print(response.reasonPhrase);
    }
  }

 Widget getProductWidget(value,id,custid,orderid,status,bookingdate,bookingtime,location,amount,title,description,custname,custphone) {
   print(status);
    return GestureDetector(
      onTap: ((){
        showAlert(context,id,custid,orderid,amount,status,bookingdate,bookingtime,location,value,title,description,custname,custphone);
      }),
      child:  Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
      height: 200,
      margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Text("Order Id :$orderid",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                // Expanded(
                //   child: Text("INR2,978.00",
                //       textAlign: TextAlign.end,
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       )),
                // )
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Text("Booking Date",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Expanded(
                  child: Text("$bookingdate",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Text("Booking Time",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Expanded(
                  child: Text("$bookingtime",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Text("Booking Location",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Expanded(
                  child: Text("$location",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Text("Amount",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Expanded(
                  child: Text("$amount",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
            status=="3" || status=="0"?Container() :Row(children:[
                           RaisedButton(onPressed: ((){ 
                          updatestatus(custid.toString(),"0",custid,"Your order $orderid has been rejected by the vendor");
                          // sendnotification(custid,"Your order $orderid has been rejected by the vendor");
                          setState(() {
                          modelServiceOrders.products.removeAt(value);});
                           }), child: Text("Reject") ),
                           SizedBox(width: 35,),
                           RaisedButton ( onPressed: ((){ 
                            // sendnotification(custid,status=="2"?"Your request $orderid has been fullfilled successfully!!":"Your request $orderid has been accepted by the Service Provider");
                          updatestatus(id.toString(),status=="2"?"3":"2",custid,status=="2"?"Your request $orderid has been fullfilled successfully!!":"Your request $orderid has been accepted by the Service Provider");
                          setState(() {
                          modelServiceOrders.products.removeAt(value);});
                           }), child: status=="2"?Text("Completed"):Text("Accept"), ),
                            ],)
          ],
        ),
      ),
    ),
    );
  }

  void showAlert(BuildContext context,id,custid,orderid,amount,status,date,time,location,val,title,description,custname,custphone){

  Widget okButton = status == "0" || status == "3"?Container(): RaisedButton(child: status=="2"?Text("Completed"):Text("Accept"), onPressed:((){
                          var token="3";
                          // sendnotification(custid,status=="2"?"Your request $orderid has been fullfilled successfully!!":"Your request $orderid has been accepted by the Service Provider");
                          if(status=="1"){
                            setState((){token="2";});
                          }
                          updatestatus(id.toString(),token,custid,status=="2"?"Your request $orderid has been fullfilled successfully!!":"Your request $orderid has been accepted by the Service Provider");
                          setState(() {
                          modelServiceOrders.products.removeAt(val);
                          });
                          Navigator.of(context).pop();
                          }) );
  Widget rejectButton =  status == "0" || status == "3"?Container(): RaisedButton(onPressed: ((){
                          var token="0";
                          // sendnotification(custid,"Your order $orderid has been rejected by the vendor");
                          updatestatus(id.toString(),token,custid,"Your order $orderid has been rejected by the vendor");
                          setState(() {
                          modelServiceOrders.products.removeAt(val);
                          });
                          Navigator.of(context).pop();
                }),child: Text("Reject") );
  Widget box = SizedBox(width: 75,);

  AlertDialog alert = AlertDialog(
    title: Center(child: Text("Orderid:  $orderid")),
    content: Column(children: [
      Align(alignment: Alignment.centerLeft,
        child:    Text("Order Title:  $title",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
      child:    Text("Job Description:  $description",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Customer Name:  $custname",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Customer Phone: $custphone",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Price: $amount",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Order Status:  ${status=="1"?'Pending':status=="2"?'Confirmed':'Completed'}",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Location:  $location",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Date: $date",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Time: $time",textAlign: TextAlign.left,),),

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

//      Container(
//      child: Column(
//        children: [
//          VichileHistory(),
//          VichileHistory(),
//          VichileHistory(),
//        ],
//      ),
//    );
}
