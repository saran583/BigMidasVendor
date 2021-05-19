class ModelProducts {
  List<Products> products;

  ModelProducts({this.products});

  ModelProducts.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Products {
  String sId;
  String productname;
  String category;
  String subcategory;
  int prodctcost;
  int discountedprodprice;
  List<String> prodphoto;
  String vendorid;
  String unit;
  int stock;
  String description;

  Products(
      {this.sId,
        this.productname,
        this.category,
        this.subcategory,
        this.prodctcost,
        this.discountedprodprice,
        this.prodphoto,
        this.vendorid,
        this.unit,
        this.stock,
        this.description});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productname = json['productname'];
    category = json['category'];
    subcategory = json['subcategory'];
    prodctcost = json['prodctcost'];
    discountedprodprice = json['discountedprodprice'];
    prodphoto = json['prodphoto'].cast<String>();
    vendorid = json['vendorid'];
    unit = json['unit'].toString();
    stock = json['stock'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productname'] = this.productname;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['prodctcost'] = this.prodctcost;
    data['discountedprodprice'] = this.discountedprodprice;
    data['prodphoto'] = this.prodphoto;
    data['vendorid'] = this.vendorid;
    data['unit'] = this.unit.toString();
    data['stock'] = this.stock;
    data['description'] = this.description;
    return data;
  }
}

//class ModelProducts {
//  List<Products> products;
//
//  ModelProducts({this.products});
//
//  ModelProducts.fromJson(Map<String, dynamic> json) {
//    if (json['products'] != null) {
//      products = new List<Products>();
//      json['products'].forEach((v) {
//        products.add(new Products.fromJson(v));
//      });
//    }
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.products != null) {
//      data['products'] = this.products.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//}
//
//class Products {
//  String sId;
//  String productname;
//  String category;
//  String subcategory;
//  int prodctcost;
//  int discountedprodprice;
//  String prodphoto;
//  String vendorid;
//
//  Products(
//      {this.sId,
//        this.productname,
//        this.category,
//        this.subcategory,
//        this.prodctcost,
//        this.discountedprodprice,
//        this.prodphoto,
//        this.vendorid});
//
//  Products.fromJson(Map<String, dynamic> json) {
//    sId = json['_id'];
//    productname = json['productname'];
//    category = json['category'];
//    subcategory = json['subcategory'];
//    prodctcost = json['prodctcost'];
//    discountedprodprice = json['discountedprodprice'];
//    prodphoto = json['prodphoto'];
//    vendorid = json['vendorid'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['_id'] = this.sId;
//    data['productname'] = this.productname;
//    data['category'] = this.category;
//    data['subcategory'] = this.subcategory;
//    data['prodctcost'] = this.prodctcost;
//    data['discountedprodprice'] = this.discountedprodprice;
//    data['prodphoto'] = this.prodphoto;
//    data['vendorid'] = this.vendorid;
//    return data;
//  }
//}
