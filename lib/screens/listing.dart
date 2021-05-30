import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bigmidasvendor/model/modeluser.dart';
import 'package:bigmidasvendor/model/modelvehiclecat.dart';
import 'package:bigmidasvendor/model/modelvehicleprofile.dart';
import 'package:bigmidasvendor/model/modelvehiclsubcat.dart';
import 'package:bigmidasvendor/sharedpreference/loginpreferenc.dart';
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



class Listing extends StatefulWidget
{
  static String routeName="/payment";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListingState();
  }
}
class ListingState extends State<Listing> {
  bool isLoading = false;
  var dropdownValue;

  ModelVehicleProfile vehicles;
  var fc=0;
   File files;
  TextEditingController controllerPhotos=TextEditingController();
  List<File>Photos=List();
  var customLocation;
  bool showimgerr=false;
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
  TextEditingController controllerPrice= TextEditingController(text: "");

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



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      int screen = ModalRoute
          .of(context)
          .settings
          .arguments;
      if(screen==3)
        getServiceCategories();
      if(screen==2)
        {
        getVehicleCategory();
        }
      if(screen==1)
      {
        getShopCategory();
      }
    });



  }


  @override
  Widget build(BuildContext context) {
    //isLoading=false;
    //getServiceCategories();
    int screen = ModalRoute
        .of(context)
        .settings
        .arguments;

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

            child: Form(
              key: _keyValidationForm,
              child:
              Card(

                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Column(


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
                    if(screen==1)
                    getTextWidget("$title", "$hintText", size,
                        controller: controllerName),
                    if(screen==1)
                      listModelShopCategories==null
                          ?Container(
                        margin: EdgeInsets.only(top: 10),
                        child: CircularProgressIndicator(),)
                          :listModelShopCategories.length==0?Text("No Categories Found"):
                      Container(
                        padding: EdgeInsets.only(top: 10,left: 20,right: 20),
                        child:DropdownButtonFormField<ModelVehicleCategory>(
                          validator: (value){
                            print("Store validator $value");
                            if(value==null||value.toString().trim().isEmpty)return "Please Select Category";
                            return null;
                          },
                          isExpanded: true,
                          hint: Text("Select Shop Category"),
                          items:listModelShopCategories.map((ModelVehicleCategory value) {
                            return new DropdownMenuItem<ModelVehicleCategory>(
                              value: value,
                              child: new Text(value.catName),
                            );
                          }).toList(),
                          onChanged: (val) {
                            print("on change $val");
                            //catIdSelectedForServiceListing=val.sId;
                            shopCat=val.sId;
                            setState(() {
                              listModelVehicleSubCat=null;
                            });

                            // getShopSubCategory();



                          },
                        ) ,
                      ),
                    if(screen==2)
                      listModelVehicleCat==null
                          ?Container(child: CircularProgressIndicator(),)
                          :listModelVehicleCat.length==0?Text("No Categories Found"):
                      Container(
                        padding: EdgeInsets.only(top: 10,left: 20,right: 20),
                        child:DropdownButtonFormField<ModelVehicleCategory>(
                          isExpanded: true,
                          hint: Text("Select Vehicle Category"),
                          items:listModelVehicleCat.map((ModelVehicleCategory value) {
                            return new DropdownMenuItem<ModelVehicleCategory>(
                              value: value,
                              child: new Text(value.catName),
                            );
                          }).toList(),
                          validator: (value){
                            if(value==null||value.toString().trim().isEmpty)return "Please select category";
                                return null;
                          },
                          onChanged: (val) {
                            print("on change $val");
                            //catIdSelectedForServiceListing=val.sId;
                            vehicleCat=val.sId;
                            setState(() {
                              listModelVehicleSubCat=null;
                            });

                            getVehicleSubCategory();

                          },
                        ) ,
                      )
                    else if(screen==3)
                      listServiceCategories==null?Container(child: CircularProgressIndicator(),):listServiceCategories.length==0?Text("No Categories Found"):
                      Container(
                        padding: EdgeInsets.all(10),
                        child:DropdownButtonFormField<ModalServiceCategory>(
                          isExpanded: true,
                          hint: Text("Select Service Category"),
                          items:listServiceCategories.map((ModalServiceCategory value) {
                            return new DropdownMenuItem<ModalServiceCategory>(
                              value: value,
                              child: new Text(value.catName),
                            );
                          }).toList(),
                          validator: (val){
                            print('service validator $val');
                            if(val==null||val.toString().trim().isEmpty)return "Select Category";
                            else
                              return null;
                          },
                          onChanged: (val) {
                            print("on change $val");
                            catIdSelectedForServiceListing=val.sId;
                            // _keyValidationForm.currentState.validate();

                          },
                        ) ,
                      ),
                    getTItleWidget("$locationTitle"),

                    //if(screen==2||screen==1)
                    if(screen==2)
                      listModelVehicleSubCat==null
                          ?Container()
                          :listModelVehicleSubCat.length==0?Container(child: Text("No Sub-Categories Found",style: TextStyle(color: Colors.red),),margin: EdgeInsets.only(top: 20),):
                      Container(
                        padding: EdgeInsets.only(top: 10,left: 20,right: 20),
                        child:DropdownButtonFormField<ModelVehicleSubCategory>(
                          isExpanded: true,
                          hint: screen==2?Text("Select Vehicle Sub-Category"):Text("Select Shop Sub-Category"),
                          items:listModelVehicleSubCat.map((ModelVehicleSubCategory value) {
                            return new DropdownMenuItem<ModelVehicleSubCategory>(
                              value: value,
                              child: new Text(value.subCatName),
                            );
                          }).toList(),
                          validator: (value){
                            if(value==null||value.toString().trim().isEmpty)return "Please select category";
                            return null;
                          },
                          onChanged: (val) {
                            print("on change $val");
                            //catIdSelectedForServiceListing=val.sId;
                            //vehicleCat=val.sId;
                            if(screen==1)
                              shopSubCat=val.sId;
                            if(screen==2)
                            vehicleSubCat=val.sId;

                          },
                        ) ,
                      ),
                    if(screen==1||screen==3)
                    GestureDetector(onTap: () {
                      showPlacePicker();
                      print("tapped");
                    },
                        child: getTextWidget(
                            "$locationMap", "", size, onTapped: () {
                          //if(locationMap=="Select Current Store Location in Map")
                          if (!isVehicle) {
                            print("tapped place picker");
                            showPlacePicker();
                          }
                        },
                            controller: controllerLatLong,
                            isFieldEnabled: isVehicle)
                    ),

                    getTItleWidget("City"),
                    getTextWidget(
                        "Enter City", "", size, controller: controllercity),

                    getTItleWidget("Area"),
                    getTextWidget(
                        "Enter Area", "", size, controller: controllerarea),

                    getTItleWidget("Address"),
                    getTextWidget("Enter Address", "", size,
                        controller: controlleraddress),
                    if(screen==2||screen==3)
                      getTextWidget("Enter Price", "", size,
                          controller: controllerPrice),


                    getTItleWidget("Category"),
                    //getTextWidget("Select Category", "", size,
                      //  controller: controllercategory),

                    getTItleWidget("Document"),

                    GestureDetector(onTap: () {
                     selectPan();
                    },
                        child:  getTextWidget("Select Pan/Adhaar", "", size,
                        controller: controllerpanadhaar,isFieldEnabled: false,
                    onTapped: (){
                      print("tapped");
                      selectPan();
                    }),
                    ),
                    if(screen==3)
                    Column(children:[
                    Align(alignment: Alignment.bottomLeft, 
                child: Padding(padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),  child:Text("Your Service Photos", textAlign: TextAlign.left,  style: TextStyle(fontSize: 16, color: Colors.black ),),),),
                      Container(height: 180,
            child:   ListView(

              scrollDirection: Axis.horizontal,
              children: [
                for(int i=0;i<Photos.length;i++)
                  Column(children: [


                    Container(child: Image.file(Photos[i],height: 120,width: 120,fit: BoxFit.fill,),margin: EdgeInsets.only(left: 10),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          Photos.removeAt(i);
                        });

                      },
                      child: Icon(Icons.close,color: Colors.red,size: 35,),)

                  ],),

                GestureDetector(
                  onTap: (){
                    selectFiles();
                  },
                  child: Container(

                    height: 50,width: 100,
                    margin: EdgeInsets.only(top: 5,left: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(1),
                      ),

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                      Text("Add Photo"),
                      Icon(Icons.add,size: 40,)
                    ],),),),
                    //  Photos.length==0 && showimgerr==true?Text("Please select atleast one Image", textAlign: TextAlign.left  ,style: TextStyle(color: Colors.red, ), ):Container(),
//                       
                      ],
                      ),
            ),]),
             screen ==3 && Photos.length==0 && showimgerr==true?Text("Please select atleast one Image", textAlign: TextAlign.left  ,style: TextStyle(color: Colors.red, ), ):Container(),
                    
                  // ],),

                    if(screen == 2)
                      Column(children: <Widget>[

                        GestureDetector(onTap: () {
                          selectDrivingLicence();
                        },
                          child:  getTextWidget("Select Driving Licence", "", size,
                              controller: controllerDrivingLicence,isFieldEnabled: false,
                              onTapped: (){
                                print("tapped");
                                selectDrivingLicence();
                              }),
                        ),
                        GestureDetector(onTap: () {
                          selectInsurance();
                        },
                          child:  getTextWidget("Select Insurance", "", size,
                              controller: controllerInsurance,isFieldEnabled: false,
                              onTapped: (){
                                print("tapped");
                                selectInsurance();
                              }),
                        ),
                        GestureDetector(onTap: () {
                          selectRC();
                        },
                          child:  getTextWidget("Select RC", "", size,
                              controller: controllerRc,isFieldEnabled: false,
                              onTapped: (){
                                print("tapped");
                                selectRC();
                              }),
                        ),
                        GestureDetector(onTap: () {
                          selectFCPermit();
                        },
                          child:  getTextWidget("Select FC Permit(optional)", "", size,
                              controller: controllerFC,isFieldEnabled: false,
                              onTapped: (){
                                print("tapped");
                                selectFCPermit();
                              }),
                        ),
                  //       vehicles!=null?
                  // Container(height: 180,child: ListView(

                  //   scrollDirection: Axis.horizontal,

                  //   children: [

                  //     for(int i=0;i<vehicles.photos.length;i++)
                  //       Column(

                  //         children: [

                  //         Container(child: Image.network("https://admin.bigmidas.com:7420/"+vehicles.photos[i],height: 120,width: 120,fit: BoxFit.fill,),margin: EdgeInsets.only(left: 10),),

                  //       ],),
                  //   ],
                  // ))
                  // :
                  Align(alignment: Alignment.bottomLeft, 
                child: Padding(padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),  child:Text("Your Vehicle Photos", textAlign: TextAlign.left,  style: TextStyle(fontSize: 16, color: Colors.black ),),),),
            Container(height: 180,
            child:   ListView(

              scrollDirection: Axis.horizontal,
              children: [
                for(int i=0;i<Photos.length;i++)
                  Column(children: [


                    Container(child: Image.file(Photos[i],height: 120,width: 120,fit: BoxFit.fill,),margin: EdgeInsets.only(left: 10),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          Photos.removeAt(i);
                        });

                      },
                      child: Icon(Icons.close,color: Colors.red,size: 35,),)

                  ],),

                GestureDetector(
                  onTap: (){
                    selectFiles();
                  },
                  child: Container(

                    height: 50,width: 100,
                    margin: EdgeInsets.only(top: 5,left: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(1),
                      ),

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                      Text("Add Photo"),
                      Icon(Icons.add,size: 40,)
                    ],),),),
                    //  Photos.length==0 && showimgerr==true?Text("Please select atleast one Image", textAlign: TextAlign.left  ,style: TextStyle(color: Colors.red, ), ):Container(),

