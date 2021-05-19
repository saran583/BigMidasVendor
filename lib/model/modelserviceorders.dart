class ModalServiceOrdes {
  List<Products> products;

  ModalServiceOrdes({this.products});

  ModalServiceOrdes.fromJson(Map<String, dynamic> json) {
    print("entered first");
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    print("done with first");
  }

  Map<String, dynamic> toJson() {
    print("entered second");
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }print("done with sec ond");
    return data;
  }
}

class Products {
  String sId;
  String title;
  String description;
  String location;
  String custname;
  String custphone;
  String date;
  String time;
  String status;
  String custid;
  String orderid;
  String price;

  Products(
      {this.sId,
      this.title,
      this.description,
      this.location,
      this.price,
      this.custname,
      this.custphone,
      this.status,
      this.date,
      this.time,
      this.custid,
      this.orderid,
      });

  Products.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    title = json["title"];
    description = json["jobdescription"];
    location = json["location"];
    price = json["price"];
    date = json["date"];
    time = json["time"];
    status = json["status"].toString();
    custname = json["customername"];
    custid = json["customerid"];
    custphone = json["customerphone"].toString();
    orderid = json["orderid"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['jobdescription'] = this.description;
    data['location'] = this.location;
    data['price'] = this.price;
    data['date'] = this.date;
    data['time'] = this.time;
    data['status'] = this.status;
    data['customername'] = this.custname;
    data['customerid'] = this.custid;
    data['customerphone'] = this.custphone;
    data['orderid'] = this.orderid;

    return data;
  }
}