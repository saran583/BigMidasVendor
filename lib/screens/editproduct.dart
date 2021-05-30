
import 'package:bigmidasvendor/model/modelproduct.dart';
import 'package:bigmidasvendor/provider/providershop.dart';
import 'package:bigmidasvendor/widgets/drawer.dart';
import 'package:bigmidasvendor/widgets/testdraw.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'StoreHistory.dart';
import 'StoreProductsPage.dart';

class EditProduct extends StatefulWidget {
  static String routeName="/editproduct";
  @override
  EditProductState createState() => EditProductState();
}

class EditProductState extends State<EditProduct> {

  int showDetails = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//  static List<Widget> _widgetOptions1 = <Widget>[
//    StoreHistory(),
//    StoreHistory(),
//    StoreHistory(),
//  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProviderShop>(context,listen:false).getProductsByVendorId(context);
  }
  @override
  Widget build(BuildContext context) {
    ModelProducts modelProducts=Provider.of<ProviderShop>(context,listen:true).modelProducts;
    final String args = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery
        .of(context)
        .size;
    return
      Scaffold(
          key: _scaffoldKey,
          appBar: getAppBar(_scaffoldKey,context),
          // drawer: drawer(context, "username", "balance"),
          drawer: TestDraw(),
          //body:modelProducts==null?Center(child:CircularProgressIndicator()) :Container(
        body:Provider.of<ProviderShop>(context,listen:true).isLoadingProducts
            ?Center(child:CircularProgressIndicator())
          :Container(
            height: size.height,
            width: size.width,
            child:
            modelProducts==null||modelProducts.products.length==0
                ?Center(child: Text("No Products Listed",style: TextStyle(fontSize: 20,color: Colors.red),),)
                :ListView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  // controller: controller,
                  // focusNode: focusNode,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x4437474F),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: "Search Product",
                    contentPadding: const EdgeInsets.only(
                      left: 16,
                      right: 20,
                      top: 14,
                      bottom: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              for(int i=0;i<modelProducts.products.length;i++)
              StoreProductsPage(
                title: "${modelProducts.products[i].productname}",
                subTitle: "\u20A8 ${modelProducts.products[i].discountedprodprice}\n${modelProducts.products[i].category}'",
                imageLink:modelProducts.products[i].prodphoto!=null&& modelProducts.products[i].prodphoto.length>0?
                modelProducts.products[i].prodphoto[0]:
                "",
                products: modelProducts.products[i],
              ),

            ]
            ),
          )
      );
  }
//      Container(
//      child: Column(
//        children: [
//          VichileHistory(),
//          VichileHistory(),
//          VichileHistory(),
//        ],
//      ),
//    );
}