//                        getTextWidget("", "", size),
//                        getTextWidget("", "", size),
//                        getTextWidget("", "", size),
//                        getTextWidget("", "", size),
                      ],
                      ),
            ),
             Photos.length==0 && showimgerr==true?Text("Please select atleast one Image", textAlign: TextAlign.left  ,style: TextStyle(color: Colors.red, ), ):Container(),
                      ],),
                    if(screen == 1)
                      Column(children: <Widget>[
                        GestureDetector(onTap: (){
                          selectTradeLicence();
                        },child: getTextWidget("Trade Licence", "", size,
                            controller: controllertrade,isFieldEnabled: false),),

                       GestureDetector(
                         onTap: (){
                           selectFASSAI();
                         },
                         child:  getTextWidget("FSSAI Licence", "", size,
                           controller: controllerfassai,isFieldEnabled: false),),
                  //          store!=null?
                  // Container(height: 180,child: ListView(

                  //   scrollDirection: Axis.horizontal,

                  //   children: [

                  //     for(int i=0;i<vehicles.photos.length;i++)
                  //       Column(

                  //         children: [

                  //         Container(child: Image.network("https://admin.bigmidas.com:7420/"+vehicles.photos[i],height: 120,width: 120,fit: BoxFit.fill,),margin: EdgeInsets.only(left: 10),),

                  //       ],),
                  //   ],
                  // ))
                  // :
                  Align(alignment: Alignment.bottomLeft, 
                child: Padding(padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),  child:Text("Your Store Photos", textAlign: TextAlign.left,  style: TextStyle(fontSize: 16, color: Colors.black ),),),),
                  Container(),
            Container(height: 180,
            child:   ListView(

              scrollDirection: Axis.horizontal,
              children: [
                for(int i=0;i<Photos.length;i++)
                  Column(children: [


                    Container(child: Image.file(Photos[i],height: 120,width: 120,fit: BoxFit.fill,),margin: EdgeInsets.only(left: 10),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          Photos.removeAt(i);
                        });

                      },
                      child: Icon(Icons.close,color: Colors.red,size: 35,),)

                  ],),

                GestureDetector(
                  onTap: (){
                    selectFiles();
                  },
                  child: Container(

                    height: 50,width: 100,
                    margin: EdgeInsets.only(top: 5,left: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(1),
                      ),

                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                      Text("Add Photo"),
                      Icon(Icons.add,size: 40,)
                    ],),),)

