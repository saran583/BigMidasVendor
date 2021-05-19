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
  int prodctcost;
  String customername;
  String customerphone;
  String ordernote;
  int discountedprodprice;
  String deliverycharges;
  // int freedelivery;
  String totalprice;
  int quantity;
  String orederid;
  String status;
  String ordertime;
  String customfield;
  String customerid;

  Products(
      {this.sId,
        this.productname,
        this.prodctcost,
        this.customername,
        this.customerphone,
        this.discountedprodprice,
        this.deliverycharges,
        // this.freedelivery,
        this.totalprice,
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
    prodctcost = json['prodctcost'];
    customerid = json['customerid'];
    customername = json['customername'];
    customerphone = json['customerphone'].toString();
    discountedprodprice = json['discountedprodprice'];
    totalprice = json['totalprice'];
    deliverycharges = json['deliverycharges'];
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
    data['prodctcost'] = this.prodctcost;
    data['customername'] = this.customername;
    data['customerphone'] = this.customerphone;
    data['customerid'] = this.customerid;
    data['discountedprodprice'] = this.discountedprodprice;
    data['totalprice'] = this.totalprice;
    data['deliverycharges'] = this.deliverycharges;
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