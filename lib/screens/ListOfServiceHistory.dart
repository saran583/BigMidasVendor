
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
import 'package:bigmidasvendor/widgets/testdraw.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ListOfServiceHistory extends StatefulWidget {
  static String routeName="/servicehistory";
  @override
  _ListOfServiceHistoryState createState() => _ListOfServiceHistoryState();
}

class _ListOfServiceHistoryState extends State<ListOfServiceHistory> {
  int showDetails = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int show=0;
  int load=0;

  static List<Widget> _widgetOptions1 = <Widget>[
    ServiceHistory(),
    ServiceHistory(),
    ServiceHistory(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders("1");
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
          drawer: TestDraw(),
          // drawer: drawer(context, "username", "balance"),
          body:Container(
            height: size.height,
            width: size.width,
            child: ListView(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(onTap: ((){
                    Share.share('Checkout the Bigmidas Vendor app to list your Services and get orders online you can also list your Stores & Vehicles as well https://play.google.com/store/apps/details?id=bigmidas');
                  }),
                  child: Container(child: Image.asset("assets/images/share1.jpeg",height: 80,width: 80,),),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Membership"),
                      SizedBox(width: 20,),
                      Container(

                        margin: EdgeInsets.only(right: 10),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)

                          ),
                          border: Border.all(
                            width: 3,
                            color: Colors.red,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Center(
                          child:  modalMySubs==null||modalMySubs.daysremaining==null
                              ?Container(child: CircularProgressIndicator(),)
                              :modalMySubs.daysremaining==-10?Text("0"):Text(  
                            "${modalMySubs.daysremaining}",
                          ),
                        ),
                      )
                    ],
                  ),
                ],),
              Container(
                margin: EdgeInsets.all(12),
                height: 40,
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
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
                              onPressed: () => {
                                this.setState((){
                                  load=1;
                                }),
                                getOrders("1"),
                                this.setState(() {
                                  this.showDetails = 0;
                                })
                              },
                              child: Text(
                                "Pending",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: this.showDetails == 0
                                        ? Colors.white
                                        : Colors.black),
                              )),
                        )),
                    Expanded(
                        child: FlatButton(
                            color: this.showDetails == 1
                                ? Color.fromRGBO(118, 54, 152, 1)
                                : Colors.white,
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(9.0),
                            //     side: BorderSide(
                            //         color: this.showDetails == 1
                            //             ? Colors.red
                            //             : Colors.white)),
                            onPressed: () => {
                              this.setState((){
                                  load=1;
                                }),
                              getOrders("2"),
                              this.setState(() {
                                this.showDetails = 1;
                              })
                            },
                            child: Text(
                              "Confirmed",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: this.showDetails == 1
                                      ? Colors.white
                                      : Colors.black),
                            ))),

                  ],
                ),
              ),
//              SizedBox(
//                child: Column(children: <Widget>[
//                  _widgetOptions1.elementAt(0),
//                  _widgetOptions1.elementAt(0),
//                ],
//                ),
//                height: 900,
//                width: 500,)

//                                                                              modelServiceOrders.products.length==0
            load==1 || modelServiceOrders==null?Center(child: CircularProgressIndicator(),):show==1?Center(child: Text("No Orders at the moment",
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

            modelServiceOrders.products.length<1?Text("No Orders at the moment",style: TextStyle(color: Colors.red,fontSize: 22)):Text(""),
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

  void Navigate(String origin,String destination) async {
    var url="https://www.google.com/maps/dir/?api=1&destination=$destination&travelmode=driving&dir_action=navigate";
    if(await canLaunch(url)){
      await launch(url);
    } else {
      print("Cannot Launch");
    }
  }


  //   void sendnotification(String cusid, String msg) async{
  //   String url='https://admin.bigmidas.com:7420/store/sendnotificationtocustomer';
  //   var request = http.Request('POST', Uri.parse(url));
  //   request.bodyFields = {
  //   "cust":cusid,
  //   "message":msg,
  //   };

  //   http.StreamedResponse response = await request.send();

  // }

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
                           SizedBox(width: 5,),
                RaisedButton(onPressed: ((){
                          Navigate("43.7967876,-79.5331616",location);
                }),child: Text("Location") ),
                           SizedBox(width: 5,),
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
  Widget navigatebutton = RaisedButton(onPressed: ((){
                          Navigate("43.7967876,-79.5331616",location);
                }),child: Text("Location") );
  Widget rejectButton =  status == "0" || status == "3"?Container(): RaisedButton(onPressed: ((){
                          var token="0";
                          // sendnotification(custid,"Your order $orderid has been rejected by the vendor");
                          updatestatus(id.toString(),token,custid,"Your order $orderid has been rejected by the vendor");
                          setState(() {
                          modelServiceOrders.products.removeAt(val);
                          });
                          Navigator.of(context).pop();
                }),child: Text("Reject") );
  Widget box = SizedBox(width: 5,);

  AlertDialog alert = AlertDialog(
    title: Center(child: Text("Orderid:  $orderid")),
    content: SingleChildScrollView(child: Column(children: [
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

    ],),),
    actions: [
      rejectButton,
      box,
      navigatebutton,
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
