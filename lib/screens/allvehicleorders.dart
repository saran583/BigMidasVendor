
import 'dart:convert';

import 'package:bigmidasvendor/model/modalmycurrentsubs.dart';
import 'package:bigmidasvendor/model/modalvehicleorders.dart';
import 'package:bigmidasvendor/model/modeluser.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/provider/providersubscriptionplan.dart';
import 'package:bigmidasvendor/sharedpreference/loginpreferenc.dart';
import 'package:bigmidasvendor/widgets/testdraw.dart';
import 'package:bigmidasvendor/widgets/drawer.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher.dart';
import '../common.dart';
import 'VichleHistory.dart';
import 'package:share/share.dart';

class AllVehicleOrders extends StatefulWidget {
  static String routeName="/allvehicleorders";
  @override
  _AllVehicleOrdersState createState() => _AllVehicleOrdersState();
}

class _AllVehicleOrdersState extends State<AllVehicleOrders> {
  int showDetails = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int load = 0;
  String dropdownValue = "Completed Orders";


  static List<Widget> _widgetOptions1 = <Widget>[
    VichileHistory(),
    VichileHistory(),
    VichileHistory(),
  ];

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders("3");
    getPlans();

  }

  @override
  Widget build(BuildContext context) {
    ModalMySubs modalMySubs=Provider.of<ProviderSubscriptionPlans>(context,listen:true).modalMySubs;
    Size size=MediaQuery.of(context).size;
    return
     Scaffold(
       key: _scaffoldKey,
       appBar: getAppBar(_scaffoldKey,context),
         drawer: TestDraw(),
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
                    items: <String>['All Orders', 'Pending Orders',"Confirmed Orders","Completed Orders"].map((String value) {
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
                        else if(newValue == "Completed Orders"){
                          getOrders("3");
                        }
                      });
                    },
                  ),),
