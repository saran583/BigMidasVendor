import 'dart:convert';

import 'package:bigmidasvendor/model/modeluser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempPrefMimicAPI
{
  String prefKeyStoreListed="storelisted";
  String prefKeyVehicleListed="vehiclelisted";
  String prefKeyServiceListed="serviceListed";
  String prefKeyStoreActive="storeactive";
  String prefKeyVehicleActive="vehicleactive";
  String prefKeyServiceActive="serviceactive";

  void deleteUserPreference()async
  {

    SharedPreferences shared_User = await SharedPreferences.getInstance();
    //Map decode_options = jsonDecode(jsonString);
    //ModelUser modelUser=ModelUser.fromJson(decode_options);
    //modelUser.userType=""
    //String user = jsonEncode();
    await shared_User.remove(prefKeyStoreListed);
    await shared_User.remove(prefKeyVehicleListed);
    await shared_User.remove(prefKeyServiceListed);
    await shared_User.remove(prefKeyStoreActive);
    await shared_User.remove(prefKeyVehicleActive);
    await shared_User.remove(prefKeyServiceActive);
  }

  void setListing({bool storeListed,bool vehicleListed,bool serviceListed,bool storeActive,bool vehicleActive,bool serviceActive,})async
  {

    print("set listing ");
    SharedPreferences pref = await SharedPreferences.getInstance();

    if(storeListed!=null)
      pref.setBool(prefKeyStoreListed, storeListed);
    if(vehicleListed!=null)
      pref.setBool(prefKeyVehicleListed, vehicleListed);
    if(serviceListed!=null)
      pref.setBool(prefKeyServiceListed, serviceListed);

    print(storeActive);
    if(storeActive!=null)
      pref.setBool(prefKeyStoreActive, storeActive);
    if(vehicleActive!=null)
      pref.setBool(prefKeyVehicleActive, vehicleActive);
    if(serviceActive!=null)
      pref.setBool(prefKeyServiceActive, serviceActive);


  }

  Future<ModalPrefListingStatus> getUserPreference()async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ModalPrefListingStatus modalPrefListingStatus=ModalPrefListingStatus();
    modalPrefListingStatus.storeListed=pref.getBool(prefKeyStoreListed);
    modalPrefListingStatus.vehicleListed=pref.getBool(prefKeyVehicleListed);
    modalPrefListingStatus.serviceListed=pref.getBool(prefKeyServiceListed);
    modalPrefListingStatus.storeActive=pref.getBool(prefKeyStoreActive);
    modalPrefListingStatus.vehicleActive=pref.getBool(prefKeyVehicleActive);
    modalPrefListingStatus.serviceActive=pref.getBool(prefKeyServiceActive);
    return modalPrefListingStatus;
  }



}

class ModalPrefListingStatus{
bool storeListed;
bool vehicleListed;
bool serviceListed;
bool storeActive;
bool vehicleActive;
bool serviceActive;
}