//                       
                      ],
                      ),
            ),
            Photos.length==0 && showimgerr==true?Text("Please select atleast one Image", textAlign: TextAlign.left  ,style: TextStyle(color: Colors.red, ), ):Container(),
                      ],
                      ),


                    Container(
                      margin: EdgeInsets.all(10),
                      child: isLoading ? Container(
                        margin: EdgeInsets.only(top: 10),
                        child: CircularProgressIndicator(),) : getAwesomeButton(
                          "Register", () {
                        String userType = Provider
                            .of<ProviderLogin>(context, listen: false)
                            .userType;
                       
                        if (userType == "store")
                          //Navigator.pushReplacementNamed(context, DashBoard.routeName);
                          storeRegister();
                        else if (userType == "vehicle")
                          {
                            vehicleRegister();
                          }
//                          Navigator.pushReplacementNamed(
//                              context, ListOfVichleHistory.routeName);
                        //   Navigator.pushReplacementNamed(context, DashBoard.routeName);
                        else
                          //Navigator.pushReplacementNamed(context, ListOfServiceHistory.routeName);
                        serviceRegister();
                        //  Navigator.pushReplacementNamed(context, DashBoard.routeName);
                      }
                      
                      ),
                    ),
//                    Container(
//                      child: FlatButton(
//                        child: Text("Already have a Listing?"), onPressed: () {
//                        openDashboardAccordingly();
//                      },
//                      ),
//                    )