//     SizedBox(
//       child: Column(children: <Widget>[
//         _widgetOptions1.elementAt(0),
//         _widgetOptions1.elementAt(0),
//       ],
//       ),
//       height: 900,
//       width: 500,),
          load==1 || modelVehicleOrders==null?Center(child: CircularProgressIndicator(),):modelVehicleOrders.products.length==0?Center(child: Text("No Orders at the moment",
               style: TextStyle(color: Colors.red,fontSize: 22
               ),
             ),
             )
                 :Column(children: [
               for(int i=0;i<modelVehicleOrders.products.length;i++)
                 getProductWidget(i,modelVehicleOrders.products[i].id,
                     modelVehicleOrders.products[i].customername,
                     modelVehicleOrders.products[i].customerid,
                     modelVehicleOrders.products[i].customerphone,
                     modelVehicleOrders.products[i].orederid,
                     modelVehicleOrders.products[i].status,
                     modelVehicleOrders.products[i].bookingfrom,
                     modelVehicleOrders.products[i].bookingto,
                     modelVehicleOrders.products[i].distance,
                     modelVehicleOrders.products[i].vehicleserviceid,
                     modelVehicleOrders.products[i].price,
                     modelVehicleOrders.products[i].date,
                     modelVehicleOrders.products[i].time,
                     modelVehicleOrders.products[i].from,
                     modelVehicleOrders.products[i].to,
                     )
             ],),
     ]
           ),
         )
     );
  }

  ModalVehicleOrders modelVehicleOrders;
  void getOrders(String pendingOrConfirmed) async{

    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    //vendorId="60334e60e7250757e7a45062";
    String url=VEHICLE_ORDERS+"/"+vendorId+"&&"+pendingOrConfirmed;
    var request = http.Request('GET', Uri.parse(url));
    print("vehicle orders $url");

    http.StreamedResponse response = await request.send();
 
    if (response.statusCode == 200) {
      String strRes=await response.stream.bytesToString();
      print(strRes);

      setState(() {
        modelVehicleOrders=ModalVehicleOrders.fromJson(jsonDecode(strRes));
      });
      print(modelVehicleOrders);
      setState(() {
              load=0;
            });


    }
    else {
      print(response.reasonPhrase);
    }

  }
  void getPlans()async {
    LoginPreference pref=LoginPreference();
    ModelUser modelUser=await pref.getUserPreference();
    Provider.of<ProviderSubscriptionPlans>(context,listen: false).getMyCurrentSubscription(modelUser.sId,context);


  }

  void Navigate(String destination) async {
    var url="https://www.google.com/maps/dir/?api=1&destination=$destination&travelmode=driving&dir_action=navigate";
    if(await canLaunch(url)){
      await launch(url);
    } else {
      print("Cannot Launch");
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

  void updatestatus(String orderid, String val, String cusid, String msg) async{

    String url=UPDATE_VEHICLE_ORDER_STATUS;
    var request = http.Request('POST', Uri.parse(url));
    request.bodyFields = {
    "orderid":orderid,
    "stat":val,
    "cust":cusid,
    "message":msg,
    };
    print("Vehicle orders $url");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strRes=await response.stream.bytesToString();
      print(strRes);
      
    }
    else {
    print(response.reasonPhrase);
    }

  }


void showAlert(BuildContext context,val,id,cname,cid,cphone,orderid,status,bookingto,bookingfrom,distance,vehicleserviceid,price,date,time,from,to){

  Widget okButton = status=="0"||status=="3"?Container():RaisedButton(child: status=="2"?Text("Completed"):Text("Accept"), onPressed:((){
                          var token="3";
                          if(status=="1"){
                            setState((){token="2";});
                          }
                          updatestatus(id.toString(),token,cid,status=="3"?"Your request $orderid has been fullfilled successfully!!":"Your order $orderid has been accepted by the Vendor");
                          // sendnotification(cid,status=="3"?"Your request $orderid has been fullfilled successfully!!":"Your order $orderid has been accepted by the Vendor");
                          setState(() {
                          modelVehicleOrders.products.removeAt(val);
                          });
                          Navigator.of(context).pop();
                          }) );
  Widget rejectButton =  status=="0"||status=="3"?Container():RaisedButton(onPressed: ((){
                          var token="0";
                          updatestatus(id.toString(),token,cid,"Your request $orderid has been rejected by the vendor");
                          // sendnotification(cid,"Your request $orderid has been rejected by the vendor");
                          setState(() {
                          modelVehicleOrders.products.removeAt(val);
                          });
                          Navigator.of(context).pop();
                }),child: Text("Reject") );
  Widget box = SizedBox(width: 2,);
  Widget callnow = RaisedButton(onPressed: (() async {
                          if(await canLaunch("tel:"+cphone)){
                            await launch("tel:"+cphone);
                          }
                }),child: Text("Call Now") );

  AlertDialog alert = AlertDialog(
    title: Center(child: Text("Orderid:  $orderid"),),
    content: SingleChildScrollView(child: Column(children: [
      Align(alignment: Alignment.centerLeft,
        child:    Text("CustomerName:  $cname",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("CustomerPhone: $cphone",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Price: $price",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("OrderStatus:  ${status=="1"?'Pending':status=="2"?'Confirmed':'Completed'}",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("From:  $from",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("To:  $to",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Total Distance:  $distance km",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Date: $date",textAlign: TextAlign.left,),),
      SizedBox(height: 20,),
      Align(alignment: Alignment.centerLeft,
        child:    Text("Time: $time",textAlign: TextAlign.left,),),
      Align(alignment: Alignment.centerLeft,
        child:  Row(children: [Text("Location :     ",textAlign: TextAlign.left,), RaisedButton(onPressed: ((){
                          status=="2"?Navigate(bookingto):Navigate(bookingfrom);
                }),child: Text("Location") ) ],)),


    ],),),
    actions: [
      rejectButton,
      box,
      okButton,      
      box,
      callnow,
    ],
  );

  showDialog(context: context,
  builder: (BuildContext context){
    return alert;
  });
}

Widget getProductWidget(value,id,cname,cid,cphone,orderid,status,bookingto,bookingfrom,distance,vehicleserviceid,price,date,time,from,to) {
  return GestureDetector(
      onTap: ((){
        // showAlert(BuildContext context,vId,orderid,amount,status,date,time,location,val,datetime){
        showAlert(context,value,id,cname,cid,cphone,orderid,status,bookingto,bookingfrom,distance,vehicleserviceid,price,date,time,from,to);
      }),
      child:  Container(
    decoration: BoxDecoration(border: Border.all(color: Colors.grey[300])),
    // height: 200,
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
              Text("Booking From",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              Expanded(
                child: Text("$from",
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
              Text("Booking To",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              Expanded(
                child: Text("$to",
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
              Text("Total Distance",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              Expanded(
                child: Text("$distance km",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              )
            ],
          ),
          // Flex(
          //   direction: Axis.horizontal,
          //   children: [
          //     Text("Amount",
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //         )),
          //     Expanded(
          //       child: Text("$amount",
          //           textAlign: TextAlign.end,
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //           )),
          //     )
          //   ],
          // ),
        status=="0" || status=="3"?Container():Row(children:[ 
            SizedBox(width:50),
                          RaisedButton(onPressed: ((){ 
                          // sendnotification(cid,"Your request $orderid has been rejected by the vendor");
                          updatestatus(id.toString(),"0",cid,"Your request $orderid has been rejected by the vendor");
                        setState((){
                          modelVehicleOrders.products.removeAt(value);});
                           }), child: Text("Reject"), ),
                           SizedBox(width: 5,),
                           RaisedButton(onPressed: ((){ 
                          // sendnotification(cid,status=="2"?"Your request $orderid has been fullfilled successfully!!":"Your order $orderid has been accepted by the Vendor");
                          updatestatus(id.toString(),status=="2"?"3":"2",cid,status=="2"?"Your request $orderid has been fullfilled successfully!!":"Your order $orderid has been accepted by the Vendor");
                          setState((){
                          modelVehicleOrders.products.removeAt(value);});
                           }), child: status=="2"?Text("Completed"):Text("Accept"), ), ],),

                      Row(children: [
                        SizedBox(width: 50,),
                        RaisedButton(onPressed: (() async {
                          if(await canLaunch("tel:"+cphone)){
                            await launch("tel:"+cphone);
                          }           
                }),child: Text("Call Now") ),
                 SizedBox(width: 5,),
                RaisedButton(onPressed: ((){
                          status=="2"?Navigate(bookingto):Navigate(bookingfrom);
                }),child: Text("Location") ),
                      ],)
        ],
      ),
    ),
  ),
  );
}

}