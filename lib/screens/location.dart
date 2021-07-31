import 'dart:io';
import 'package:bigmidasvendor/model/modeldetails.dart';
import 'package:bigmidasvendor/model/modelprofile.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/widgets/drawer.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:bigmidasvendor/widgets/testdraw.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common.dart';

class LocationDetails extends StatefulWidget
{
  static String routeName="/location";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LocationDetailsState();
  }
}
class LocationDetailsState extends State<LocationDetails>
{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Modeldetails modeldetails;
  bool show=false;
  bool show1=false;
  bool show2=false;
  String current = "";
  String area="";
  String address="";
  String city="";
  String state="";

  String freedelivery;
  String kmserving;
  LocationResult result;
  String locationMap = "Select Current Store Location in Map";
  // String servicekmserving;
  // String vehiclekmserving;
  bool updated = false;
  bool success = false;
  File profilepic;
  bool updatepic = false;
  File files;
  TextEditingController controllerLatLong = TextEditingController(text: "");
@override
  void initState() {
    // TODO: implement initState
    super.initState(); 
    getlocationData();
    
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    if(modeldetails!=null){
      // controllerLatLong.text=modeldetails.vendors[0].location;
      }
    if(Provider.of<ProviderLogin>(context).userType=="store"){
      current="1";
    }
    // TODO: implement build
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: getAppBar(_scaffoldKey,context),
      // drawer: drawer(context, "username", "balance"),
      drawer: TestDraw(),
      // modeldetails==null?Center(child: CircularProgressIndicator(),):
    body: modeldetails==null?Center(child: CircularProgressIndicator(),):SingleChildScrollView(

      child:Column(children: [
        SizedBox(height: 30,),
        Container(
              // alignment: Alignment.centerLeft,
              child: Text("Location",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18),),),
        GestureDetector ( onTap: () {
                      showPlacePicker();
                      print("tapped");
                    },
                        child: getTextWidget(
                          // modeldetails.vendors[0].location.split(" ")[0].substring(0,10)+"... ,"+modeldetails.vendors[0].location.split(" ")[0].substring(0,10)+"..."
                            "${modeldetails.vendors[0].location.split(" ")[0].length>12?modeldetails.vendors[0].location.split(" ")[0].substring(0,10)+"...,"+modeldetails.vendors[0].location.split(" ")[1].substring(0,10):modeldetails.vendors[0].location}...", "", size, onTapped: () {
                            setState(() {
                            updated=true;
                            });
                            print("tapped place picker");
                            showPlacePicker();
                        },
                            controller: controllerLatLong,
                            isFieldEnabled: false)
                    ),
                    SizedBox(height: 20,),
                   Container(
              // alignment: Alignment.centerLeft,
              child: Text("Address",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18),),),
        Container(
          margin: EdgeInsets.only(left: 40,top:0,right:40,bottom:20),
          child: TextFormField(
              initialValue: modeldetails.vendors[0].address,
              onChanged: (text)=>{ setState(() {show = true;}), setState((){address=text; updated=true;})},
              decoration: InputDecoration(hintText: "Address"),
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),),
                        Container(
              // alignment: Alignment.centerLeft,
              child: Text("City",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18),),),
        Container(
          margin: EdgeInsets.only(left: 40,top:0,right:40,bottom:20),
          child: TextFormField(
              initialValue: modeldetails.vendors[0].city,
              onChanged: (text)=>{ setState(() {show = true;}), setState((){city=text; updated=true;})},
              decoration: InputDecoration(hintText: "City"),
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),),
            Container(
              // alignment: Alignment.centerLeft,
              child: Text("Area",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18),),),
        Container(
          margin: EdgeInsets.only(left: 40,top:0,right:40,bottom:20),
          child:  TextFormField(
              initialValue: modeldetails.vendors[0].area,
              onChanged: (text)=>{ setState(() {show = true;}), setState((){area=text; updated=true;})},
              decoration: InputDecoration(hintText: "Area"),
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16),
            )),
                        Container(
              // alignment: Alignment.centerLeft,
              child: Text("State",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18),),),
            Container(
          margin: EdgeInsets.only(left: 40,top:0,right:40,bottom:20),
          child:  TextFormField(
              initialValue: modeldetails.vendors[0].state,
              onChanged: (text)=>{ setState(() {show = true;}), setState((){state=text; updated=true;})},
              decoration: InputDecoration(hintText: "State"),
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16),
            )),
           updated==true?RaisedButton( onPressed: (){updatelocationdetails();}, child: Text("Update"),):Container(),
           success==true?Text("Successfully updated...."):Container(),
      ],

      ),
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
    setState(() {
          updated=true;
        });

