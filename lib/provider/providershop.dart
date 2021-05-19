import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bigmidasvendor/model/modelproduct.dart';
import 'package:bigmidasvendor/model/modelshoporders.dart';
import 'package:http_parser/http_parser.dart';



import 'package:async/async.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/screens/dashboard.dart';
import 'package:bigmidasvendor/widgets/showdialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../common.dart';

class ProviderShop with ChangeNotifier
{
  ModelShopOrders modelShopOrders;

  ModelProducts modelProducts;

  Future<void>addShop(
      context,
      String shopName,
      String latlong,
      String area,
      String city,
      String pan_adhaar,
      String tradelicence,
      String fassai,
      String address,
      String cat,
      String vendorid)async
  {
    print("provider store listing");
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(SHOP_CREATE));
    request.bodyFields = {
      'shop_name': '$shopName',
      'location_map': '$latlong',
      'area': '$area',
      'city': '$city',
      'pan_adhaar': '$pan_adhaar',
      'trade_licence': '$tradelicence',
      'fssai_licence': '$fassai',
      'address': '$address',
      'category': '$cat',
      'vendorid': '$vendorid'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
  print(response.stream.bytesToString());
    if (response.statusCode == 200) {

      String strres=await response.stream.bytesToString();
      print(strres);
      var json=jsonDecode(strres);
      var success=json['_id'];
      if(success!=null)
      {
        getCustomDialog(
            context,
            "Action Completed",
            "Shop Listed Successfully",
            DialogType.SUCCES,
          oktext: "Explore Orders Page",
            okFunc: (){
          Navigator.pushReplacementNamed(context, DashBoard.routeName);
        }
        );
      }
      else
      {
        String msg=json['message'];
        getCustomDialog(context,"Error","$msg",DialogType.ERROR,oktext: "Okay");
      }
  }
  else {
  print(response.reasonPhrase);
  }

  }

  Future<void>addProduct(
      context,
      String pName,
      String cat,
      String subcat,
      String prodcost,
      String discost,
      String unit,
      String stock,
      String desc,
      File files,
      String url,

      )async
  {
    var headers = {
      'Content-Type': 'application/form-data'
    };

   // String url="http://162.241.201.237:7420/store/products";

  //  var request = http.MultipartRequest('POST', Uri.parse(url));
//    request.fields.addAll({
//      'productname': '$pName',
//      'category': '$cat',
//      'subcategory': '$subcat',
//      'prodctcost': '$prodcost',
//      'discountedprodprice': '$discost',
//      'vendorid': Provider.of<ProviderLogin>(context,listen: false).modelUser.id,
//      'unit': '$unit',
//      'stock': '$stock',
//      'description': '$desc'
//    });
//    print(await files.exists());

   // request.files.add(await http.MultipartFile.fromPath('prodphoto', files.path));
//    request.files.add(
//        http.MultipartFile(
//            'prodphoto',
//            File(files.path).readAsBytes().asStream(),
//            File(files.path).lengthSync(),
//            filename: files.path.split("/").last
//        ));
   // http.StreamedResponse response = await request.send();

//    String fileName = files.path.split('/').last;
//
//    FormData formData = FormData.fromMap({
//      "prodphoto":
//      await MultipartFile.fromFile(files.path, filename:fileName),
//      'productname': '$pName',
//      'category': '$cat',
//      'subcategory': '$subcat',
//      'prodctcost': '$prodcost',
//      'discountedprodprice': '$discost',
//      'vendorid': Provider.of<ProviderLogin>(context,listen: false).modelUser.id,
//      'unit': '$unit',
//      'stock': '$stock',
//      'description': '$desc'
//    });
  //  Dio dio = new Dio();

   // var response = await dio.post("$url", data: formData);
  //  print(response.data.toString());
    // response.data['id'];
//    if (response.statusCode == 200) {
//      print(await response.stream.bytesToString());
//    }
//    else {
//      print(response.reasonPhrase);
//    }
    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
   // vendorId="Testing";
print("adding url $url $vendorId");
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri)
      ..fields['productname'] = '$pName'
      ..fields['category'] = '$cat'
      ..fields['subcategory'] = '$subcat'
      ..fields['prodctcost'] = '$prodcost'
      ..fields['discountedprodprice'] = '$discost'
      ..fields['vendorid'] = vendorId
      ..fields['unit'] = '$unit'
      ..fields['stock'] = '$stock'
      ..fields['description'] = '$desc'
      ..files.add(await http.MultipartFile.fromPath(
          'prodphoto', '${files.path}',
          contentType: MediaType('image', 'png')));

