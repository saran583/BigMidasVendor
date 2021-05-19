import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bigmidasvendor/model/modelcatlist.dart';
import 'package:bigmidasvendor/model/modelproduct.dart';
import 'package:bigmidasvendor/model/modelsubcat.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/provider/providershop.dart';
import 'package:bigmidasvendor/screens/editproduct.dart';
import 'package:bigmidasvendor/sharedpreference/loginpreferenc.dart';
import 'package:bigmidasvendor/utils/hexcolor.dart';
import 'package:bigmidasvendor/widgets/appspecificsignaturewidgets.dart';
import 'package:bigmidasvendor/widgets/showdialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../common.dart';
import 'package:http_parser/http_parser.dart';


class AddProduct extends StatefulWidget
{
  static String routeName="/addproduct";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddProductState();
  }
}
class AddProductState extends State<AddProduct>
{
  var dropdownValue;
  bool isLoading=false;


  String productName,catId,subcatId,disprice,unit,stock,description;
 // List<File> files;
  File files;
  var _keyValidationForm = GlobalKey<FormState>();
  TextEditingController controllerPname=TextEditingController(),
  controllerCat=TextEditingController(),
  controllerSubCat=TextEditingController(),
  controllerdisprice=TextEditingController(),
  controllerorigprice=TextEditingController(),
  controllerUnit=TextEditingController(),
  controllerStock=TextEditingController(),
  controllerDesc=TextEditingController(),
  controllerPhotos=TextEditingController();

//  TextEditingController controllerPname=TextEditingController(text: "name"),
//      controllerCat=TextEditingController(text: "cat"),
//      controllerSubCat=TextEditingController(text: "subcat"),
//      controllerdisprice=TextEditingController(text: "123"),
//      controllerUnit=TextEditingController(text: "1"),
//      controllerStock=TextEditingController(text: "5"),
//      controllerDesc=TextEditingController(text: "de"),
//      controllerPhotos=TextEditingController();

  List<ModelCatList> listOfModelCatList;

  List<ModelSubCatList> listOfModelSubCatList;

  var show=0;

  var originalPrice="Original Price";

  List<File>productPhotos=List();

  Products product;

  ModelCatList catValue;

