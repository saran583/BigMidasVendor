import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bigmidasvendor/model/modelvehiclecat.dart';
import 'package:bigmidasvendor/model/modelvehicleprofile.dart';
import 'package:bigmidasvendor/model/modelvehiclsubcat.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bigmidasvendor/model/modelservicecategory.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/provider/providershop.dart';
import 'package:bigmidasvendor/screens/ListOfServiceHistory.dart';
import 'package:bigmidasvendor/screens/ListOfVichleHistory.dart';
import 'package:bigmidasvendor/sharedpreference/tempprefmimicapi.dart';
import 'package:bigmidasvendor/utils/hexcolor.dart';
import 'package:bigmidasvendor/widgets/appspecificsignaturewidgets.dart';
import 'package:bigmidasvendor/widgets/showdialog.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../common.dart';
import 'dashboard.dart';

import 'package:http/http.dart' as http;



class VehicleProfile extends StatefulWidget
{
  static String routeName="/vehicleprofile";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VehicleProfileState();
  }
}
class VehicleProfileState extends State<VehicleProfile> {
  bool isLoading = false;
  var dropdownValue;

  var customLocation;
  var _keyValidationForm = GlobalKey<FormState>();
  LocationResult result;
  String catIdSelectedForServiceListing;

//   TextEditingController controllerName=TextEditingController(text: "Mohit");
//  TextEditingController controllerLatLong=TextEditingController(text: "79.8 65.5");
//  TextEditingController controllercity=TextEditingController(text: "city");
//  TextEditingController controllerarea=TextEditingController(text: "area");
//  TextEditingController controlleraddress=TextEditingController(text: "addr");
//  TextEditingController controllercategory=TextEditingController(text: "cate");
//  TextEditingController controllerpanadhaar=TextEditingController(text: "ad");
//  TextEditingController controllertrade=TextEditingController(text: "tra");
//  TextEditingController controllerfassai=TextEditingController(text: "fassa");

  TextEditingController controllerName = TextEditingController(text: "");
  TextEditingController controllerLatLong = TextEditingController(text: "");
  TextEditingController controllercity = TextEditingController(text: "");
  TextEditingController controllerarea = TextEditingController(text: "");
  TextEditingController controlleraddress = TextEditingController(text: "");
  TextEditingController controllercategory = TextEditingController(text: "");
  TextEditingController controllerpanadhaar = TextEditingController(text: "");
  TextEditingController controllertrade = TextEditingController(text: "");
  TextEditingController controllerfassai = TextEditingController(text: "");

  TextEditingController controllerDrivingLicence = TextEditingController(text: "");
  TextEditingController controllerInsurance = TextEditingController(text: "");
  TextEditingController controllerRc = TextEditingController(text: "");
  TextEditingController controllerFC = TextEditingController(text: "");


  bool isVehicle = false;
  File docPan;
  File docDrivingLicence;
  File docInsurance;
  File docRC;
  File docFCPermit;
  File docTradeLicence;
  File docFASSAI;
  List<ModelVehicleCategory> listModelShopCategories;

  List<ModalServiceCategory> listServiceCategories;

  //ModelVehicleCategory modelVehicleCategory;

  List<ModelVehicleCategory> listModelVehicleCat;

  String vehicleCat;

  List<ModelVehicleSubCategory> listModelVehicleSubCat;

  String vehicleSubCat;

  String shopCat;

  String shopSubCat;

  ModelVehicleProfile modelVehicleProfile;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

