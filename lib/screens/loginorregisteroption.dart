import 'package:bigmidasvendor/fcm/myfirebase.dart';
import 'package:bigmidasvendor/model/modeluser.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/provider/providersubscriptionplan.dart';
import 'package:bigmidasvendor/screens/register.dart';
import 'package:bigmidasvendor/screens/selectservice.dart';
import 'package:bigmidasvendor/sharedpreference/loginpreferenc.dart';
import 'package:bigmidasvendor/widgets/appspecificsignaturewidgets.dart';
import 'package:flutter/material.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location_permissions/location_permissions.dart' as Permcheck;
import 'login.dart';

class LoginOrRegisterOption extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginOrRegisterOptionState();
  }
}
class LoginOrRegisterOptionState extends State<LoginOrRegisterOption>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForUserData();
    // getlocationstatus();
  }

  void getlocationstatus() async {
    // Future<Permcheck.PermissionStatus> Function({Permcheck.LocationPermissionLevel level}) permission = await LocationPermissions().checkPermissionStatus;
    final locationStatus = await Permission.locationWhenInUse.serviceStatus;
    bool location = locationStatus == Permcheck.ServiceStatus.enabled; 
    if(location==false){
      showAlert(context);
    }
    print("this is location status $location");
  }





  void checkForUserData()async
  {
    ModelUser modelUser=await Provider.of<ProviderLogin>(context,listen: false).loadUserPrefIfAny();
    //print("checking user pref ${modelUser.id} ${modelUser.userId}");
    //print("checking user pref ${modelUser.sId} ");
    if(modelUser!=null&&modelUser.sId!=null&&modelUser.sId.isNotEmpty){
      Navigator.pushReplacementNamed(context, SelectService.routeName);
      getMembershipRemainingDays();
    }
    initFirebase(context);
//    getMembershipRemainingDays();
  }
  void getMembershipRemainingDays()async {
    LoginPreference pref=LoginPreference();
    ModelUser modelUser=await pref.getUserPreference();
    Provider.of<ProviderSubscriptionPlans>(context,listen: false).getMyCurrentSubscription(modelUser.sId,context);

  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Image.asset("assets/images/logo_Big_Midas.jpeg",height: 180,width: 180,),),
            
     Container(
       margin: EdgeInsets.only(bottom: 10,left: 20,right: 20),
       child:  Text("Do You want To List Your Store Vehicle or Your Service & Want To Receive New Order... If Yes Then",
       style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

     ),

          Container(
            margin: EdgeInsets.all(20),
            child: getAwesomeButton("Create Your Account", (){
            Navigator.pushNamed(context, RegisterScreen.routeName);
          }),),
//          RaisedButton(
//            child: Text("Create Your Account",),
//            onPressed: (){
//              Navigator.pushNamed(context, RegisterScreen.routeName);
//            },
//          ),

      Container(
        margin: EdgeInsets.only(bottom: 10,left: 20,right: 20,top: 50),
        child: Text("Already Registered",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
        )
      ),
//          RaisedButton(
//            child: Text("Click Here To Login"),
//            onPressed: (){
//              Navigator.pushNamed(context, Login.routeName);
//            },
//          ),
          Container(
            margin: EdgeInsets.all(20),
            child: getAwesomeButton("Click Here To Login", (){
              Navigator.pushNamed(context, Login.routeName);
          }),),
        ],
        ),
      ),
    );
  }


  
void showAlert(BuildContext context){
  Widget okButton = RaisedButton(onPressed: (() {Navigator.of(context).pop();}), child: Text("Deny"),);
  Widget rejectButton = RaisedButton( onPressed: (()async {Permcheck.PermissionStatus perms = await LocationPermissions().requestPermissions(); if(perms==Permcheck.PermissionStatus.granted){print("yes"); Navigator.of(context).pop();}}), child:Text("Okay"));
  AlertDialog alert = AlertDialog(
    title: Center(child: Text("Big Midas Vendor")),
    content: Container(child: 
    Text("This app collects location data to enable below features in the app, even when the app is closed or not in use.\n\nTo collect vehicle driver’s current location so customers can find all nearby drivers in customer app and can make the booking of it.\n\nTo collect your location so customers can find the nearby service provider or nearby stores in customers app and can make the booking of it."),
    ),
    actions: [
      okButton,
      rejectButton
          ],
  );

  showDialog(context: context,
  builder: (BuildContext context){
    return alert;
  });
}

}