  ModelSubCatList subCatValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      product=ModalRoute.of(context).settings.arguments;
      getCategory();
    });

  }
  bool isInitialised=false;
  @override
  Widget build(BuildContext context) {
    //isLoading=false;
    //getCategory();

    //int screen=ModalRoute.of(context).settings.arguments;
//     product=ModalRoute.of(context).settings.arguments;
    //print("product is  ${product.prodctcost}");
    String title="Product Name";
    String category="Enter Category";
    String subcategory="Enter Sub-Category";
    String discountedPrice="Discounted Price";
    String photo="Product Photo";
  //  String hintText="Enter Shop Name";
   // String locationMap="Select Current Store Location in Map";
   // String locationTitle="Store Location";
//
//    if(screen==-1)
//      {
//        title = "Sony Heaphone";
//       category="Electronics";
//       subcategory="Heaphones";
//       discountedPrice="600";
//       photo="Sony.jpeg";
//      }
//    if(screen==2) {
//      title = "Select Your Vehicle Category";
//    //  hintText="Enter Vehicle Category";
//    //  locationMap="Select Your Vehicle Type";
//   //   locationTitle="Vehicle Type";
//    }
//    else if(screen==3) {
//      title = "Select Your Service Category";
//    //  hintText="Enter Service Category";
//    }

    Size size=MediaQuery.of(context).size;
    //print("build add product${listOfModelSubCatList.length} ");
    //if(listOfModelCatList!=null&&listOfModelCatList.length>0) {
    if(listOfModelSubCatList!=null&&listOfModelSubCatList.length>0) {
      //catValue = listOfModelCatList[0];

      if(product!=null){
//      for (int i = 0; i < listOfModelCatList.length; i++)
//        if (listOfModelCatList[i].catName == product.category)
//          catValue = listOfModelCatList[i];


        //if(listOfModelSubCatList!=null) {
          subCatValue=listOfModelSubCatList[0];
          for (int i = 0; i < listOfModelSubCatList.length; i++)
            //if (listOfModelSubCatList[i].catName == product.subcategory)
            if (listOfModelSubCatList[i].sId == product.subcategory)
              subCatValue = listOfModelSubCatList[i];
        //}
    }
    }
    // TODO: implement build
    return  Scaffold(
        backgroundColor: HexColor("#EEEEEE"),
        //appBar: MyAppBar(),
        body: SingleChildScrollView(

          child: show==0? Container(child: Center( child: Column(children:[ SizedBox(height:200 ,),  CircularProgressIndicator()]))): Form(
            key: _keyValidationForm,
            child:  Card(


            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            margin: EdgeInsets.only(left: 10,right: 10,top: 40),
            child: Column(

              children: [

                Container(

                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1, bottom: 1),
                      child: Image.asset("assets/images/logo_Big_Midas.jpeg",height: 180,width: 180,),
                    )
                ),
                //  getTItleWidget("Product Name"),
                getTextWidget("$title","Enter Product Name",size,controllerPname),

                SizedBox(height: 20,),

              //   getTItleWidget("Category"),
                //getTextWidget("$category","Enter Category",size,controllerCat),

              listOfModelCatList==null?Container(): Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 30,right: 20),
                child:  DropdownButtonFormField<ModelCatList>(
                  value: catValue,

              isExpanded: true,
                hint: Text("Select Category"),
                items: listOfModelCatList.map((ModelCatList value) {
                  return new DropdownMenuItem<ModelCatList>(
                    value: value,
                    child: new Text(value.catName),
                  );
                }).toList(),
                onChanged: (cat) {
                catId=cat.sId;
                subcatId=null;
                getSubCat(cat.sId);

                },
              ),
              ),

                SizedBox(height: 20,),
                listOfModelSubCatList==null?Container():
                //getTItleWidget("Sub Category"),
                Container(),
               // getTextWidget("$subcategory","",size,controllerSubCat),
                listOfModelSubCatList==null?Container():
                listOfModelSubCatList.isEmpty?Text("No Sub-Category Found",style: TextStyle(color: Colors.red),):Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 30,right: 20),
                  child:  DropdownButtonFormField<ModelSubCatList>(
                    value: subCatValue,
                    hint:Text("Select Sub-Category"),
                    isExpanded: true,
                    items: listOfModelSubCatList.map((ModelSubCatList value) {
                      return new DropdownMenuItem<ModelSubCatList>(
                        value: value,
                        child: new Text(value.subCatName),
                      );
                    }).toList(),
                    onChanged: (cat) {
                      subcatId=cat.sId;
                    //  getSubCat(cat.sId);

                    },
                    validator: (value){
                      if(subcatId==null||subcatId.isEmpty)
                        return "Sub-Category Required";
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20,),
                //  getTItleWidget("Product Price"),
                getTextWidget("$originalPrice","Enter Original Price",size,controllerorigprice,inputType: TextInputType.numberWithOptions(decimal: true)),
                SizedBox(height: 20,),
                getTextWidget("$discountedPrice","Enter Discounted Price",size,controllerdisprice,inputType: TextInputType.numberWithOptions(decimal: true)),
                SizedBox(height: 20,),
                //  getTItleWidget("Product Price"),
                getTextWidget("Unit","Unit",size,controllerUnit,inputType: TextInputType.text),
                SizedBox(height: 20,),
                //  getTItleWidget("Product Price"),
                getTextWidget("Stock","Stock",size,controllerStock,inputType: TextInputType.number),
                SizedBox(height: 20,),
                //  getTItleWidget("Product Price"),
                getTextWidget("Description","Description",size,controllerDesc),
                SizedBox(height: 20,),
                //  getTItleWidget("Product Photo"),
//                files!=null?Container(): getTextWidget("$photo","",size,controllerPhotos,isFieldEnabled: false),
//
//               files==null?Container(): Container(
//                 margin: EdgeInsets.only(top: 10),
//                 child:GestureDetector(
//                   onTap: (){
//                     selectFiles();
//                   },
//                   child: Image.file(files,height: 90,width: 90,),
//                 ),
//               ) ,
              product!=null?Text("Already Uploaded Photos"):Container(),
              product!=null?
                  Container(height: 180,child: ListView(

                    scrollDirection: Axis.horizontal,

                    children: [

                      for(int i=0;i<product.prodphoto.length;i++)
                        Column(

                          children: [


                          Container(child: Image.network("https://admin.bigmidas.com:7420/"+product.prodphoto[i],height: 120,width: 120,fit: BoxFit.fill,),margin: EdgeInsets.only(left: 10),),


                        ],),


                    ],
                  ))
                  :Container(),
            Container(height: 180,
            child:   ListView(

              scrollDirection: Axis.horizontal,
              children: [
                for(int i=0;i<productPhotos.length;i++)
                  Column(children: [


                    Container(child: Image.file(productPhotos[i],height: 120,width: 120,fit: BoxFit.fill,),margin: EdgeInsets.only(left: 10),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          productPhotos.removeAt(i);
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

              ],
            ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: isLoading?CircularProgressIndicator():getAwesomeButton("Add Product",()async{

                    if(!_keyValidationForm.currentState.validate())return;
                    if(subcatId==null)
                      {
                        getCustomDialog(context, "Sub-category required","Please provider Sub-category",DialogType.INFO);
                        return ;
                      }
                    if(productPhotos.length==0&&product==null)
                    {
                      getCustomDialog(context, "Product photo required","Atleast add one product photo",DialogType.INFO);
                      return ;
                    }
                    setState(() {
                      isLoading=true;
                    });

//                 await  Provider.of<ProviderShop>(context,listen: false).addProduct(
//                        context,
//                        controllerPname.text,
//                        catId,
//                        subcatId,
//                        controllerdisprice.text,
//                        controllerdisprice.text,
//                        controllerUnit.text,
//                        controllerStock.text,
//                        controllerDesc.text,
//                        files,
//                   "http://162.241.201.237:7420/store/products"
//                        );
                    String vendorId=Provider.of<ProviderLogin>(context,listen:false).modelUser.sId;
                    // vendorId="Testing";
                    print("adding url $ADD_PRODUCT $vendorId");
                    String url=ADD_PRODUCT;
                    String method="POST";

                    if(product!=null) {
                      url = "${EDIT_PRODUCT}${product.sId}";
                      method="PUT";
                    }
                    print(url);
                    var uri = Uri.parse(url);
                    var request = http.MultipartRequest(method, uri)
                      ..fields['productname'] = controllerPname.text
                      ..fields['category'] = '$catId'
                      ..fields['subcategory'] = '$subcatId'
                      ..fields['prodctcost'] = controllerorigprice.text
                      ..fields['discountedprodprice'] = controllerdisprice.text
                      ..fields['vendorid'] = vendorId
                      ..fields['unit'] = controllerUnit.text
                      ..fields['stock'] = controllerStock.text
                      ..fields['description'] = controllerDesc.text;
                      for(int i=0;i<productPhotos.length;i++)
                        request..files.add(await http.MultipartFile.fromPath(
                    'prodphoto', '${productPhotos[i].path}',
                    contentType: MediaType('image', 'png')));
//                      ..files.add(await http.MultipartFile.fromPath(
//                          'prodphoto', '${files.path}',
//                          contentType: MediaType('image', 'png')));
                    print(request.fields.toString());
                    var response = await request.send();
                    String strRes=await response.stream.bytesToString();
                   Map msg=json.decode(strRes);

                    print(strRes);

                    if (response.statusCode == 200) {
                      //  print('Uploaded!');

                      if(msg['msg']==null)
                        msg['msg']=msg['message'];
                      if(msg['msg']==null)
                        msg['msg']="Product Added";
                      getCustomDialog(
                          context,
                          "Request processed",
                          "${msg['msg']}",
                          DialogType.INFO,oktext: "Okay",okFunc: (){
                            Navigator.pushReplacementNamed(context, EditProduct.routeName);
                      });
                    }
                    else
                    {
                      getCustomDialog(context, "Unable to prcess request", "${response.reasonPhrase}",DialogType.ERROR);
                    }
                    setState(() {
                      isLoading=false;
                    });
                  }
                  ),
                )

              ],
            ),
          ),)
        )

    );
  }

  Widget getTItleWidget(String title)
  {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: 30,top: 15),
      child: Text("$title",style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget getTextWidget(String hint,
      String textIfAny,
      Size size,
      TextEditingController _controller,{bool isFieldEnabled,inputType=TextInputType.text})
  {
    if(product!=null&&!isInitialised)
      {
        isInitialised=true;
        controllerPname.text=product.productname;
        controllerorigprice.text=product.prodctcost.toString();
        controllerdisprice.text=product.discountedprodprice.toString();
        controllerUnit.text=product.unit.toString();
        controllerStock.text=product.stock.toString();
        controllerDesc.text=product.description.toString();

      }
    return GestureDetector(
      onTap: (){
        if(hint=="Product Photo"){
          selectFiles();
        }
      },
      child:Container(
      width: size.width-80,
      height: 90,
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(left: 0,top: 10),
      child: TextFormField(


        keyboardType: inputType,
        controller: _controller,
        enabled: isFieldEnabled!=null?isFieldEnabled:true,

        // initialValue: textIfAny,
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red),
          labelText: '$hint',
          //prefixIcon: Icon(Icons.email),
          // icon: Icon(Icons.perm_identity)
        ),
        onChanged: (value){

        },
        validator: (value){
          if(value.trim().isEmpty)return "Field can not be left empty";
          else
            return null;
        },
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

      ),
    ) ,
    );
  }

  void selectFiles()async {
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
  if(file != null) {
    files = file;
    print("length of files is ${files.length}");
    controllerPhotos.text="${files.length} files selected";
    setState(() {
      productPhotos.add(file);
    });
  } else {
    // User canceled the picker

  }
});