        getVehicleCategory();


print("From Vehicle profile $modelVehicleProfile.sId");

  }


  @override
  Widget build(BuildContext context) {
    //isLoading=false;
    //getServiceCategories();
    int screen = ModalRoute
        .of(context)
        .settings
        .arguments;
    controllercity.text=modelVehicleProfile.city;
    controllerarea.text=modelVehicleProfile.area;
    controlleraddress.text=modelVehicleProfile.address;
    String title = "Your Shop Name";
    String hintText = "Enter Shop Name";
    String locationMap = "Select Current Store Location in Map";
    String locationTitle = "Store Location";
    if (screen == 2) {
      title = "Select Your Vehicle Category";
      hintText = "Enter Vehicle Category";
      locationMap = "Select Your Vehicle Type";
      locationTitle = "Vehicle Type";
      isVehicle = true;
    }
    else if (screen == 3) {
      title = "Select Your Service Category";
      hintText = "Enter Service Category";
    }

    Size size = MediaQuery
        .of(context)
        .size;
    // TODO: implement build
    return Scaffold(
        backgroundColor: HexColor("#EEEEEE"),
        //appBar: MyAppBar(),
        body: SingleChildScrollView(

            child: modelVehicleProfile==null?Center(child: CircularProgressIndicator(),):Form(
              key: _keyValidationForm,
              child:
              Card(

                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 1, bottom: 32),
                            child: Image.asset(
                              "assets/images/logo_Big_Midas.jpeg", height: 180,
                              width: 180,),
                          )
                      ),

                      getTItleWidget("$title"),

                      //else

                      Text("Category : ${modelVehicleProfile.vehicleCategory.toString().replaceAll("[", "").replaceAll("]", "")}"),
                      SizedBox(height: 20,),
                      Text("Vehicle Type : ${modelVehicleProfile.vehicleType.toString().replaceAll("[", "").replaceAll("]", "")}"),

                      getTItleWidget("City"),
                      getTextWidget(
                          "Enter City", "", size, controller: controllercity),

                      getTItleWidget("Area"),
                      getTextWidget(
                          "Enter Area", "", size, controller: controllerarea),

//                      getTItleWidget("Address"),
//                      getTextWidget("Enter Address", "", size,
//                          controller: controlleraddress),


                      SizedBox(height: 20,),
                      Container(height: 200,
                        child: ListView(scrollDirection: Axis.horizontal,
                          children: [
                            Column(children: [Text("Pan/Adhaar"),
                              Image.network("$BASE_URL_IMAGES${modelVehicleProfile.panAdhaar}",height: 100,width: 100,),],),
                            Column(children: [
                              Text("Driving License"),
                              Image.network("$BASE_URL_IMAGES${modelVehicleProfile.drivingLicense}",height: 100,width: 100,),
                            ],),
                            Column(children: [
                              Text("Rc"),
                              Image.network("$BASE_URL_IMAGES${modelVehicleProfile.rc}",height: 100,width: 100,),
                            ],),
                            Column(children: [
                              Text("Fc"),
                              Image.network("$BASE_URL_IMAGES${modelVehicleProfile.fc}",height: 100,width: 100,),
                            ],),




                          ],),
                      )
                      //getTItleWidget("Category"),

                      //getTextWidget("Select Category", "", size,
                      //  controller: controllercategory),

//                    getTItleWidget("Document"),
//
//                    GestureDetector(onTap: () {
//                      selectPan();
//                    },
//                      child:  getTextWidget("Select Pan/Adhaar", "", size,
//                          controller: controllerpanadhaar,isFieldEnabled: false,
//                          onTapped: (){
//                            print("tapped");
//                            selectPan();
//                          }),
//                    ),
//
//                    if(screen == 2)
//                      Column(children: <Widget>[
//
//                        GestureDetector(onTap: () {
//                          selectDrivingLicence();
//                        },
//                          child:  getTextWidget("Select Driving Licence", "", size,
//                              controller: controllerDrivingLicence,isFieldEnabled: false,
//                              onTapped: (){
//                                print("tapped");
//                                selectDrivingLicence();
//                              }),
//                        ),
//                        GestureDetector(onTap: () {
//                          selectInsurance();
//                        },
//                          child:  getTextWidget("Select Insurance", "", size,
//                              controller: controllerInsurance,isFieldEnabled: false,
//                              onTapped: (){
//                                print("tapped");
//                                selectInsurance();
//                              }),
//                        ),
//                        GestureDetector(onTap: () {
//                          selectRC();
//                        },
//                          child:  getTextWidget("Select RC", "", size,
//                              controller: controllerRc,isFieldEnabled: false,
//                              onTapped: (){
//                                print("tapped");
//                                selectRC();
//                              }),
//                        ),
//                        GestureDetector(onTap: () {
//                          selectFCPermit();
//                        },
//                          child:  getTextWidget("Select FC Permit(optional)", "", size,
//                              controller: controllerFC,isFieldEnabled: false,
//                              onTapped: (){
//                                print("tapped");
//                                selectFCPermit();
//                              }),
//                        ),
////                        getTextWidget("", "", size),
////                        getTextWidget("", "", size),
////                        getTextWidget("", "", size),
////                        getTextWidget("", "", size),
//                      ],
//                      ),
//                    if(screen == 1)
//                      Column(children: <Widget>[
//                        GestureDetector(onTap: (){
//                          selectTradeLicence();
//                        },child: getTextWidget("Trade Licence", "", size,
//                            controller: controllertrade,isFieldEnabled: false),),
//
//                        GestureDetector(
//                          onTap: (){
//                            selectFASSAI();
//                          },
//                          child:  getTextWidget("FSSAI Licence", "", size,
//                              controller: controllerfassai,isFieldEnabled: false),)
//                      ],
//                      ),
//
//
//                    Container(
//                      margin: EdgeInsets.all(10),
//                      child: isLoading ? Container(
//                        margin: EdgeInsets.only(top: 10),
//                        child: CircularProgressIndicator(),) : getAwesomeButton(
//                          "Register", () {
//                        String userType = Provider
//                            .of<ProviderLogin>(context, listen: false)
//                            .userType;
//                        if (userType == "store")
//                          //Navigator.pushReplacementNamed(context, DashBoard.routeName);
//                          storeRegister();
//                        else if (userType == "vehicle")
//                        {
//                          vehicleRegister();
//                        }
////                          Navigator.pushReplacementNamed(
////                              context, ListOfVichleHistory.routeName);
//                        //   Navigator.pushReplacementNamed(context, DashBoard.routeName);
//                        else
//                          //Navigator.pushReplacementNamed(context, ListOfServiceHistory.routeName);
//                          serviceRegister();
//                        //  Navigator.pushReplacementNamed(context, DashBoard.routeName);
//                      }
//                      ),
//                    ),
////                    Container(
////                      child: FlatButton(
////                        child: Text("Already have a Listing?"), onPressed: () {
////                        openDashboardAccordingly();
////                      },
////                      ),
////                    )
//
////             GestureDetector(
////               onTap: (){
////    Navigator.pushReplacementNamed(context, DashBoard.routeName);
////               },
////               child:  Container(
////               margin: EdgeInsets.only(top: 20),
////               child: getSignatureButtonShape("Register",size),),)
//

                    ],
                  ),
                )
              ),)
        )

    );
  }

  void openDashboardAccordingly() {
    String userType = Provider
        .of<ProviderLogin>(context, listen: false)
        .userType;
    if (userType == "store")
      Navigator.pushReplacementNamed(context, DashBoard.routeName);
    //storeRegister();
    else if (userType == "vehicle")
      Navigator.pushReplacementNamed(context, ListOfVichleHistory.routeName);
    //   Navigator.pushReplacementNamed(context, DashBoard.routeName);
    else
      Navigator.pushReplacementNamed(context, ListOfServiceHistory.routeName);
    //  Navigator.pushReplacementNamed(context, DashBoard.routeName);

  }

  Widget getTItleWidget(String title) {
    return Container();
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: 20, top: 15),
      child: Text("$title", style: TextStyle(fontWeight: FontWeight.bold),),);
  }

  Widget getTextWidget(String hint, String textIfAny, Size size,
      {bool isFieldEnabled, Function onTapped, TextEditingController controller,}) {
    return  Container(


      width: size.width - 80,
      height: 90,
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(left: 0, top: 10),
      child: TextFormField(


        enabled: false,
        controller: controller,
        onTap: onTapped,
        validator: (value) {

          if(hint.contains("FC Permit"))return null;
          if (value
              .trim()
              .isEmpty) return "Field can not be left blank";
          return null;
        },

        // initialValue: textIfAny,
        decoration: InputDecoration(
          labelText: '$hint',
          errorStyle: TextStyle(
            color: Theme
                .of(context)
                .errorColor, // or any other color
          ),
          //prefixIcon: Icon(Icons.email),
          // icon: Icon(Icons.perm_identity)
        ),
        style: TextStyle(color: Colors.black,),


      ),


    );
  }

  void showPlacePicker() async {
//    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
//        builder: (context) =>
//            PlacePicker("AIzaSyCWXUFR85OjCAqEhFcwfPzlZDzseNlfinM",
//              //displayLocation: customLocation,
//
//            )));
//
//    // Handle the result in your way
//
//    print(result);
//    print("map latlong $customLocation");


    result = await showLocationPicker(
      context, "AIzaSyCWXUFR85OjCAqEhFcwfPzlZDzseNlfinM",
      // context, "AIzaSyDnC5VU3OBizlcu-HY_RN4yafz8D5ZpHic",
      initialCenter: LatLng(23.2599, 77.4126),
      myLocationButtonEnabled: true,
      layersButtonEnabled: true,
      countries: ['AE', 'NG'],

    );
    print("latlong ${result.latLng.longitude}");
    controllerLatLong.text =
    "${result.latLng.latitude} ${result.latLng.longitude}";

//    Navigator.of(context).push(PageRouteBuilder(
//        opaque: false,
//        pageBuilder: (BuildContext context, _, __) =>
//            RedeemConfirmationScreen()));

  }

  void storeRegister() async {
    print("Store input validate ${_keyValidationForm.currentState.validate()}");
    if (!_keyValidationForm.currentState.validate()) return;
    setState(() {
      isLoading = true;
    });
//    await Provider.of<ProviderShop>(context, listen: false).addShop(
//        context,
//        controllerName.text,
//        controllerLatLong.text,
//        controllerarea.text,
//        controllercity.text,
//        controllerpanadhaar.text,
//        controllertrade.text,
//        controllerfassai.text,
//        controlleraddress.text,
//        controllercategory.text,
//        Provider
//            .of<ProviderLogin>(context, listen: false)
//            .modelUser
//            .sId
//    );
   // await addShop();
    setState(() {
      isLoading = false;
    });
  }



  void vehicleRegister() async {
    if (!_keyValidationForm.currentState.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    if(true){

      String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;

      String url=VEHICLE_LIST;

      print(url);
      var request = http.MultipartRequest('POST', Uri.parse(url))

        ..fields['vechicle_catgory'] = vehicleCat
        ..fields['vechicle_type'] = vehicleSubCat
        ..fields['area'] = controllerarea.text
        ..fields['city'] = controllercity.text
        ..fields['address'] = controlleraddress.text
      // ..fields['category'] = controllercategory.text
        ..fields['category'] = vehicleCat
        ..fields['vendorid'] = '$vendorId'

//          ..fields['pan_adhaar'] = '$catIdSelectedForServiceListing'
//          ..fields['driving_license'] = controllerLatLong.text
//          ..fields['rc'] = '$vendorId'
//          ..fields['insurance'] = '$vendorId'
//          ..fields['fc'] = '$vendorId'

        ..files.add(await http.MultipartFile.fromPath(
            'pan_adhaar', '${docPan.path}',
            contentType: MediaType('image', 'png')))

        ..files.add(await http.MultipartFile.fromPath(
            'driving_license', '${docPan.path}',
            contentType: MediaType('image', 'png')))

        ..files.add(await http.MultipartFile.fromPath(
            'rc', '${docPan.path}',
            contentType: MediaType('image', 'png')))

        ..files.add(await http.MultipartFile.fromPath(
            'insurance', '${docPan.path}',
            contentType: MediaType('image', 'png')))

        ..files.add(await http.MultipartFile.fromPath(
            'fc', '${docPan.path}',
            contentType: MediaType('image', 'png')));

      print(request.fields.toString());
      print(docPan.path);
      setState(() {
        isLoading=true;
      });
      var response = await request.send();
      print("REsponse of vehicle listing ${await response.stream.bytesToString()}");


      TempPrefMimicAPI tempPrefMimicAPI=TempPrefMimicAPI();
      //ModalPrefListingStatus modal=await tempPrefMimicAPI.getUserPreference();
      tempPrefMimicAPI.setListing(vehicleListed: true);

      if(response.statusCode==200){
        getCustomDialog(
            context,
            "Action Completed",
            "Vehicle Listed Successfully",
            DialogType.SUCCES,
            oktext: "Explore Orders Page",
            okFunc: (){
              Navigator.pushReplacementNamed(
                  context, ListOfVichleHistory.routeName);
            }
        );
      }
    }
//        Timer(Duration(seconds: 2),(){
//          getCustomDialog(
//              context,
//              "Action Completed",
//              "Vehicle Listed Successfully",
//              DialogType.SUCCES,
//              oktext: "Explore Orders Page",
//              okFunc: (){
//                Navigator.pushReplacementNamed(
//                    context, ListOfVichleHistory.routeName);
//              }
//          );
//        });

    // return;
    // }
//      await Provider.of<ProviderShop>(context, listen: false).addShop(
//          context,
//          controllerName.text,
//          controllerLatLong.text,
//          controllerarea.text,
//          controllercity.text,
//          controllerpanadhaar.text,
//          controllertrade.text,
//          controllerfassai.text,
//          controlleraddress.text,
//          controllercategory.text,
//          Provider
//              .of<ProviderLogin>(context, listen: false)
//              .modelUser
//              .sId
//      );
//      setState(() {
//        isLoading = false;
//      });
  }



  void serviceRegister() async {
    print('service validate ${_keyValidationForm.currentState.validate()}');
    if (!_keyValidationForm.currentState.validate()) {
      return;
    }
//      setState(() {
//        isLoading = true;
//      });
//      if(true){
//
//        Timer(Duration(seconds: 2),(){
//          getCustomDialog(
//              context,
//              "Action Completed",
//              "Service Listed Successfully",
//              DialogType.SUCCES,
//              oktext: "Explore Orders Page",
//              okFunc: (){
//                Navigator.pushNamed(context, ListOfServiceHistory.routeName);
//              }
//          );
//        });
//
//        return;
//      }
//
//      await Provider.of<ProviderShop>(context, listen: false).addShop(
//          context,
//          controllerName.text,
//          controllerLatLong.text,
//          controllerarea.text,
//          controllercity.text,
//          controllerpanadhaar.text,
//          controllertrade.text,
//          controllerfassai.text,
//          controlleraddress.text,
//          controllercategory.text,
//          Provider
//              .of<ProviderLogin>(context, listen: false)
//              .modelUser
//              .sId
//      );
//

    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;

    String url=SERVICE_LIST;

    print(url);
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['service_category'] = '$catIdSelectedForServiceListing'
      ..fields['location_map'] = controllerLatLong.text
      ..fields['area'] = controllerarea.text
      ..fields['city'] = controllercity.text
      ..fields['address'] = controlleraddress.text
    //..fields['category'] = controllercategory.text
      ..fields['category'] = catIdSelectedForServiceListing
      ..fields['vendorid'] = '$vendorId'

      ..files.add(await http.MultipartFile.fromPath(
          'pan_adhaar', '${docPan.path}',
          contentType: MediaType('image', 'png')));

    print(request.fields.toString());
    print(docPan.path);
    setState(() {
      isLoading=true;
    });
    var response = await request.send();
    setState(() {
      isLoading=false;
    });
    print(response);
    if (response.statusCode == 200) {
      TempPrefMimicAPI tempPrefMimicAPI=TempPrefMimicAPI();
      //ModalPrefListingStatus modal=await tempPrefMimicAPI.getUserPreference();
      tempPrefMimicAPI.setListing(serviceListed: true);
      print(await response.stream.bytesToString());
      getCustomDialog(
          context,
          "Action Completed",
          "Service Listed Successfully",
          DialogType.SUCCES,
          oktext: "Explore Orders Page",
          okFunc: (){
            Navigator.pushReplacementNamed(context, ListOfServiceHistory.routeName);
          }
      );

    }
    else {
      print(response.reasonPhrase);
    }

    setState(() {
      isLoading = false;
    });
  }

  void selectPan() async {
    FilePicker filePicker = FilePicker.platform;
    Set allowedExtension = Set();
    allowedExtension.add("PDF");
    allowedExtension.add("pdf");
    FilePickerResult pickedFile=await filePicker.pickFiles(allowMultiple: false);
    controllerpanadhaar.text=pickedFile.files[0].path.split('/').last;
    docPan=File(pickedFile.files[0].path);

    print(docPan.uri);
    //File.
  }


  void selectDrivingLicence() async {
    FilePicker filePicker = FilePicker.platform;
    Set allowedExtension = Set();
    allowedExtension.add("PDF");
    allowedExtension.add("pdf");
    FilePickerResult pickedFile=await filePicker.pickFiles(allowMultiple: false);
    controllerDrivingLicence.text=pickedFile.files[0].path.split('/').last;
    docDrivingLicence=File(pickedFile.files[0].path);
    print(docPan.uri);
    //docPan=pickedFile.files[0].path;
    //File.
  }


  void selectInsurance() async {
    FilePicker filePicker = FilePicker.platform;
    Set allowedExtension = Set();
    allowedExtension.add("PDF");
    allowedExtension.add("pdf");
    FilePickerResult pickedFile=await filePicker.pickFiles(allowMultiple: false);
    controllerInsurance.text=pickedFile.files[0].path.split('/').last;
    docInsurance=File(pickedFile.files[0].path);
    print(docPan.uri);
    //docPan=pickedFile.files[0].path;
    //File.
  }


  void selectRC() async {
    FilePicker filePicker = FilePicker.platform;
    Set allowedExtension = Set();
    allowedExtension.add("PDF");
    allowedExtension.add("pdf");
    FilePickerResult pickedFile=await filePicker.pickFiles(allowMultiple: false);
    controllerRc.text=pickedFile.files[0].path.split('/').last;
    docRC=File(pickedFile.files[0].path);
    print(docPan.uri);
    //docPan=pickedFile.files[0].path;
    //File.
  }


  void selectFCPermit() async {
    FilePicker filePicker = FilePicker.platform;
    Set allowedExtension = Set();
    allowedExtension.add("PDF");
    allowedExtension.add("pdf");
    FilePickerResult pickedFile=await filePicker.pickFiles(allowMultiple: false);
    controllerFC.text=pickedFile.files[0].path.split('/').last;
    docFCPermit=File(pickedFile.files[0].path);
    print(docPan.uri);
    //docPan=pickedFile.files[0].path;
    //File.
  }

  void selectTradeLicence() async {
    FilePicker filePicker = FilePicker.platform;
    Set allowedExtension = Set();
    allowedExtension.add("PDF");
    allowedExtension.add("pdf");
    FilePickerResult pickedFile=await filePicker.pickFiles(allowMultiple: false);
    docTradeLicence=File(pickedFile.files[0].path);
    controllertrade.text=pickedFile.files[0].path.split('/').last;
    //docPan=pickedFile.files[0].path;
    //File.
  }

  void selectFASSAI() async {
    FilePicker filePicker = FilePicker.platform;
    Set allowedExtension = Set();
    allowedExtension.add("PDF");
    allowedExtension.add("pdf");
    FilePickerResult pickedFile=await filePicker.pickFiles(allowMultiple: false);
    docFASSAI=File(pickedFile.files[0].path);
    controllerfassai.text=pickedFile.files[0].path.split('/').last;
    //docPan=pickedFile.files[0].path;
    //File.
  }

  void getServiceCategories() async{
    print("calling service categories $SERVICE_CATEGORIES");
    var request = http.Request('GET', Uri.parse(SERVICE_CATEGORIES));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strRes=await response.stream.bytesToString();
      print(strRes);

      List<dynamic>serviceCategories=jsonDecode(strRes);
      listServiceCategories=List();
      for(int i=0;i<serviceCategories.length;i++){
        print(serviceCategories[i]);
        print(ModalServiceCategory.fromJson(serviceCategories[i]).catName);
        listServiceCategories.add(ModalServiceCategory.fromJson(serviceCategories[i]));
      }
      setState(() {

      });

    }
    else {
      print(response.reasonPhrase);
    }

  }

  void getVehicleCategory() async{

    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    String url='$VEHICLE_LIST/$vendorId';
    var request = http.Request('GET', Uri.parse(url));
    print("this is the url $url");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strRes = await response.stream.bytesToString();
      print("this is string $strRes");
      List<dynamic>list = json.decode(strRes);
      print("list json decode $list");
      print("list json decode ${list.length}");
      listModelVehicleCat = List();

      for (int i = 0; i < list.length; i++){
        print("this is ${list[i]} ");
      //  listModelVehicleCat.add(ModelVehicleCategory.fromJson(list[i]));
         modelVehicleProfile=ModelVehicleProfile.fromJson(list[i]);
         print("this is model $modelVehicleProfile");
      }

      print("vehicle cate ${modelVehicleProfile.area}");
      setState(() {

      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
  void getVehicleSubCategory() async{
    String url="$VEHICLE_SUBCAT$vehicleCat";
    var request = http.Request('GET', Uri.parse(url));

    print("sub cat url $url");
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strRes = await response.stream.bytesToString();
      print(strRes);
      List<dynamic>list = json.decode(strRes);
      print("list json decode $list");
      print("list json decode ${list.length}");
      listModelVehicleSubCat = List();
      for (int i = 0; i < list.length; i++){
        print(list[i]);
        listModelVehicleSubCat.add(ModelVehicleSubCategory.fromJson(list[i]));
      }


      print("vehicle cate ${listModelVehicleCat.length}");
      setState(() {

      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

  void getShopCategory() async{
    var request = http.Request('GET', Uri.parse('$SHOP_CAT'));
    print("get shop category $SHOP_CAT");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strRes = await response.stream.bytesToString();
      print(strRes);
      List<dynamic>list = json.decode(strRes);
      print("list json decode $list");
      print("list json decode ${list.length}");
      listModelShopCategories = List();
      for (int i = 0; i < list.length; i++){
        print(list[i]);
        listModelShopCategories.add(ModelVehicleCategory.fromJson(list[i]));
      }


      print("shop cate ${listModelShopCategories.length}");
      setState(() {

      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

  void getShopSubCategory() async{
    //String url=SHOP_SUBCAT+"6059e6a3f458ca7893a231aa";
    String url=SHOP_SUBCAT+"$shopCat";
    var request = http.Request('GET', Uri.parse(url));

    print("sub cat url $url");
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strRes = await response.stream.bytesToString();
      print(strRes);
      List<dynamic>list = json.decode(strRes);
      print("list json decode $list");
      print("list json decode ${list.length}");
      listModelVehicleSubCat = List();
      for (int i = 0; i < list.length; i++){
        print(list[i]);
        listModelVehicleSubCat.add(ModelVehicleSubCategory.fromJson(list[i]));
      }


      print("vehicle cate ${listModelVehicleSubCat.length}");

      setState(() {
        controllercity.text=modelVehicleProfile.city;
        controllerarea.text=modelVehicleProfile.area;
        controlleraddress.text=modelVehicleProfile.address;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

}
class RedeemConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      body:  PlacePicker(
        apiKey: "AIzaSyDnC5VU3OBizlcu-HY_RN4yafz8D5ZpHic",   // Put YOUR OWN KEY here.
        onPlacePicked: (result) {
          print(result.adrAddress);
          Navigator.of(context).pop();
        },

        useCurrentLocation: true,
      ),
    );
  }
}