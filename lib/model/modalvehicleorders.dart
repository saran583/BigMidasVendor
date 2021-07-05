import 'dart:convert';

ModalVehicleOrders modalVehicleOrdersFromJson(String str) => ModalVehicleOrders.fromJson(json.decode(str));

String modalVehicleOrdersToJson(ModalVehicleOrders data) => json.encode(data.toJson());

class ModalVehicleOrders {
  ModalVehicleOrders({
    this.products,
  });

  List<Product> products;

  factory ModalVehicleOrders.fromJson(Map<String, dynamic> json) => ModalVehicleOrders(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  Product({
  this.id,
  this.customername,
  this.customerid,
  this.customerphone,
  this.orederid,
  this.status,
  this.bookingto,
  this.bookingfrom,
  this.distance,
  this.vehicleserviceid,
  this.price,
  this.date,
  this.time,
  this.from,
  this.to,
  });

  String id;
  String customername;
  String customerid;
  String customerphone;
  String orederid;
  String status;
  String bookingto;
  String bookingfrom;
  String distance;
  String vehicleserviceid;
  String price;
  String date;
  String time;
  String from;
  String to;


  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    customername: json["customername"],
    customerid: json["customerid"],
    customerphone: json["customerphone"].toString(),
    orederid: json["orederid"].toString(),
    status: json["status"].toString(),
    bookingto: json["bookingto"],
    bookingfrom: json["bookingfrom"],
    distance: json["distance"].toString(),
    vehicleserviceid: json["vehicleserviceid"],
    price: json["price"].toString(),
    date: json["date"],
    time: json["time"],
    from: json["from"],
    to: json["to"],
    // createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customername": customername,
    "customerid": customerid,
    "customerphone": customerphone,
    "orederid": orederid,
    "status": status,
    "bookingto": bookingto,
    "bookingfrom": bookingfrom,
    "distance": distance,
    "vehicleserviceid": vehicleserviceid,
    "price": price,
    "date": date,
    "time": time,
    "from":from,
    "to":to,
    // "createdAt": createdAt.toIso8601String(),
  };
}
