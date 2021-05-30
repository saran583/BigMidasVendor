import 'dart:io';

import 'package:bigmidasvendor/model/modelprofile.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/widgets/drawer.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:bigmidasvendor/widgets/testdraw.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class Profile extends StatefulWidget
{
  static String routeName="/profile";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState();
  }
}
class ProfileState extends State<Profile>
{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ModelProfile modelProfile;
  Vendors vendor;
  bool show=false;
  bool show1=false;
  bool show2=false;
  String current = "";
  String aboutus="";
  String freedelivery;
  String kmserving;
  // String servicekmserving;
  // String vehiclekmserving;
  File files;
  TextEditingController controllerPhotos=TextEditingController();
  TextEditingController controllerPhotos1=TextEditingController();
  List<File>productPhotos=List();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
    
    
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    if(modelProfile!=null)
      vendor=modelProfile.vendors[0];
    if(Provider.of<ProviderLogin>(context).userType=="store"){
      current="1";
    }
    // TODO: implement build
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: getAppBar(_scaffoldKey,context),
      // drawer: drawer(context, "username", "balance"),
      drawer: TestDraw(),
    body: modelProfile==null?Center(child: CircularProgressIndicator(),):SingleChildScrollView(

      child:Column(children: [
        Container(
          height: size.height/3+100,
          width: size.width-20,
          child: Card(
            elevation: 20,

            //height: 320,
            // width: double.infinity,
            // padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(20),
            //decoration: BoxDecoration(
            //   borderRadius:BorderRadius.all(Radius.circular(10),),border: Border.all(color: Colors.black) ),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Container(

                height: 120,
                child: Image.asset("assets/images/circular_image2.png"),

                width: 120,

                margin: EdgeInsets.only(left: 5,top: 20),
              ),
             Container(
               margin: EdgeInsets.only(top: 30),
               child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("Name -${vendor.name}",style: TextStyle(color: Colors.red,fontSize: 16),),
                 SizedBox(height: 5,),
                 Text("Email - ${vendor.mail}",style: TextStyle(color: Colors.red,fontSize: 16),),
                 SizedBox(height: 5,),
                 Text("Phone Number - ${vendor.phonenumber}",style: TextStyle(color: Colors.red,fontSize: 16),),
                 SizedBox(height: 5,),
                 Text("State/Country - India",style: TextStyle(color: Colors.red,fontSize: 16),),
               ],
             ) ,)
            ],
            ),
          ),),
        if(Provider.of<ProviderLogin>(context).userType=="store")
         Container(
           margin: EdgeInsets.only(left: 20),
           alignment: Alignment.centerLeft, child: Column( children: [Text("Delivery or Pickup:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),), Row(children: [ SizedBox(width: MediaQuery.of(context).size.width *0.2),  RaisedButton(color: vendor.deliveryType=="Delivery"?Colors.orange[800]:Colors.grey[400], child: Text("Delivery"), onPressed: ((){ setState(() { vendor.deliveryType="Delivery";}); updatedeliverytype("Delivery"); }),), SizedBox( width: 10,),  RaisedButton(color: vendor.deliveryType=="Pickup"?Colors.orange[800]:Colors.grey[400], child: Text("Pickup"), onPressed: ((){ setState(() { vendor.deliveryType="Pickup";}); updatedeliverytype("Pickup"); }),) ],),],),),
        //if(Provider.of<ProviderLogin>(context).userType=="vehicle"||Provider.of<ProviderLogin>(context).userType=="store")
        if(Provider.of<ProviderLogin>(context,listen: false).userType=="service")
          Container(
            margin: EdgeInsets.only(left: 20,top: 30,right: 20),
            alignment: Alignment.centerLeft,
            child:  Column(
              children:[TextFormField(
              initialValue: vendor.aboutus,
              onChanged: (text)=>{ setState(() {show = true;}), setState((){aboutus=text;})},
              decoration: InputDecoration(hintText: "AboutUs"),
              maxLines: 5,
              minLines: 3,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            show==true ? RaisedButton(
              color: Colors.orange[800],
              child: Text("Update"),
              onPressed: (){
                updateaboutus();
              },
            ):Container()
            ],
            ),
          ),
        if(Provider.of<ProviderLogin>(context).userType=="service")
         Container(
            margin: EdgeInsets.only(left: 20,top: 30,right: 20),
            alignment: Alignment.centerLeft,child: Column(children: [Text("How many km serving: ${vendor.servicekmServing.toString()} km ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),), TextFormField(
              initialValue: vendor.servicekmServing.toString(),
              onChanged: (text)=>{ setState(() {show1 = true;}), setState((){ vendor.servicekmServing = text;})},
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: ""),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),],)  ),
        // if(Provider.of<ProviderLogin>(context).userType!="service")
        // current=="1"&&vendor.deliveryType=="Pickup"?Container():Container(
        //   margin: EdgeInsets.only(left: 20,top: 30, right:20),
        //   alignment: Alignment.centerLeft,child: Column(children: [Text("How many km serving: ${vendor.storekmServing.toString()=="null"?"0":vendor.kmServing.toString()} km",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),), TextFormField(
        //       initialValue: vendor.kmServing.toString()=="null"?"0":vendor.kmServing.toString(),
        //       onChanged: (text)=>{ setState(()  {show1 = true;}), setState((){vendor.kmServing=text;})},
        //       textAlign: TextAlign.center,
        //       decoration: InputDecoration(hintText: " "),
        //       keyboardType: TextInputType.number,
        //       style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 16),
        //     ),],)),
        if(Provider.of<ProviderLogin>(context).userType=="vehicle")
          Container(
            margin: EdgeInsets.only(left: 20,top: 20, right: 20),
            alignment: Alignment.centerLeft,child:  Column( children:[Text("How many km serving: ${vendor.vehiclekmServing.toString()=="null"?"0":vendor.vehiclekmServing.toString()} km",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),), TextFormField(
              initialValue: vendor.vehiclekmServing.toString()=="null"?"0":vendor.vehiclekmServing.toString(),
              onChanged: (text)=>{ setState(()  {show1 = true;}), setState((){vendor.vehiclekmServing=text;})},
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: " "),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),Text("Per KM Charges: ${vendor.kmCharges.toString()=="null"?"0":vendor.kmCharges}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),), TextFormField(
              initialValue: vendor.kmCharges.toString()=="null"?"0":vendor.kmCharges.toString(),
              onChanged: (text)=>{ setState(() { show1 = true;}), setState((){vendor.kmCharges=text;})},
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: " "),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ) ],)),
        if(Provider.of<ProviderLogin>(context).userType=="store")
         current=="1"&&vendor.deliveryType=="Pickup"?Container(): Container(
            margin: EdgeInsets.only(left: 20,top: 20, right: 20),
            alignment: Alignment.centerLeft,child: Column( children:[Text("How many km serving: ${vendor.storekmServing.toString()=="null"?"0":vendor.storekmServing.toString()} km",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),), TextFormField(
              initialValue: vendor.storekmServing.toString()=="null"?"0":vendor.storekmServing.toString(),
              onChanged: (text)=>{ setState(()  {show1 = true;}), setState((){vendor.storekmServing=text;})},
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: " "),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),Text("Delivery Charges: ${vendor.deliveryCharges.toString()=="null"?"0":vendor.deliveryCharges.toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),TextFormField(
              initialValue: vendor.deliveryCharges.toString()=="null"?"0":vendor.deliveryCharges.toString(),
              onChanged: (text)=>{ setState(() {show1 = true;}), setState((){vendor.deliveryCharges=text;})},
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: " "),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )],)),
        if(Provider.of<ProviderLogin>(context).userType=="store")
         current=="1"&&vendor.deliveryType=="Pickup"?Container():Container(
            margin: EdgeInsets.only(left: 20,top: 20, right: 20),
            alignment: Alignment.center,child: Column( children: [Text("Free Delivery Above: ${vendor.freeDeliveryAbove}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),), 
            TextFormField(
              initialValue: vendor.freeDeliveryAbove.toString()=="null"?"0":vendor.freeDeliveryAbove.toString(),
              onChanged: (text)=>{ setState(() {show1 = true;}), setState((){vendor.freeDeliveryAbove=text;})},
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: " "),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )
            ],)),
            show1==true?RaisedButton(
              color: Colors.orange[800],
              child: Text("Update"),
              onPressed: (){
                updatedistance();
              },
            ):Container(),

        if(Provider.of<ProviderLogin>(context).userType=="store")
        Container(
          margin: EdgeInsets.only(left: 30,top: 30, right:20),
          alignment: Alignment.center,child:  Column( children:[ Text("Add/Edit Store Photos:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue),),
          Container ( height: 180,
            child:   ListView(

              scrollDirection: Axis.horizontal,
              children: [
                for(int i=0;i<vendor.shopimages[0].length;i++)
                  Column(children: [
                    // Text(vendor.shopimages[0][i]),
                    Container ( child: Image.network("https://admin.bigmidas.com:7420/"+vendor.shopimages[0][i],height: 120,width: 120,fit: BoxFit.fill,),margin: EdgeInsets.only(left: 10),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          deleteimage(Provider.of<ProviderLogin>(context,listen: false).userType,vendor.shopimages[0][i]);
                          vendor.shopimages[0].removeAt(i);
                          print(vendor.shopimages[0]);
                        });

                      },
                      child: Icon(Icons.close,color: Colors.red,size: 35,),)

                  ],),
                  for(int j=0;j<productPhotos.length;j++)
                  Column(children: [
                    Container ( child: Image.file(productPhotos[j],height: 120,width: 120,fit: BoxFit.fill,),margin: EdgeInsets.only(left: 10),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          productPhotos.removeAt(j);
                        });

                      },
                      child: Icon(Icons.close,color: Colors.red,size: 35,),)

                  ],),
                  
                GestureDetector(
                  onTap: (){
                    selectFiles1();
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

              ],
            ),
                ),
          ]),
          ),

       if(Provider.of<ProviderLogin>(context).userType=="vehicle")
        Container(
          margin: EdgeInsets.only(left: 30,top: 30, right:20),
          alignment: Alignment.center,child:  Column( children:[ Text("Add/Edit Vehicle Photos:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue),),
          Container ( height: 180,
            child:   ListView(

              scrollDirection: Axis.horizontal,
              children: [
                for(int i=0;i<vendor.vehicleimages[0].length;i++)
                  Column(children: [
                    // Text(vendor.vehicleimages[0][i]),
                    Container ( child: Image.network("https://admin.bigmidas.com:7420/"+vendor.vehicleimages[0][i],height: 120,width: 120,fit: BoxFit.fill,),margin: EdgeInsets.only(left: 10),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          deleteimage(Provider.of<ProviderLogin>(context,listen: false).userType,vendor.vehicleimages[0][i]);
                          vendor.vehicleimages[0].removeAt(i);
                          print(vendor.vehicleimages[0]);
                        });

                      },
                      child: Icon(Icons.close,color: Colors.red,size: 35,),)

                  ],),
                  for(int j=0;j<productPhotos.length;j++)
                  Column(children: [
                    Container ( child: Image.file(productPhotos[j],height: 120,width: 120,fit: BoxFit.fill,),margin: EdgeInsets.only(left: 10),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          productPhotos.removeAt(j);
                        });

                      },
                      child: Icon(Icons.close,color: Colors.red,size: 35,),)

                  ],),
                  
                GestureDetector(
                  onTap: (){
                    selectFiles1();
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



              ],
            ),
                ),
          ]),
          ),

          if(Provider.of<ProviderLogin>(context).userType=="service")
        Container(
          margin: EdgeInsets.only(left: 30,top: 30, right:20),
          alignment: Alignment.center,child:  Column( children:[ Text("Add/Edit Service Photos:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue),),
          vendor.serviceimages[0].length>0?Container ( height: 180,
            child:   ListView(

              scrollDirection: Axis.horizontal,
              children: [
                for(int i=0;i<vendor.serviceimages[0].length;i++)
                  Column(children: [
                    // Text(vendor.serviceimages[0][i]),
                    Container ( child: Image.network("https://admin.bigmidas.com:7420/"+vendor.serviceimages[0][i],height: 120,width: 120,fit: BoxFit.fill,),margin: EdgeInsets.only(left: 10),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          deleteimage(Provider.of<ProviderLogin>(context,listen: false).userType,vendor.serviceimages[0][i]);
                          vendor.serviceimages[0].removeAt(i);
                          print(vendor.serviceimages[0]);
                        });
                      },
                      child: Icon(Icons.close,color: Colors.red,size: 35,),)
                  ],),
                  for(int j=0;j<productPhotos.length;j++)
                  Column(children: [
                    Container ( child: Image.file(productPhotos[j],height: 120,width: 120,fit: BoxFit.fill,),margin: EdgeInsets.only(left: 10),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          productPhotos.removeAt(j);
                        });
                      },
                      child: Icon(Icons.close,color: Colors.red,size: 35,),)

                  ],),
                  
                GestureDetector(
                  onTap: (){
                    selectFiles1();
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

                    

              ],
            ),
              ):Container(),
          ]),
          ),
         show2==true && productPhotos.length>0?RaisedButton(color:Colors.orange[800], onPressed: ((){addimages(Provider.of<ProviderLogin>(context,listen:false).userType);}), child: Text("Update"),):Container(),
      ],

      ),

    ),
    );
  }

   void selectFiles()async {
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
  if(file != null) {
    files = file;
    print("length of files is ${file}");
    controllerPhotos.text="${files.length} files selected";
    setState(() {
      productPhotos.add(file);
    });
  } else {
    // User canceled the picker
    
  }
});
  }



  void addimages(service) async{
    for(int k=0;k<productPhotos.length;k++){
      print("this is image filename $k and ${productPhotos[k].path}");
    }
    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    String url='https://admin.bigmidas.com:7420/store/add${service}images';
        var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    String method="POST";
    var uri = Uri.parse(url);
    var request = http.MultipartRequest(method, uri)
              ..fields['vendorid'] = vendorId;
              for(int i=0;i<productPhotos.length;i++)
                  request..files.add(await http.MultipartFile.fromPath(
                  'images', '${productPhotos[i].path}',
                  contentType: MediaType('image', 'png')));
              print(request.fields.toString());
              var response = await request.send();
               if (response.statusCode == 200) {
                   print("done");
                  //  productPhotos=List();
                    setState(() {
                      show2=false;
                  });
                  //  String strRes=await response.stream.bytesToString();
              // Map msg=json.decode(strRes);
             
     
        
      // print(strResponse);
      //  modelProfile=ModelProfile.fromJson(json.decode(strResponse));
    //   setState(() {

    //   });
    }
    else {
    print(response.reasonPhrase);
    }



  }

  void deleteimage(service,data) async{
    String vendorId2=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    List id=data.split("/").toList();
    print(id);
    String url='https://admin.bigmidas.com:7420/store/delete${service}image/$vendorId2/${id[1]}';
    print(url);
    var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strResponse=await response.stream.bytesToString();
      print(strResponse);
      //  RmodelProfile=ModelProfile.fromJson(json.decode(strResponse));
      // print(modelProfile.vendors[0].aboutus);
      setState(() {

      });
    }
    else {
    print(response.reasonPhrase);
    }



  }


   void selectFiles1()async {
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
  if(file != null) {
    files = file;
    print("length of files is ${files.length}");
    controllerPhotos1.text="${files.length} files selected";
    setState(() {
      show2=true;
      productPhotos.add(file);
      print(productPhotos);
    });
  } else {
    // User canceled the picker

  }
});
  }




  void getProfileData() async{
    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    String url='https://admin.bigmidas.com:7420/store/vendor/$vendorId';
    print(url);
    var request = http.Request('GET', Uri.parse(url));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strResponse=await response.stream.bytesToString();
      print(strResponse);
       modelProfile=ModelProfile.fromJson(json.decode(strResponse));
      // print(modelProfile.vendors[0].aboutus);
      setState(() {

      });
    }
    else {
    print(response.reasonPhrase);
    }

  }

  void updatedeliverytype(type) async{
    String vendorId1=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    
    String url='https://admin.bigmidas.com:7420/store/updatedeliverytype/$vendorId1';
    print(url);
    var request = http.Request('PUT', Uri.parse(url));
    request.bodyFields = {
    "delivery_type":type,
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strResponse=await response.stream.bytesToString();
      print(strResponse);
      setState(() {
        show1=false;
      });
    }
    else {
    print(response.reasonPhrase);
    }


  }


  void updatedistance() async{
    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    print(vendorId);
    if(Provider.of<ProviderLogin>(context,listen:false).userType=="store"){
      if(vendor.storekmServing==null){
        setState(() {
                  vendor.storekmServing=0;
                });
      }
      if(vendor.deliveryCharges==null){
        setState(() {
                  vendor.deliveryCharges=0;
                });
      }
      print("entered store");
          String url='https://admin.bigmidas.com:7420/store/storedistance/$vendorId';
    print(url);
    var request = http.Request('PUT', Uri.parse(url));
    request.bodyFields = {
    "store_km_serving":vendor.storekmServing.toString(),
    "delivery_charges":vendor.deliveryCharges.toString(),
    "free_delivery":vendor.freeDeliveryAbove.toString(),
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strResponse=await response.stream.bytesToString();
      print(strResponse);
      setState(() {
        show1=false;
      });
    }
    else {
    print(response.reasonPhrase);
    }

    }
    else if(Provider.of<ProviderLogin>(context,listen:false).userType=="service"){
      if(vendor.servicekmServing==null){
        setState(() {
                  vendor.servicekmServing=0;
                });
      }
      print("entered service");
          String url='https://admin.bigmidas.com:7420/store/servicedistance/$vendorId';
    print(url);
    var request = http.Request('PUT', Uri.parse(url));
    request.bodyFields = {
    "service_km_serving":vendor.servicekmServing.toString(),
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strResponse=await response.stream.bytesToString();
      print(strResponse);
      setState(() {
        show1=false;
      });
    }
    else {
    print(response.reasonPhrase);
    }
    
    }
    else if(Provider.of<ProviderLogin>(context,listen:false).userType=="vehicle"){
      if(vendor.vehiclekmServing==null){
        setState(() {
                  vendor.vehiclekmServing=0;
                });
      }
      if(vendor.kmCharges==null){
        setState(() {
                  vendor.kmCharges=0;
                });
      }
      print("entered vehicle");
          String url='https://admin.bigmidas.com:7420/store/vehicledistance/$vendorId';
    print(url);
    var request = http.Request('PUT', Uri.parse(url));
    request.bodyFields = {
    "vehicle_km_serving":vendor.vehiclekmServing.toString(),
    "km_charges":vendor.kmCharges.toString(),
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strResponse=await response.stream.bytesToString();
      print(strResponse);
      setState(() {
        show1=false;
      });
    }
    else {
    print(response.reasonPhrase);
    }
    
    }


  }


  void updateaboutus() async{
    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
    String url='https://admin.bigmidas.com:7420/store/updateaboutus/$vendorId';
    print(url);
    var request = http.Request('PUT', Uri.parse(url));
    request.bodyFields = {
    "aboutus":aboutus
    };

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strResponse=await response.stream.bytesToString();
      print(strResponse);
      print(modelProfile.vendors[0].aboutus);
      setState(() {
        show=false;
      });
    }
    else {
    print(response.reasonPhrase);
    }

  }
}