class ModelProfile {
  List<Vendors> vendors;

  ModelProfile({this.vendors});

  ModelProfile.fromJson(Map<String, dynamic> json) {
    if (json['vendors'] != null) {
      vendors = new List<Vendors>();
      json['vendors'].forEach((v) {
        vendors.add(new Vendors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vendors != null) {
      data['vendors'] = this.vendors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vendors {
  String sId;
  String name;
  String mail;
  String phonenumber;
  String deliveryPickup;
  var storekmServing;
  var servicekmServing;
  var vehiclekmServing;
  var kmCharges;
  String deliveryType;
  List<dynamic> vehicleimages;
  List<dynamic> serviceimages;
  List<dynamic> shopimages;
  var deliveryCharges;
  String freeDeliveryAbove;
  String activeInactive;
  String stateCountry;
  String image;
  String aboutus;
  String isshoplisted;
  String isservicelisted;
  String isvehiclelisted;

  Vendors(
      {this.sId,
        this.name,
        this.mail,
        this.phonenumber,
        this.deliveryPickup,
        this.storekmServing,
        this.servicekmServing,
        this.vehiclekmServing,
        this.kmCharges,
        this.deliveryType,
        this.shopimages,
        this.serviceimages,
        this.vehicleimages,
        this.deliveryCharges,
        this.freeDeliveryAbove,
        this.activeInactive,
        this.stateCountry,
        this.image,
        this.aboutus,
        this.isshoplisted,
        this.isservicelisted,
        this.isvehiclelisted});

  Vendors.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    mail = json['mail'];
    aboutus = json['aboutus'];
    phonenumber = json['phonenumber'];
    deliveryPickup = json['delivery_pickup'];
    storekmServing = json['store_km_serving'];
    servicekmServing = json['service_km_serving'];
    vehiclekmServing = json['vehicle_km_serving'];
    kmCharges = json['km_charges'];
    deliveryType = json['delivery_type'];
    vehicleimages = json['vehicleimages'];
    serviceimages = json['serviceimages'];
    shopimages = json['shopimages'];
    deliveryCharges = json['delivery_charges'];
    freeDeliveryAbove = json['free_delivery_above'];
    activeInactive = json['active_inactive'];
    stateCountry = json['state_country'];
    image = json['image'];
    isshoplisted = json['isshoplisted'];
    isservicelisted = json['isservicelisted'];
    isvehiclelisted = json['isvehiclelisted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['mail'] = this.mail;
    data['aboutus'] = this.aboutus;
    data['phonenumber'] = this.phonenumber;
    data['delivery_pickup'] = this.deliveryPickup;
    data['store_km_serving'] = this.storekmServing;
    data['service_km_serving'] = this.servicekmServing;
    data['vehicle_km_serving'] = this.vehiclekmServing;
    data['km_charges'] = this.kmCharges;
    data['delivery_type'] = this.deliveryType;
    data['vehicleimages'] = this.vehicleimages;
    data['serviceimages'] = this.serviceimages;
    data['shopimages'] = this.shopimages;
    data['delivery_charges'] = this.deliveryCharges;
    data['free_delivery_above'] = this.freeDeliveryAbove;
    data['active_inactive'] = this.activeInactive;
    data['state_country'] = this.stateCountry;
    data['image'] = this.image;
    data['isshoplisted'] = this.isshoplisted;
    data['isservicelisted'] = this.isservicelisted;
    data['isvehiclelisted'] = this.isvehiclelisted;
    return data;
  }
}