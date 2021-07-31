class ModelShopOrders {
  List<Products> products;

  ModelShopOrders({this.products});

  ModelShopOrders.fromJson(Map<String, dynamic> json) {
    print("entered first");
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
  String customername;
  String customerphone;
  String ordernote;
  String discountedprodprice;
  String deliverycharges;
  String address;
  String productids;
  // int freedelivery;
  String totalprice;
  dynamic productimage;
  String quantity;
  String orederid;
  String status;
  String ordertime;
  String customfield;
  String customerid;

  Products(
      {this.sId,
        this.productname,
        this.customername,
        this.customerphone,
        this.discountedprodprice,
        this.deliverycharges,
        this.address,
        this.productids,
        // this.freedelivery,
        this.totalprice,
        this.productimage,
        this.quantity,
        this.orederid,
        this.ordernote,
        this.status,
        this.ordertime,
        this.customfield,
        this.customerid
        });

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productname = json['productname'];
    customerid = json['customerid'];
    productids = json['productids'];
    customername = json['customername'];
    customerphone = json['customerphone'].toString();
    discountedprodprice = json['discountedprodprice'];
    productimage = json['productimage'];
    totalprice = json['totalprice'];
    deliverycharges = json['deliverycharges'];
    address = json['address'];
    // freedelivery = json['freedelivery'];
    quantity = json['quantity'];
    orederid = json['orederid'].toString();
    ordernote = json['ordernote'];
    status = json['status'].toString();
    ordertime = json['ordertime'];
    customfield = json['customfield'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productname'] = this.productname;
    data['productids'] = this.productids;
    data['customername'] = this.customername;
    data['customerphone'] = this.customerphone;
    data['customerid'] = this.customerid;
    data['discountedprodprice'] = this.discountedprodprice;
    data['totalprice'] = this.totalprice;
    data['productimage'] = this.productimage;
    data['deliverycharges'] = this.deliverycharges;
    data['address'] = this.address;
    // data['freedelivery'] = this.freedelivery;
    data['quantity'] = this.quantity;
    data['orederid'] = this.orederid;
    data['ordernote'] = this.ordernote;
    data['status'] = this.status;
    data['ordertime'] = this.ordertime;
    data['customfield'] = this.customfield;
    return data;
  }
}