//
//    FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);
//
//    if(result != null) {
//       files = result.paths.map((path) => File(path)).toList();
//print("length of files is ${files.length}");
// controllerPhotos.text="${files.length} files selected";
//    } else {
//      // User canceled the picker
//
//    }
  }

  void getCategory() async{

    LoginPreference pref=LoginPreference();
    catId=await pref.getShopCatId();
    await getSubCat(catId);
//
//    String url=SHOP_CAT;
//    //var request = http.Request('GET', Uri.parse('http://162.241.201.237:7420/store/shoplist/cat'));
//    var request = http.Request('GET', Uri.parse(url));
//
//    http.StreamedResponse response = await request.send();
//
//   String parsed=await response.stream.bytesToString();
//  List<dynamic> jsonParsed=jsonDecode(parsed);
//  listOfModelCatList=List();
//  for(int i=0;i<jsonParsed.length;i++) {
//    print(jsonParsed[i].toString());
//    listOfModelCatList.add(ModelCatList.fromJson(jsonParsed[i]));
//  }
//
//      LoginPreference pref=LoginPreference();
//     catId=await pref.getShopCatId();
//
//
////  print(listOfModelCatList[0].catName);
//    if (response.statusCode == 200) {
//      if(catId==null||catId.isEmpty)
//      catId=listOfModelCatList[0].sId;
//      subcatId=null;
//      if(product!=null) {
//        for(int i=0;i<listOfModelCatList.length;i++)
//          if(listOfModelCatList[i].catName==product.category) {
//            catId=listOfModelCatList[i].sId;
//            getSubCat(listOfModelCatList[i].sId);
//          }
//      }
//      else
//        getSubCat(catId);
//    //  print(await response.stream.bytesToString());
//     // ModelCatList modelCatList=ModelCatList.fromJson(jsonParsed);
//      //print(modelCatList.catName);
//      setState(() {
//
//      });
//    }
//    else {
//    print(response.reasonPhrase);
//    }

  }


  void getSubCat(String cat) async{
    String url=SHOP_SUBCAT+""+cat;
print("get sub cat $url");
//    var request = http.Request('GET',
//     Uri.parse('http://162.241.201.237:7420/store/shoplist-sub/cat/$cat'));

    var request = http.Request('GET',
        Uri.parse(url));

    http.StreamedResponse response = await request.send();


 //   print(listOfModelSubCatList[0].subCatName);
    if (response.statusCode == 200) {
      //  print(await response.stream.bytesToString());
      // ModelCatList modelCatList=ModelCatList.fromJson(jsonParsed);
      //print(modelCatList.catName);
      String parsed=await response.stream.bytesToString();
      print(parsed);
      List<dynamic> jsonParsed=json.decode(parsed);
      listOfModelSubCatList=List();
      for(int i=0;i<jsonParsed.length;i++) {
        print(jsonParsed[i].toString());
        listOfModelSubCatList.add(ModelSubCatList.fromJson(jsonParsed[i]));
      }
      if(product!=null)
        subcatId=product.subcategory;
     // print("sub cat id is $subcatId ${product.subcategory}");
     setState((){
       show=1;
     });
      setState(() {

      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
//  Widget getTextWidget(String hint,String textIfAny,Size size,{bool isFieldDisable})
//  {
//    return  Container(
//
//      width: size.width-80,
//      height: 50,
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.all(Radius.circular(10)),
//        border: Border.all(width: 3,color: HexColor("#1A0E7009"),style: BorderStyle.solid),
//        color: isFieldDisable!=null&&isFieldDisable?HexColor("#F1F1F1"):Colors.white,
//      ),
//      alignment: Alignment.bottomLeft,
//      margin: EdgeInsets.only(left: 0,top: 10),
//
//      child:Container(
//
//        child: TextFormField(
//
//          initialValue: textIfAny,
//          decoration: InputDecoration(hintText: "$hint",border: InputBorder.none),
//          style: TextStyle(color: Colors.grey,),
//
//        ),
//        margin: EdgeInsets.only(left: 10,bottom: 10),
//
//      ),
//    );
//  }
}