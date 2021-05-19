class ModelUser {
  bool success;
  String token;
  String sId;
  List<Vendor> vendor;

  ModelUser({this.success, this.token, this.sId, this.vendor});

  ModelUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    sId = json['_id'];
    if (json['vendor'] != null) {
      vendor = new List<Vendor>();
      json['vendor'].forEach((v) {
        vendor.add(new Vendor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    data['_id'] = this.sId;
    if (this.vendor != null) {
      data['vendor'] = this.vendor.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vendor {
  String sId;
  String isshoplisted;
  String isservicelisted;
  String isvehiclelisted;
  String category;
  String categoryid;

  Vendor(
      {this.sId,
        this.isshoplisted,
        this.isservicelisted,
        this.isvehiclelisted,
        this.category,
        this.categoryid});

  Vendor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isshoplisted = json['isshoplisted'].toString();
    isservicelisted = json['isservicelisted'];
    isvehiclelisted = json['isvehiclelisted'];
    category = json['category'];
    categoryid = json['categoryid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isshoplisted'] = this.isshoplisted;
    data['isservicelisted'] = this.isservicelisted;
    data['isvehiclelisted'] = this.isvehiclelisted;
    data['category'] = this.category;
    data['categoryid'] = this.categoryid;
    return data;
  }
}