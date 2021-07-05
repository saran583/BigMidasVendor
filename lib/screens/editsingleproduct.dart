import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bigmidasvendor/model/modelcatlist.dart';
import 'package:bigmidasvendor/model/modelproduct.dart';
import 'package:bigmidasvendor/model/modelsubcat.dart';
import 'package:bigmidasvendor/provider/providerlogn.dart';
import 'package:bigmidasvendor/provider/providershop.dart';
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
import 'dashboard.dart';


class EditSingleProduct extends StatefulWidget
{

  static String routeName="/editsingleproduct";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditSingleProductState();
  }
}
class EditSingleProductState extends State<EditSingleProduct>
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Products product=ModalRoute.of(context).settings.arguments;
      controllerPname.text=product.productname;
      controllerdisprice.text=product.discountedprodprice.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    //getCategory();
    //int screen=ModalRoute.of(context).settings.arguments;
    Products product=ModalRoute.of(context).settings.arguments;
    //print("screen value is $screen");
    String title="${product.productname}";
    String category="${product.category}";
    String subcategory="${product.subcategory}";
    String discountedPrice="${product.discountedprodprice}";
    //String photo="Product Photo";
    //String unit=product.


    Size size=MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
        backgroundColor: HexColor("#EEEEEE"),
        //appBar: MyAppBar(),
        body: SingleChildScrollView(

            child:Form(
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
                    getTextWidget("","",size,controllerPname),

                    SizedBox(height: 20,),

                    getTItleWidget("Category"),
                    //getTextWidget("$category","Enter Category",size,controllerCat),

                    listOfModelCatList==null?Container(): Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 30,right: 20),
                      child:  DropdownButtonFormField<ModelCatList>(
                        isExpanded: true,

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
                    listOfModelSubCatList==null?Container():   getTItleWidget("Sub Category"),
                    // getTextWidget("$subcategory","",size,controllerSubCat),
                    listOfModelSubCatList==null?Container():
                    listOfModelSubCatList.isEmpty?Text("No Sub-Category Found",style: TextStyle(color: Colors.red),):Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 30,right: 20),
                      child:  DropdownButtonFormField<ModelSubCatList>(
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
                    getTextWidget("$discountedPrice","Enter Discounted Price",size,controllerdisprice),
                    SizedBox(height: 20,),
                    //  getTItleWidget("Product Price"),
                    getTextWidget("Unit","Unit",size,controllerUnit),
                    SizedBox(height: 20,),
                    //  getTItleWidget("Product Price"),
                    getTextWidget("Stock","Stock",size,controllerStock),
                    SizedBox(height: 20,),
                    //  getTItleWidget("Product Price"),
                    getTextWidget("Description","Description",size,controllerDesc),
                    SizedBox(height: 20,),
                     // getTItleWidget("Product Photo"),
                    files!=null?Container(): getTextWidget("Product Photo","",size,controllerPhotos,isFieldEnabled: false),

                    files==null?Container(): Container(
                      margin: EdgeInsets.only(top: 10),
                      child:GestureDetector(
                        onTap: (){
                          selectFiles();
                        },
                        child: Image.file(files,height: 90,width: 90,),),) ,

                    Container(
                      margin: EdgeInsets.all(20),
                      child: isLoading?CircularProgressIndicator():getAwesomeButton("Add Product",()async{

                        if(!_keyValidationForm.currentState.validate())return;
                        if(subcatId==null)
                        {
                          getCustomDialog(context, "Sub-category required","Please provider Sub-category",DialogType.INFO);
                          return ;
                        }
//                    String pName,
//                        String cat,
//                    String subcat,
//                    String prodcost,
//                    String discost,
//                    String unit,
//                    String stock,
//                    String desc,
//                    List<File> files,
                        setState(() {
                          isLoading=true;
                        });
//                    Timer(Duration(seconds: 4),(){
//                      setState(() {
//                        if(isLoading)isLoading=false;
//                        getCustomDialog(context, "Action Sucessfull", "Product Added",DialogType.SUCCES);
//                      });
//                    });

                        await  Provider.of<ProviderShop>(context,listen: false).addProduct(
                            context,
                            controllerPname.text,
                            catId,
                            subcatId,
                            controllerdisprice.text,
                            controllerdisprice.text,
                            controllerUnit.text,
                            controllerStock.text,
                            controllerDesc.text,
                            files,
                          "http://162.241.201.237/store/editproduct/${product.sId}",

                        );
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

  Widget getTextWidget(String hint,String textIfAny,Size size,TextEditingController _controller,{bool isFieldEnabled})
  {
    return GestureDetector(
      onTap: (){
        if(hint=="Product Photo"){
          selectFiles();
        }
      },
      child:Container(
        width: size.width-80,
        height: 70,
        alignment: Alignment.bottomLeft,
        margin: EdgeInsets.only(left: 0,top: 10),
        child: TextFormField(
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
          style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),

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
    var request = http.Request('GET', Uri.parse('http://162.241.201.237/store/shoplist/cat'));


    http.StreamedResponse response = await request.send();

    String parsed=await response.stream.bytesToString();
    List<dynamic> jsonParsed=jsonDecode(parsed);
    listOfModelCatList=List();
    for(int i=0;i<jsonParsed.length;i++) {
      print(jsonParsed[i].toString());
      listOfModelCatList.add(ModelCatList.fromJson(jsonParsed[i]));
    }
    setState(() {

    });
//  print(listOfModelCatList[0].catName);
    if (response.statusCode == 200) {
      //  print(await response.stream.bytesToString());
      // ModelCatList modelCatList=ModelCatList.fromJson(jsonParsed);
      //print(modelCatList.catName);
    }
    else {
      print(response.reasonPhrase);
    }

  }


  void getSubCat(String cat) async{
    var request = http.Request('GET',
        Uri.parse('http://162.241.201.237/store/shoplist-sub/cat/$cat'));



    http.StreamedResponse response = await request.send();

    String parsed=await response.stream.bytesToString();
    List<dynamic> jsonParsed=jsonDecode(parsed);
    listOfModelSubCatList=List();
    for(int i=0;i<jsonParsed.length;i++) {
      print(jsonParsed[i].toString());
      listOfModelSubCatList.add(ModelSubCatList.fromJson(jsonParsed[i]));
    }
    setState(() {

    });
    //   print(listOfModelSubCatList[0].subCatName);
    if (response.statusCode == 200) {
      //  print(await response.stream.bytesToString());
      // ModelCatList modelCatList=ModelCatList.fromJson(jsonParsed);
      //print(modelCatList.catName);
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