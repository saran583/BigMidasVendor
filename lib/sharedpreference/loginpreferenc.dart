import 'dart:convert';

import 'package:bigmidasvendor/model/modeluser.dart';
import 'package:bigmidasvendor/sharedpreference/tempprefmimicapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPreference
{
  String keyUser="user";

  String keyCatId="catid";
  void saveShopCategoryId(String saveShopCategoryId) async{
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    //Map decode_options = jsonDecode(jsonString);
    //ModelUser modelUser=ModelUser.fromJson(decode_options);
    //modelUser.userType=""
    //String user = jsonEncode();
    shared_User.setString(keyCatId, saveShopCategoryId);
    print("saving cat id $saveShopCategoryId and saved ${await getShopCatId()}");
  }

  Future<String> getShopCatId()async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref==null||pref.getString(keyCatId)==null)return null;

   return pref.getString(keyCatId);
  }


  void saveUserPreference(String jsonString)async
  {
    print("saving user pref $jsonString");
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    //Map decode_options = jsonDecode(jsonString);
    //ModelUser modelUser=ModelUser.fromJson(decode_options);
    //modelUser.userType=""
    //String user = jsonEncode();
    shared_User.setString(keyUser, jsonString);
  }
  Future<ModelUser> getUserPreference()async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref==null||pref.getString(keyUser)==null)return null;
    Map json = jsonDecode(pref.getString(keyUser));
    ModelUser user = ModelUser.fromJson(json);
    return user;
  }

  void deleteUserPreference()async
  {

    SharedPreferences shared_User = await SharedPreferences.getInstance();
    //Map decode_options = jsonDecode(jsonString);
    //ModelUser modelUser=ModelUser.fromJson(decode_options);
    //modelUser.userType=""
    //String user = jsonEncode();
   await shared_User.remove(keyUser);
    TempPrefMimicAPI tempPrefMimicAPI=TempPrefMimicAPI();
    tempPrefMimicAPI.deleteUserPreference();
  }

}