import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bigmidasvendor/common.dart';
import 'package:bigmidasvendor/model/modelproduct.dart';
import 'package:bigmidasvendor/provider/providershop.dart';
import 'package:bigmidasvendor/screens/addproduct.dart';
import 'package:bigmidasvendor/screens/editsingleproduct.dart';
import 'package:bigmidasvendor/widgets/showdialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreProductsPage extends StatefulWidget {
  String title;
  String subTitle;
  String imageLink;
  Products products;
  StoreProductsPage({this.title, this.subTitle,this.imageLink,this.products});

  @override
  _StoreProductsPageState createState() =>
      _StoreProductsPageState(title: this.title, subTitle: this.subTitle);
}

class _StoreProductsPageState extends State<StoreProductsPage> {
  String title;
  String subTitle;

  _StoreProductsPageState({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[

      Row(children: <Widget>[
      Image.network(
            BASE_URL_IMAGES+"${widget.imageLink}",
            fit: BoxFit.fill,height: 85,width: 80,),
       Container(
         width: 125,
         margin: EdgeInsets.only(left: 25),
         child:  Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
         Text(this.title),
         Text(this.subTitle),

       ],
       ),
       ),

      ],
      ),
       Column(children: <Widget>[
         FlatButton(
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(18.0),
               side: BorderSide(color: Colors.green)),
           onPressed: () => {
             //Navigator.pushNamed(context, EditSingleProduct.routeName,arguments: widget.products)
             Navigator.pushReplacementNamed(context, AddProduct.routeName,arguments: widget.products)
           },
           child: Text(
             "Edit",
             style: TextStyle(fontWeight: FontWeight.w800, color: Colors.green),
           ),
         ),
         FlatButton(
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(18.0),
               side: BorderSide(color: Colors.red)),
           onPressed: () => {
             //Navigator.pushNamed(context, EditSingleProduct.routeName,arguments: widget.products)
             getCustomDialog(context,
             "Confirm Deletion",
             "This action will permanently product ",
    DialogType.INFO,
    oktext: "Delete",
    okFunc: (){
      Provider.of<ProviderShop>(context,listen:false).deleteProduct(context,widget.products.sId);
    },cancelText: "Cancel")

           },
           child: Text(
             "Delete",
             style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
           ),
         ),
       ],
       )

      ],
    ),
//      margin: EdgeInsets.all(10),
//      child: ListTile(
//        leading: Container(
//          child: Image.asset(
//            "assets/images/headphone.jpg",
//            fit: BoxFit.cover,
//          ),
//        ),
//        title: Text(this.title),
//        subtitle: Text(this.subTitle),
//        trailing: Column(children: <Widget>[
//          FlatButton(
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(18.0),
//                side: BorderSide(color: Colors.green)),
//            onPressed: () => {
//              Navigator.pushNamed(context, AddProduct.routeName,arguments: -1)
//            },
//            child: Text(
//              "Edit",
//              style: TextStyle(fontWeight: FontWeight.w800, color: Colors.green),
//            ),
//          ),
//
//        ],
//        ),
//        isThreeLine: true,
//      ),
    );
  }
}
