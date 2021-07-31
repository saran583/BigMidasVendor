class Modeldetails {
  List<Vendors> vendors;

  Modeldetails({this.vendors});

  Modeldetails.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      vendors = new List<Vendors>();
      json['result'].forEach((v) {
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
  String sid;
  String state;
  String area;
  String city;
  String location;
  String vendorid;
  String address;

  Vendors(
      {
        this.sid,
      this.area,
      this.city,
      this.location,
      this.state,
      this.vendorid, 
      this.address, 
      });

  Vendors.fromJson(Map<String, dynamic> json) {
    sid = json['_id'];
    state = json['state'];
    area = json['area'];
    city = json["city"];
    location = json["location_map"];
    vendorid = json["vendorid"];
    address = json["address"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sid;
    data['vendorid'] = this.vendorid;
    data['city'] = this.city;
    data['area'] = this.area;
    data['state'] = this.state;
    data['location_map'] = this.location;
    data['address']= this.address;
    return data;
  }
}