import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bigmidasvendor/model/modeluser.dart';
import 'package:bigmidasvendor/screens/selectservice.dart';
import 'package:bigmidasvendor/sharedpreference/loginpreferenc.dart';
import 'package:bigmidasvendor/widgets/showdialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../common.dart';
class ProviderLogin with ChangeNotifier
{
  ModelUser modelUser;
String userId="";
String userType="";
List<String> drawerOptionStore=[
  "Profile Setting",
  "Add Product",
  "Edit Products",
  "Orders",
  "Rating/Reviews",
  "Subscription",
  "Share App",
  "About Us",
  "T/C",
  "Privacy Policy",
  "Logout",

];

List<String> drawerOptionVehicle=[
  "Profile Setting",
  "Vehicle Details",
  "Completed Jobs",
  "Rating/Reviews",

  "Subscription",
  "Share App",
  "About Us",
  "T/C",
  "Privacy Policy",
  "Logout",

];
List<String> drawerOptionService=[
  "Profile Setting",
  "Completed Booking",
  "Rating/Reviews",


  "Subscription",
  "Share App",
  "About Us",
  "T/C",
  "Privacy Policy",
  "Logout",

];

  bool activeValue;

Future<ModelUser>loadUserPrefIfAny()async
{
  LoginPreference pref=LoginPreference();

  modelUser=await pref.getUserPreference();
  return modelUser;
}

Future<void> loginAPI(String userType,String phonenumber,String password,context)async
{
this.userType=userType;
var headers = {
  'Content-Type': 'application/x-www-form-urlencoded'
};
var request = http.Request('POST', Uri.parse('$LOGIN_URL'));
request.bodyFields = {
  'phonenumber': '$phonenumber',
  'password': '$password'
};
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();


if (response.statusCode == 200) {
  String strres=await response.stream.bytesToString();
  print("Login $strres");
  var json=jsonDecode(strres);
  var success=json['success'];
  if(success==true)
    {
      LoginPreference pref=LoginPreference();
      pref.saveUserPreference(strres.toString());
      modelUser=await pref.getUserPreference();
     // print("User id ${modelUser.id}");

     Navigator.pushReplacementNamed(context, SelectService.routeName);
    }
  else
    {
      String msg=json['msg'];
      getCustomDialog(context,"Error","$msg",DialogType.ERROR,oktext: "Okay");
    }

}
else {
  getCustomDialog(context,"Network Error","Please try again later",DialogType.ERROR,oktext: "Okay");
  print(response.reasonPhrase);
}


}


  Future<void> signupAPI(String mail,String phone,String name,String otp,String password,context)async
  {
    print("sign up api ");
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(SIGNUP));
    request.bodyFields = {
      'mail': '$mail',
      'phonenumber': '$phone',
      'name': '$name',
      'password': '$password'
    };
    request.headers.addAll(headers);

    print("url $SIGNUP");
    print("request fields ${request.bodyFields.toString()}");
    http.StreamedResponse response = await request.send();
    String strres=await response.stream.bytesToString();
    print(strres);
    if (response.statusCode == 200) {

      var json=jsonDecode(strres);
      var success=json['_id'];
      if(success!=null)
      {
        LoginPreference pref=LoginPreference();
        ModelUser modelUser=ModelUser.fromJson(json);
        Vendor vendor=Vendor(sId: json['_id'],isservicelisted: "0",isshoplisted: "0",isvehiclelisted: "0");
        List<Vendor>vendorList=List();
        vendorList.add(vendor);
        modelUser.vendor=vendorList;
        //pref.saveUserPreference(strres.toString());
        pref.saveUserPreference(jsonEncode(modelUser.toJson()));
        modelUser=await pref.getUserPreference();
        Provider.of<ProviderLogin>(context,listen: false).modelUser=modelUser;
         print("User id ${modelUser.vendor[0].isshoplisted}");
        Navigator.pushReplacementNamed(context, SelectService.routeName);
      }
      else
      {
        String msg=json['message'];
        getCustomDialog(context,"Error","$msg",DialogType.ERROR,oktext: "Okay");
      }
    }
    else {
      print("Reason phase ${response.reasonPhrase}");
      getCustomDialog(context,"Error","${response.reasonPhrase}",DialogType.ERROR,oktext: "Okay");
    }
  }



List<String>getDrawerOptions()
{
  if(userType=="store")
  return drawerOptionStore;
  if(userType=="vehicle")
    return drawerOptionVehicle;
  if(userType=="service")
    return drawerOptionService;
}

}