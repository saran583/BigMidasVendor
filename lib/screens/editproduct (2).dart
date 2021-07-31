import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bigmidasvendor/common.dart';
import 'package:bigmidasvendor/model/modelproduct.dart';
import 'package:bigmidasvendor/provider/providershop.dart';
import 'package:bigmidasvendor/screens/addproduct.dart';
import 'package:bigmidasvendor/widgets/drawer.dart';
import 'package:bigmidasvendor/widgets/showdialog.dart';
import 'package:bigmidasvendor/widgets/testdraw.dart';
import 'package:bigmidasvendor/widgets/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'StoreHistory.dart';
import 'StoreProductsPage.dart';

class EditProduct extends StatefulWidget {
  static String routeName = "/editproduct";
  @override
  EditProductState createState() => EditProductState();
}

class EditProductState extends State<EditProduct> {
  int showDetails = 0;
  bool isResultsFecthed = false;
  int productsLength = 0;
  var searchList = [];
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
    Provider.of<ProviderShop>(context, listen: false)
        .getProductsByVendorId(context);
  }

  ModelProducts modelProducts;

  @override
  Widget build(BuildContext context) {
    print("i am isreslut");

    print(this.productsLength);
    if (this.productsLength == 0) {
      modelProducts =
          Provider.of<ProviderShop>(context, listen: true).modelProducts;

      this.searchList = modelProducts.products;
    }

    final String args = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        appBar: getAppBar(_scaffoldKey, context),
        // drawer: drawer(context, "username", "balance"),
        drawer: TestDraw(),
        //body:modelProducts==null?Center(child:CircularProgressIndicator()) :Container(
        body: Provider.of<ProviderShop>(context, listen: true).isLoadingProducts
            ? Center(child: CircularProgressIndicator())
            : Container(
                height: size.height,
                width: size.width,
                child: modelProducts == null ||
                        this.modelProducts.products.length == 0
                    ? Center(
                        child: Text(
                          "No Products Listed",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      )
                    : ListView(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            // controller: controller,
                            onChanged: (value) {
                              var fliteredArray = [];
                              for (int k = 0;
                                  k < modelProducts.products.length;
                                  k++) {
                                print(value);
                                print(modelProducts.products[k].productname);
                                if (modelProducts.products[k].productname
                                    .contains(value)) {
                                  fliteredArray.add(modelProducts.products[k]);
                                }
                              }
                              print(fliteredArray);
                              this.setState(() {
                                this.productsLength =
                                    modelProducts.products.length;
                                this.searchList = fliteredArray;
                              });
                            },
                            // focusNode: focusNode,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600]),
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x4437474F),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
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
                        for (int i = 0; i < searchList.length; i++)
                          // Text(searchList[i].productname),
                          Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.network(
                                      BASE_URL_IMAGES +
                                          "${searchList[i].prodphoto != null && searchList[i].prodphoto.length > 0 ? searchList[i].prodphoto[0] : ""}",
                                      fit: BoxFit.fill,
                                      height: 85,
                                      width: 80,
                                    ),
                                    Container(
                                      width: 125,
                                      margin: EdgeInsets.only(left: 25),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(searchList[i].productname),
                                          Text(
                                              "\u20A8 ${searchList[i].discountedprodprice}\n${searchList[i].category}'"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.green)),
                                      onPressed: () => {
                                        //Navigator.pushNamed(context, EditSingleProduct.routeName,arguments: widget.products)
                                        Navigator.pushReplacementNamed(
                                            context, AddProduct.routeName,
                                            arguments: searchList[i])
                                      },
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.green),
                                      ),
                                    ),
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)),
                                      onPressed: () => {
                                        //Navigator.pushNamed(context, EditSingleProduct.routeName,arguments: widget.products)
                                        getCustomDialog(
                                            context,
                                            "Confirm Deletion",
                                            "This action will permanently product ",
                                            DialogType.INFO,
                                            oktext: "Delete", okFunc: () {
                                          Provider.of<ProviderShop>(context,
                                                  listen: false)
                                              .deleteProduct(
                                                  context, searchList[i].sId);
                                        }, cancelText: "Cancel")
                                      },
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.red),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        // StoreProductsPage(
                        //   title: "${searchList[i].productname}",
                        //   subTitle:
                        //       "\u20A8 ${searchList[i].discountedprodprice}\n${searchList[i].category}'",
                        //   imageLink: searchList[i].prodphoto != null &&
                        //           searchList[i].prodphoto.length > 0
                        //       ? searchList[i].prodphoto[0]
                        //       : "",
                        //   products: searchList[i],
                        // ),
                      ]),
              ));
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