//    Navigator.of(context).push(PageRouteBuilder(
//        opaque: false,
//        pageBuilder: (BuildContext context, _, __) =>
//            RedeemConfirmationScreen()));

  }

   Widget getTextWidget(String hint, String textIfAny, Size size,
      {bool isFieldEnabled, Function onTapped, TextEditingController controller,}) {
    return  Container(


      width: size.width - 80,
      height: 70,
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(left: 0, top: 0),
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
        
        keyboardType: hint.contains("Price")?TextInputType.number:TextInputType.text,
        style: TextStyle(color: Colors.black,),


      ),


    );
  }


void getlocationData() async{
    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    String url;
    if(Provider.of<ProviderLogin>(context, listen: false).userType=="store"){
           url='https://admin.bigmidas.com/store/storelocationdetails/$vendorId';
    }
    else{
          url='https://admin.bigmidas.com/store/getservicelocation/$vendorId';
    }
    print(url);
    var request = http.Request('GET', Uri.parse(url));


    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String strResponse=await response.stream.bytesToString();
      print(" this is te response ${strResponse}");
       modeldetails=Modeldetails.fromJson(json.decode(strResponse));
      // print(modeldetails.area);
      print(modeldetails);
      setState(() {

      });
    }
    else {
    print(response.reasonPhrase);
    }

  }

  void updatelocationdetails() async{
    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    var val= modeldetails.vendors[0].sid;
    String url;
    if(Provider.of<ProviderLogin>(context, listen: false).userType=="store"){
     url='https://admin.bigmidas.com/store/updatestorelocationdetails/${modeldetails.vendors[0].sid}';
    }
    else{
      url='https://admin.bigmidas.com/store/updatelocationdetails/${modeldetails.vendors[0].sid}';
    }
    print(url);
    print(this.state);
    print(this.city);
    print(this.address);
    print(this.controllerLatLong.text);


    var request = http.Request('PUT', Uri.parse(url));
    request.bodyFields = {
    "state":this.state.length<1?modeldetails.vendors[0].state:this.state,
    "city":this.city.length<1?modeldetails.vendors[0].city:this.city,
    "address":this.address.length<1?modeldetails.vendors[0].address:this.address,
    "location_map":this.controllerLatLong.text.length<1?modeldetails.vendors[0].location:this.controllerLatLong.text,
    "area":this.area.length<1?modeldetails.vendors[0].area:this.area,
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strResponse=await response.stream.bytesToString();
      print(strResponse);
      // print(modeldetails.vendors[0].aboutus);
      setState(() {
        show=false;
        updated=false;
        success=true;
      });
    }
    else {
    print(response.reasonPhrase);
    }

  }





  // void updatedistance() async{
  //   String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
  //   print(vendorId);
  //   if(Provider.of<ProviderLogin>(context,listen:false).userType=="store"){
  //     if(vendor.storekmServing==null){
  //       setState(() {
  //                 vendor.storekmServing=0;
  //               });
  //     }
  //     if(vendor.deliveryCharges==null){
  //       setState(() {
  //                 vendor.deliveryCharges=0;
  //               });
  //     }
  //     print("entered store");
  //         String url='https://admin.bigmidas.com/store/storedistance/$vendorId';
  //   print(url);
  //   var request = http.Request('PUT', Uri.parse(url));
  //   request.bodyFields = {
  //   "store_km_serving":vendor.storekmServing.toString(),
  //   "delivery_charges":vendor.deliveryCharges.toString(),
  //   "free_delivery":vendor.freeDeliveryAbove.toString(),
  //   };

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     String strResponse=await response.stream.bytesToString();
  //     print(strResponse);
  //     setState(() {
  //       show1=false;
  //     });
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }

  //   }
  //   else if(Provider.of<ProviderLogin>(context,listen:false).userType=="service"){
  //     if(vendor.servicekmServing==null){
  //       setState(() {
  //                 vendor.servicekmServing=0;
  //               });
  //     }
  //     print("entered service");
  //         String url='https://admin.bigmidas.com/store/servicedistance/$vendorId';
  //   print(url);
  //   var request = http.Request('PUT', Uri.parse(url));
  //   request.bodyFields = {
  //   "service_km_serving":vendor.servicekmServing.toString(),
  //   };

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     String strResponse=await response.stream.bytesToString();
  //     print(strResponse);
  //     setState(() {
  //       show1=false;
  //     });
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  //   }
  // }
}