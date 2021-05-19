class ModelVehicleCategory {
  String sId;
  String catName;
  String avatar;
  int iV;

  ModelVehicleCategory({this.sId, this.catName, this.avatar, this.iV});

  ModelVehicleCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    catName = json['cat_name'];
    avatar = json['avatar'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['cat_name'] = this.catName;
    data['avatar'] = this.avatar;
    data['__v'] = this.iV;
    return data;
  }
}