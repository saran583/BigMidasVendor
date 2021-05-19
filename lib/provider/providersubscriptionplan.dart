import 'dart:convert';


import 'package:bigmidasvendor/common.dart';
import 'package:bigmidasvendor/model/modalmycurrentsubs.dart';
import 'package:bigmidasvendor/model/modalsubplan.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProviderSubscriptionPlans with ChangeNotifier {
  List<ModalSubsPlans> listModalSubsPlans=List();

  ModalMySubs modalMySubs;




Future<void>getupdatedSubscription(String vendorId,BuildContext context)async {

  vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
  //String url='http://162.241.201.237:7420/store/subscription/$vendorId';
  print("get subscritpion");
  if(Provider.of<ProviderLogin>(context,listen:false).userType=="store"){
  String url=SUBSCRIPTION+"/"+vendorId;
  print(url);
  var request = http.Request('GET', Uri.parse(url));
  request.bodyFields = {};

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String res=await response.stream.bytesToString();
    print(res);

    if(res=='[]'){
      modalMySubs=ModalMySubs();
      modalMySubs.sId=vendorId;
      modalMySubs.daysremaining=0;
      modalMySubs.totaldayssubscribed=0;
      notifyListeners();
      print("These are the number of days remaining ${modalMySubs.daysremaining}");
      return modalMySubs.daysremaining;
    }
     modalMySubs=ModalMySubs.fromJson(json.decode(res)[0]);
    print(modalMySubs.daysremaining);
    notifyListeners();
}
else {
print(response.reasonPhrase);
}
  }

  else if(Provider.of<ProviderLogin>(context,listen:false).userType=="service"){
  String url=SUBSCRIPTION_SERVICE+"/"+vendorId;
  print(url);
  var request = http.Request('GET', Uri.parse(url));
  request.bodyFields = {};

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String res=await response.stream.bytesToString();
    print(res);

    if(res=='[]'){
      modalMySubs=ModalMySubs();
      modalMySubs.sId=vendorId;
      modalMySubs.daysremaining=0;
      modalMySubs.totaldayssubscribed=0;
      notifyListeners();
      return modalMySubs.daysremaining;
    }
     modalMySubs=ModalMySubs.fromJson(json.decode(res)[0]);
    print(modalMySubs.daysremaining);
    notifyListeners();
}
else {
print(response.reasonPhrase);
}
  }

  if(Provider.of<ProviderLogin>(context,listen:false).userType=="vehicle"){
  String url=SUBSCRIPTION_VEHICLE+"/"+vendorId;
  print(url);
  var request = http.Request('GET', Uri.parse(url));
  request.bodyFields = {};

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String res=await response.stream.bytesToString();
    print(res);

    if(res=='[]'){
      modalMySubs=ModalMySubs();
      modalMySubs.sId=vendorId;
      modalMySubs.daysremaining=0;
      modalMySubs.totaldayssubscribed=0;
      notifyListeners();
      return modalMySubs.daysremaining;
    }
     modalMySubs=ModalMySubs.fromJson(json.decode(res)[0]);
    print(modalMySubs.daysremaining);
    notifyListeners();
}
else {
print(response.reasonPhrase);
}
  }


}




Future<void>getMyCurrentSubscription(String vendorId,BuildContext context)async
{

  vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
  //String url='http://162.241.201.237:7420/store/subscription/$vendorId';
  print("get subscritpion");
  if(Provider.of<ProviderLogin>(context,listen:false).userType=="store"){
  String url=SUBSCRIPTION+"/"+vendorId;
  print(url);
  var request = http.Request('GET', Uri.parse(url));
  request.bodyFields = {};

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String res=await response.stream.bytesToString();
    print(res);

    if(res=='[]'){
      modalMySubs=ModalMySubs();
      modalMySubs.sId=vendorId;
      modalMySubs.daysremaining=0;
      modalMySubs.totaldayssubscribed=0;
      notifyListeners();
      print("These are teh number of days remaining ${modalMySubs.daysremaining}");
      return ;
    }
     modalMySubs=ModalMySubs.fromJson(json.decode(res)[0]);
    print(modalMySubs.daysremaining);
    notifyListeners();
}
else {
print(response.reasonPhrase);
}
  }

 else if(Provider.of<ProviderLogin>(context,listen:false).userType=="service"){
  String url=SUBSCRIPTION_SERVICE+"/"+vendorId;
  print(url);
  var request = http.Request('GET', Uri.parse(url));
  request.bodyFields = {};

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String res=await response.stream.bytesToString();
    print(res);

    if(res=='[]'){
      modalMySubs=ModalMySubs();
      modalMySubs.sId=vendorId;
      modalMySubs.daysremaining=0;
      modalMySubs.totaldayssubscribed=0;
      notifyListeners();
      return;
    }
     modalMySubs=ModalMySubs.fromJson(json.decode(res)[0]);
    print(modalMySubs.daysremaining);
    notifyListeners();
}
else {
print(response.reasonPhrase);
}
  }

  if(Provider.of<ProviderLogin>(context,listen:false).userType=="vehicle"){
  String url=SUBSCRIPTION_VEHICLE+"/"+vendorId;
  print(url);
  var request = http.Request('GET', Uri.parse(url));
  request.bodyFields = {};

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String res=await response.stream.bytesToString();
    print(res);

    if(res=='[]'){
      modalMySubs=ModalMySubs();
      modalMySubs.sId=vendorId;
      modalMySubs.daysremaining=0;
      modalMySubs.totaldayssubscribed=0;
      notifyListeners();
      return;
    }
     modalMySubs=ModalMySubs.fromJson(json.decode(res)[0]);
    print(modalMySubs.daysremaining);
    notifyListeners();
}
else {
print(response.reasonPhrase);
}
  }



}


  Future<void> getPlans(context) async {
    String userType = Provider
        .of<ProviderLogin>(context, listen: false)
        .userType;


    String url;
    if(userType=="store")
      url=SUBSCRIPTION_PLAN_STORE;
    else if(userType=="vehicle")
      url=SUBSCRIPTION_PLAN_VEHICLE;
    else
      url=SUBSCRIPTION_PLAN_SERVICE;
  listModalSubsPlans.clear();
    var request = http.Request('GET',
        Uri.parse(url));

    print('subscription plan $url');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      List<dynamic>listOfPlans = json.decode(res);
      for (int i = 0; i < listOfPlans.length; i++) {
        listModalSubsPlans.add(ModalSubsPlans.fromJson(listOfPlans[i]));
      }

      notifyListeners();
    }

//
//    else {
//
//    }
  }

  Future<void> updatePlan(context,String planId,String status) async {
    String userType = Provider
        .of<ProviderLogin>(context, listen: false)
        .userType;

    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    String url;
    if(userType=="store")
      url=UPDATE_SUBSCRIPTION_STORE;
    else if(userType=="vehicle")
      url=UPDATE_SUBSCRIPTION_VEHICLE;
    else
      url=UPDATE_SUBSCRIPTION_SERVICE;
    // url=url+""+vendorId;

    var request = http.Request('POST', Uri.parse(url));
    request.bodyFields = {
      "plan_id": planId,
      "vendor_id": vendorId,
      "payment_status":status
      };
    // request.headers.addAll(headers);
    // print("subscription update plan ${url} ${request.body.toString()}");
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

      notifyListeners();
    }

//
//    else {
//
//    }

}