    print(request.fields.toString());
    var response = await request.send();
    if (response.statusCode == 200) {
    //  print('Uploaded!');
      getCustomDialog(context, "Request processed", "Product Added",DialogType.SUCCES);
    }
    else
      {
        getCustomDialog(context, "Unable to prcess request", "${response.reasonPhrase}",DialogType.SUCCES);
      }

  }


  bool isLoadingOrders=true;
  Future<void>getOrders(BuildContext context,String filter)async//0 for all , 1 pending , 2 confirm , 3 delivered
  {

    int filterByInt=0;
    if(filter=="Pending Orders")
      filterByInt=1;
    if(filter=="Confirmed Orders")
      filterByInt=2;
    if(filter=="Delivered Orders")
      filterByInt=3;
    if(filter=="Completed Booking")
      filterByInt=3;

    modelShopOrders=null;
    isLoadingOrders=true;
    notifyListeners();
   // var request = http.Request('GET', Uri.parse('http://162.241.201.237:7420/store/ordersbyvendor/60334e60e7250757e7a45062&&0'));
String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
//vendorId="60334e60e7250757e7a45062";
//String url='http://162.241.201.237:7420/store/ordersbyvendor/$vendorId&&$filterByInt';
    String url=STORE_ORDERS+'/$vendorId&&$filterByInt';
print("get orders url $url");
var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strResponse=await response.stream.bytesToString();
      print(strResponse);
       modelShopOrders=ModelShopOrders.fromJson(json.decode(strResponse));
       isLoadingOrders=false;
       notifyListeners();
  }
  else {
  print(response.reasonPhrase);
  isLoadingOrders=false;
  notifyListeners();
  }

  }

  bool isLoadingProducts=true;
  void getProductsByVendorId(BuildContext context) async{
    modelProducts=null;
    isLoadingProducts=true;
    notifyListeners();
    String vendorId=Provider.of<ProviderLogin>(context,listen: false).modelUser.sId;
  //  vendorId="60334e60e7250757e7a45062";
    String url='$GET_PRODUCTS_BY_VENDOR$vendorId';

    print("Getting all products $url");
    var request = http.Request('GET', Uri.parse(url));


    http.StreamedResponse response = await request.send();

    isLoadingProducts=false;

    if (response.statusCode == 200) {
      String res=await response.stream.bytesToString();
       modelProducts=ModelProducts.fromJson(json.decode(res));
      log(res);
      notifyListeners();
    }
    else {
      print(response.reasonPhrase);
      notifyListeners();
    }

  }

  void deleteProduct(BuildContext context,pid) async{
    //modelProducts=null;
    isLoadingProducts=true;
    notifyListeners();
   // String vendorId=Provider.of<ProviderLogin>(context,listen: false).modelUser.sId;
    //  vendorId="60334e60e7250757e7a45062";
    String url='$DELETE_PRODUCT$pid';

    print("Getting all products $url");
    var request = http.Request('DELETE', Uri.parse(url));


    http.StreamedResponse response = await request.send();

    isLoadingProducts=false;

    if (response.statusCode == 200) {
      String res=await response.stream.bytesToString();
    // getCustomDialog(context, "Product Deleted", "Request Successfull", DialogType.INFO);
      //getProductsByVendorId(context);
      for(int i=0;i<modelProducts.products.length;i++)

        if(modelProducts.products[i].sId==pid)
          {
            modelProducts.products.removeAt(i);
          }

      notifyListeners();
    }
    else {
      print(response.reasonPhrase);
      notifyListeners();
    }

  }


}