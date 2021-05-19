class ModelVehicleProfile {
  String sId;
  String city;
  String area;
  String address;
  String panAdhaar;
  String drivingLicense;
  List<String> photos;
  String rc;
  String fc;
  List<String> vehicleCategory;
  List<String> vehicleType;
  List<Null> category;
  List<String> vendor;
  List<Null> review;
  String createddate;

  ModelVehicleProfile(
      {this.sId,
        this.city,
        this.area,
        this.address,
        this.panAdhaar,
        this.drivingLicense,
        this.photos,
        this.rc,
        this.fc,
        this.vehicleCategory,
        this.vehicleType,
        this.category,
        this.vendor,
        this.review,
        this.createddate});

  ModelVehicleProfile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    city = json['city'];
    area = json['area'];
    address = json['address'];
    panAdhaar = json['pan_adhaar'];
    drivingLicense = json['driving_license'];
    rc = json['rc'];
    fc = json['fc'];
    photos = json['images'].cast<String>();
    vehicleCategory = json['vehicle_category'].cast<String>();
    vehicleType = json['vehicle_type'].cast<String>();
//    if (json['category'] != null) {
//      category = new List<Null>();
//      json['category'].forEach((v) {
//        category.add(new Null.fromJson(v));
//      });
//    }
    vendor = json['vendor'].cast<String>();
//    if (json['review'] != null) {
//      review = new List<Null>();
//      json['review'].forEach((v) {
//        review.add(new Null.fromJson(v));
//      });
//    }
    createddate = json['createddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['city'] = this.city;
    data['area'] = this.area;
    data['address'] = this.address;
    data['pan_adhaar'] = this.panAdhaar;
    data['driving_license'] = this.drivingLicense;
    data['photos'] = this.photos;
    data['rc'] = this.rc;
    data['fc'] = this.fc;
    data['vehicle_category'] = this.vehicleCategory;
    data['vehicle_type'] = this.vehicleType;
//    if (this.category != null) {
//      data['category'] = this.category.map((v) => v.toJson()).toList();
//    }
    data['vendor'] = this.vendor;
//    if (this.review != null) {
//      data['review'] = this.review.map((v) => v.toJson()).toList();
//    }
    data['createddate'] = this.createddate;
    return data;
  }
}