import 'dart:async';
import 'dart:io';

import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/provider/providershop.dart';
import 'package:bigmidasvendor/provider/providersubscriptionplan.dart';
import 'package:bigmidasvendor/screens/ListOfHistory.dart';
import 'package:bigmidasvendor/screens/ListOfServiceHistory.dart';
import 'package:bigmidasvendor/screens/ListOfVichleHistory.dart';
import 'package:bigmidasvendor/screens/Orderdescription.dart';
import 'package:bigmidasvendor/screens/Privacy.dart';
import 'package:bigmidasvendor/screens/StoreHistory.dart';
import 'package:bigmidasvendor/screens/TC.dart';
import 'package:bigmidasvendor/screens/VichleHistory.dart';
import 'package:bigmidasvendor/screens/aboutus.dart';
import 'package:bigmidasvendor/screens/addproduct.dart';
import 'package:bigmidasvendor/screens/addproduct.dart';
import 'package:bigmidasvendor/screens/allserviceorders.dart';
import 'package:bigmidasvendor/screens/allvehicleorders.dart';
import 'package:bigmidasvendor/screens/dashboard.dart';
import 'package:bigmidasvendor/screens/editproduct.dart';
import 'package:bigmidasvendor/screens/editsingleproduct.dart';
import 'package:bigmidasvendor/screens/listing.dart';
import 'package:bigmidasvendor/screens/login.dart';
import 'package:bigmidasvendor/screens/loginorregisteroption.dart';
import 'package:bigmidasvendor/screens/notification.dart';
import 'package:bigmidasvendor/screens/profile.dart';
import 'package:bigmidasvendor/screens/register.dart';
import 'package:bigmidasvendor/screens/review.dart';
import 'package:bigmidasvendor/screens/selectservice.dart';
import 'package:bigmidasvendor/screens/subscription.dart';
import 'package:bigmidasvendor/screens/tutorial.dart';
import 'package:bigmidasvendor/screens/vehicleprofile.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location_permissions/location_permissions.dart' as Permcheck;
import 'package:provider/provider.dart';
import 'common.dart';
import 'screens/addproduct.dart';
import 'package:http/http.dart' as http;
import 'fcm/myfirebase.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  
  
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  String routeto;

  MyApp({
    this.routeto
  });

  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState

    return MyAppState(routeto: this.routeto);
  }
}
class MyAppState extends State<MyApp>{
  String routeto;
  MyAppState({String routeto}) {
      this.routeto = routeto;
  }

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getlocationstatus();
  }

  // void getlocationstatus() async {
  //   print("Entered get locations");
  //   // Future<Permcheck.PermissionStatus> Function({Permcheck.LocationPermissionLevel level}) permission = await LocationPermissions().checkPermissionStatus;
  //   final locationStatus = await Permission.locationWhenInUse.serviceStatus;
  //   bool location = locationStatus == Permcheck.ServiceStatus.enabled; 
  //   if(location==false){
  //     showAlert(context);
  //     print("This is location $location");
  //   }
  //   print("this is location status $location");
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    initFirebase(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // setupFirebase(context);

     if (this.routeto!=null) {
      debugPrint("this is in main");
      Navigator.pushNamed(context, this.routeto);
    }
    return MultiProvider(providers: [

      ChangeNotifierProvider<ProviderLogin>(
        create: (context) => ProviderLogin(),

      ),
      ChangeNotifierProvider<ProviderShop>(
        create: (context) => ProviderShop(),

      ),
      ChangeNotifierProvider<ProviderSubscriptionPlans>(
        create: (context) => ProviderSubscriptionPlans(),

      ),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          fontFamily: 'Regular'

          ,
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.grey,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: LoginOrRegisterOption(),
        routes: {
          RegisterScreen.routeName: (context) => RegisterScreen(),
          Login.routeName: (context) => Login(),
          SelectService.routeName: (context) => SelectService(),
          Listing.routeName: (context) => Listing(),
          DashBoard.routeName: (context) => DashBoard(),
          AddProduct.routeName: (context) => AddProduct(),
          ReviewListView.routeName: (context) => ReviewListView(),
          Profile.routeName: (context) => Profile(),
          Subscription.routeName: (context) => Subscription(),
          ListOfVichleHistory.routeName: (context) => ListOfVichleHistory(),
          ListOfServiceHistory.routeName: (context) => ListOfServiceHistory(),
          ListOfHistory.routeName: (context) => ListOfHistory(),
          EditProduct.routeName: (context) => EditProduct(),
          AppNotification.routeName: (context) => AppNotification(),
          TC.routeName: (context) => TC(),
          Privacy.routeName: (context) => Privacy(),
          AboutUs.routeName: (context) => AboutUs(),
          Tutorial.routeName: (context) => Tutorial(),
          EditSingleProduct.routeName: (context) => EditSingleProduct(),
          VehicleProfile.routeName: (context) => VehicleProfile(),
          Orderdescription.routeName: (context) => Orderdescription(),
          AllVehicleOrders.routeName: (context) => AllVehicleOrders(),
          AllServiceOrders.routeName: (context) => AllServiceOrders(),
        },
      ),
    );


  }

// void showAlert(BuildContext context){
//   Widget okButton = RaisedButton(onPressed: (() {Navigator.of(context).pop();}), child: Text("Deny"),);
//   Widget rejectButton = RaisedButton( onPressed: (()async {Permcheck.PermissionStatus perms = await LocationPermissions().requestPermissions(); if(perms==Permcheck.PermissionStatus.granted){print("yes"); Navigator.of(context).pop();}}), child:Text("Okay"));
//   AlertDialog alert = AlertDialog(
//     title: Center(child: Text("Big Midas Vendor")),
//     content: Column(children:[
//     Expanded(child:  
//     Text("This app collects location data to enable below features in the app, even when the app is closed or not in use.",style: TextStyle(fontWeight: FontWeight.bold),),
//     ),
//     SizedBox(height: 10,),
//     Expanded(child: 
//     Text("To collect vehicle driver’s current location so customers can find all nearby drivers in customer app and can make the booking of it."),
//     ),
//     SizedBox(height: 10,),
//     Expanded(child:
//     Text("To collect your location so customers can find the nearby service provider or nearby stores in customers app and can make the booking of it."),
//     ),
//     ]),
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

