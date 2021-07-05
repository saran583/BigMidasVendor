import 'dart:convert';

import 'package:bigmidasvendor/model/modelnotification.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/widgets/drawer.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:bigmidasvendor/widgets/testdraw.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../common.dart';

class AppNotification extends StatefulWidget
{
  static String routeName="/notification";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return AppNotificationState();
  }

}

class AppNotificationState extends State<AppNotification>
{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Result> listNotifications;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotifications();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: getAppBar(_scaffoldKey,context),
      // drawer: drawer(context, "username", "balance"),
      drawer: TestDraw(),
      body: Container(
        width: double.infinity,
      child:listNotifications==null?Center(child: CircularProgressIndicator(),) :
      listNotifications.length==0?Center(child: Text("No notifications.",style: TextStyle(fontSize: 20,color: Colors.red),),):ListView(
        children: <Widget>[

for(int i=0;i<listNotifications.length;i++)
          getNotiWidget(listNotifications[i]),

      ],
      ),
    ),
    );
  }

  void getNotifications() async{
    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    String url = "$VENDORMESSAGES/$vendorId";
    var request = http.Request('GET', Uri.parse(url));

    print("sub cat url $url");
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strRes = await response.stream.bytesToString();
      print(strRes);
      ModelNotification modelNotification = ModelNotification.fromJson(json.decode(strRes));
      listNotifications=modelNotification.result;

      print("vehicle cate ${listNotifications.length}");

    }
    else {
      print(response.reasonPhrase);
    }
    setState(() {

    });
  }

  getNotiWidget(Result modelNotification) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        width: double.infinity,
        child:Column(children: <Widget>[
          Card(child: Row(children: <Widget>[
            //Image.asset("assets/images/headphone.jpg",height: 80,width: 80,),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
//                Text("Big Billion Day"),
//                Text("Buy Electronics with upto 30% off"),

                Text("${modelNotification.message}",style: TextStyle(fontSize: 20),),
              ],
            ),
          ],) ,),
//          Card(child: Row(children: <Widget>[
//            Image.asset("assets/images/headphone.jpg",height: 80,width: 80,),
//            Column(
//              mainAxisSize: MainAxisSize.max,
//
//              children: <Widget>[
//                Text("Big Billion Day"),
//                Text("Buy Electronics with upto 30% off"),
//              ],
//            ),
//          ],) ,),
        ],)
    );
  }

}