//             GestureDetector(
//               onTap: (){
//    Navigator.pushReplacementNamed(context, DashBoard.routeName);
//               },
//               child:  Container(
//               margin: EdgeInsets.only(top: 20),
//               child: getSignatureButtonShape("Register",size),),)


                  ],
                ),
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


        enabled: isFieldEnabled != null ? isFieldEnabled : true,
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

    result = await showLocationPicker(
      context, "AIzaSyBJ7XP4D6qnzuxDXNomz4JYtNsaMW89M7k",

      initialCenter: LatLng(23.2599, 77.4126),
      myLocationButtonEnabled: true,
      layersButtonEnabled: true,
      countries: ['AE', 'NG', 'IN'],

    );
    print("latlong ${result}");
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
     if(Photos.length==0 || Photos.length==null){
          setState(() {
            showimgerr=true;
          });
    }
    else{
    if (!_keyValidationForm.currentState.validate()) return;
    setState(() {
      isLoading = true;
    });
    }
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
if(Photos.length>0){
   await addShop();
    setState(() {
      isLoading = false;
    });
  }
  }

  void addShop()async
  {
    if(!_keyValidationForm.currentState.validate())return;
    print("provider store listing");
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
  var request = http.MultipartRequest('POST', Uri.parse(SHOP_CREATE))
    ..fields['shop_name'] = controllerName.text
    ..fields['location_map'] = controllerLatLong.text
    ..fields['area'] = controllerarea.text
    ..fields['city'] = controllercity.text
    ..fields['address'] = controlleraddress.text
   // ..fields['category'] = controllercategory.text
    ..fields['category'] = shopCat
    //..fields['sub_cat']=shopSubCat
    ..fields['sub_cat']=shopCat
    ..fields['vendorid'] = '$vendorId'
//    ..fields['trade_licence'] = '${controllertrade.text}'
//    ..fields['fssai_licence'] = '${controllerfassai.text}'

    ..files.add(await http.MultipartFile.fromPath(
        'trade_licence', '${docTradeLicence.path}',
        contentType: MediaType('image', 'png')))
    ..files.add(await http.MultipartFile.fromPath(
  'fssai_licence', '${docFASSAI.path}',
  contentType: MediaType('image', 'png')))

    ..files.add(await http.MultipartFile.fromPath(
        'pan_adhaar', '${docPan.path}',
        contentType: MediaType('image', 'png')));
        for(int i=0;i<Photos.length;i++)
                        request..files.add(await http.MultipartFile.fromPath(
                    'images', '${Photos[i].path}',
                    contentType: MediaType('image', 'png')));
//
//    request.bodyFields = {
//      'shop_name': '${controllerName.text}',
//      'location_map': '${controllerLatLong.text}',
//      'area': '${controllerarea.text}',
//      'city': '${controllercity.text}',
//     // 'pan_adhaar': '$pan_adhaar',
//      'trade_licence': '${controllertrade.text}',
//      'fssai_licence': '${controllerfassai.text}',
//      'address': '${controlleraddress.text}',
//      'category': '${controllercategory.text}',
//      'vendorid': '$vendorId'
//    };
   // request.headers.addAll(headers);

    print("shop listing ${request.fields.toString()}");
    print("shop listing ${request.files.toString()}");
    print(docPan.path);

    http.StreamedResponse response = await request.send();
    String strRes=await response.stream.bytesToString();
    print(strRes);
    if (response.statusCode == 200) {

      TempPrefMimicAPI tempPrefMimicAPI=TempPrefMimicAPI();
      saveShopCategoryInUserPreference();
      //ModalPrefListingStatus modal=await tempPrefMimicAPI.getUserPreference();
      tempPrefMimicAPI.setListing(storeListed: true);
      print(strRes);
      var json=jsonDecode(strRes);
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

  void vehicleRegister() async {
    print("Store input validate ${_keyValidationForm.currentState.validate()}");
    if(Photos.length==0 || Photos.length==null){
          setState(() {
            showimgerr=true;
          });
          if (!_keyValidationForm.currentState.validate()) {
      return;
    }
    }
    else{
    if (!_keyValidationForm.currentState.validate()) {
      return;
    }
    
      setState(() {
        isLoading = true;
      });
      }

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
          ..fields['vehicle_price'] = controllerPrice.text
//          ..fields['pan_adhaar'] = '$catIdSelectedForServiceListing'
//          ..fields['driving_license'] = controllerLatLong.text
//          ..fields['rc'] = '$vendorId'
//          ..fields['insurance'] = '$vendorId'
//          ..fields['fc'] = '$vendorId'

          ..files.add(await http.MultipartFile.fromPath(
              'pan_adhaar', '${docPan.path}',
              contentType: MediaType('image', 'png')))

    ..files.add(await http.MultipartFile.fromPath(
    'driving_license', '${docDrivingLicence.path}',
    contentType: MediaType('image', 'png')))

    ..files.add(await http.MultipartFile.fromPath(
    'rc', '${docRC.path}',
    contentType: MediaType('image', 'png')))

    ..files.add(await http.MultipartFile.fromPath(
    'insurance', '${docInsurance.path}',
    contentType: MediaType('image', 'png')));
    if(fc==1){
    request..files.add(await http.MultipartFile.fromPath(
    'fc', '${docFCPermit.path}',
    contentType: MediaType('image', 'png')));
    }
    for(int i=0;i<Photos.length;i++)
                        request..files.add(await http.MultipartFile.fromPath(
                    'images', '${Photos[i].path}',
                    contentType: MediaType('image', 'png')));

        print(request.fields.toString());
        print(docPan.path);
        
        var response;
        if(Photos.length>0){
          setState(() {
          isLoading=true;
        });
         response = await request.send();
        
        print("REsponse of vehicle listing ${await response.stream.bytesToString()}");
        }


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

    if(Photos.length==0 || Photos.length==null){
          setState(() {
            showimgerr=true;
          });
    }
    else{
    if (!_keyValidationForm.currentState.validate()) {
      return;
    }
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
      ..fields['service_price'] = controllerPrice.text
      ..files.add(await http.MultipartFile.fromPath(
          'pan_adhaar', '${docPan.path}',
          contentType: MediaType('image', 'png')));
      for(int i=0;i<Photos.length;i++)
                        request..files.add(await http.MultipartFile.fromPath(
                    'images', '${Photos[i].path}',
                    contentType: MediaType('image', 'png')));

    print(request.fields.toString());
    print(controllerPrice.text);
    print(docPan.path);
    var response;
    if(Photos.length>0){
      setState(() {
      isLoading=true;
    });
    response= await request.send();
    }
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
      print(await response.stream.bytesToString());
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
  }


  void selectDrivingLicence() async {
    FilePicker filePicker = FilePicker.platform;
    Set allowedExtension = Set();
    allowedExtension.add("PDF");
    allowedExtension.add("pdf");
    FilePickerResult pickedFile1=await filePicker.pickFiles(allowMultiple: false);
    controllerDrivingLicence.text=pickedFile1.files[0].path.split('/').last;
    docDrivingLicence=File(pickedFile1.files[0].path);
    print(docDrivingLicence.uri);
    //docPan=pickedFile.files[0].path;
    //File.
  }


    void selectFiles()async {
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
  if(file != null) {
    files = file;
    print("length of files is ${files.length}");
    controllerPhotos.text="${files.length} files selected";
    setState(() {
      Photos.add(file);
    });
  } else {
    // User canceled the picker

  }
});
    }

  void selectInsurance() async {
    FilePicker filePicker = FilePicker.platform;
    Set allowedExtension = Set();
    allowedExtension.add("PDF");
    allowedExtension.add("pdf");
    FilePickerResult pickedFile2=await filePicker.pickFiles(allowMultiple: false);
    controllerInsurance.text=pickedFile2.files[0].path.split('/').last;
    docInsurance=File(pickedFile2.files[0].path);
    print(docInsurance.uri);
    //docPan=pickedFile.files[0].path;
    //File.
  }

  void selectRC() async {
    FilePicker filePicker = FilePicker.platform;
    Set allowedExtension = Set();
    allowedExtension.add("PDF");
    allowedExtension.add("pdf");
    FilePickerResult pickedFile3=await filePicker.pickFiles(allowMultiple: false);
    controllerRc.text=pickedFile3.files[0].path.split('/').last;
    docRC=File(pickedFile3.files[0].path);
    print(docRC.uri);
    //docPan=pickedFile.files[0].path;
    //File.
  }

  void selectFCPermit() async {
    FilePicker filePicker = FilePicker.platform;
    Set allowedExtension = Set();
    allowedExtension.add("PDF");
    allowedExtension.add("pdf");
    FilePickerResult pickedFile4=await filePicker.pickFiles(allowMultiple: false);
    controllerFC.text=pickedFile4.files[0].path.split('/').last;
    docFCPermit=File(pickedFile4.files[0].path);
    fc=1;
    print(docFCPermit);
    //docPan=pickedFile.files[0].path;
    //File.
  }

  void selectTradeLicence() async {
    FilePicker filePicker = FilePicker.platform;
    Set allowedExtension = Set();
    allowedExtension.add("PDF");
    allowedExtension.add("pdf");
    FilePickerResult pickedFile5=await filePicker.pickFiles(allowMultiple: false);
    docTradeLicence=File(pickedFile5.files[0].path);
    controllertrade.text=pickedFile5.files[0].path.split('/').last;
    print(docTradeLicence);
    //docPan=pickedFile.files[0].path;
    //File.
  }

  void selectFASSAI() async {
    FilePicker filePicker = FilePicker.platform;
    Set allowedExtension = Set();
    allowedExtension.add("PDF");
    allowedExtension.add("pdf");
    FilePickerResult pickedFile6=await filePicker.pickFiles(allowMultiple: false);
    docFASSAI=File(pickedFile6.files[0].path);
    controllerfassai.text=pickedFile6.files[0].path.split('/').last;
    print(docFASSAI);
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
    var request = http.Request('GET', Uri.parse('$VEHICLE_CAT'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strRes = await response.stream.bytesToString();
      print(strRes);
      List<dynamic>list = json.decode(strRes);
      print("list json decode $list");
      print("list json decode ${list.length}");
      listModelVehicleCat = List();
      for (int i = 0; i < list.length; i++){
        print(list[i]);
      listModelVehicleCat.add(ModelVehicleCategory.fromJson(list[i]));
    }


       print("vehicle cate ${listModelVehicleCat.length}");
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
    print("entered shopR");
    String url=SHOP_SUBCAT+"$shopCat";
    print(url);
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

      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

  void saveShopCategoryInUserPreference() async{
    LoginPreference pref=LoginPreference();
    pref.saveShopCategoryId(shopCat);

  }

}
//class RedeemConfirmationScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        backgroundColor: Colors.white.withOpacity(0.85), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
//        body:  PlacePicker(
//          apiKey: "AIzaSyDnC5VU3OBizlcu-HY_RN4yafz8D5ZpHic",   // Put YOUR OWN KEY here.
//          onPlacePicked: (result) {
//            print(result.adrAddress);
//            Navigator.of(context).pop();
//          },
//
//          useCurrentLocation: true,
//        ),
//    );
//  }
//}