

import 'package:bigmidasvendor/fcm/myfirebase.dart';
import 'package:bigmidasvendor/screens/listing.dart';
import 'package:bigmidasvendor/sharedpreference/loginpreferenc.dart';
import 'package:bigmidasvendor/utils/hexcolor.dart';
import 'package:bigmidasvendor/widgets/dashboardoptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:location_permissions/location_permissions.dart' as Permcheck;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:location_permissions/location_permissions.dart';

class SelectService extends StatefulWidget
{
  static String routeName="/selectservice";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SelectServiceState();
  }

}

class SelectServiceState extends State<SelectService>
{

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getlocationstatus();
  }

  // void getlocationstatus() async {
  //   // Future<Permcheck.PermissionStatus> Function({Permcheck.LocationPermissionLevel level}) permission = await LocationPermissions().checkPermissionStatus;
  //   final locationStatus = await Permission.locationWhenInUse.serviceStatus;
  //   bool location = locationStatus == Permcheck.ServiceStatus.enabled; 
  //   if(location==false){
  //     showAlert(context);
  //   }
  //   print("this is location status $location");


  // }

  @override
  Widget build(BuildContext context) {
    // setupFirebase(context);
    // TODO: implement build
    return Scaffold(

        bottomNavigationBar:Container(
            height: 60,
            color: Colors.red,
            child: InkWell(
                onTap: () {
                  //SystemNavigator.pop();
                  LoginPreference pref=LoginPreference();
                  pref.deleteUserPreference();
                  Navigator.pushReplacementNamed(context,"/");
                },

                child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      Text('Logout',style: TextStyle(color: Colors.white),),
                    ],
                  ),)
            )
        ),

        //appBar: CustomAppBar(),
        body:Container(
          margin: EdgeInsets.only(top: 10,left: 40,right: 40),
          child: ListView(children: [


               Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getDashboardOption("Store Listing", "assets/images/store.gif",context,85),
                //getDashboardOption("LOI", "assets/images/2.png",context),
              ],
            ),
            InkWell(
              onTap: ((){}),
              child: 
            Container(
              margin: EdgeInsets.all(20),
              child: Text("If you have your shop/store then proceed with store listing",
                style: TextStyle(
                    color: Colors.red),
              ),
            ),),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getDashboardOption("Vehicle Listing", "assets/images/vehicle.gif",context,85),
                  //getDashboardOption("Alloted Mines", "assets/images/4.png",context),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),

              child: Text("If you want to list your vehicles then login/signup with vehicle listing",
                style: TextStyle(
                    color: Colors.red),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getDashboardOption("Service Listing", "assets/images/service.gif",context,85),
                  //getDashboardOption("Alloted Mines", "assets/images/4.png",context),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),

              child: Text("If you are a carpenter plumber web/app developer or providing some other service then login/signup with service listing",
                style: TextStyle(
                    color: Colors.red),
              ),
            ),
//          Container(
//            margin: EdgeInsets.only(top: 40),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: [
//                getDashboardOption("Etps Scanned", "assets/images/3.png",context),
//                getDashboardOption("Users List", "assets/images/4.png",context),
//              ],
//            ),
//          )
          ],

          ),)
    );
  }

// void showAlert(BuildContext context){
//   Widget okButton = RaisedButton(onPressed: (() {Navigator.of(context).pop();}), child: Text("Deny"),);
//   Widget rejectButton = RaisedButton( onPressed: (()async {Permcheck.PermissionStatus perms = await LocationPermissions().requestPermissions(); if(perms==Permcheck.PermissionStatus.granted){print("yes"); Navigator.of(context).pop();}}), child:Text("Okay"));
//   AlertDialog alert = AlertDialog(
//     title: Center(child: Text("Big Midas Vendor")),
//     content: Container(child: 
//     Text("This app collects location data to enable below features in the app, even when the app is closed or not in use.\n\nTo collect vehicle driver’s current location so customers can find all nearby drivers in customer app and can make the booking of it.\n\nTo collect your location so customers can find the nearby service provider or nearby stores in customers app and can make the booking of it."),
//     ),
//     actions: [
//       okButton,
//       rejectButton
//           ],
//   );

//   showDialog(context: context,
//   builder: (BuildContext context){
//     return alert;
//   });
// }

}