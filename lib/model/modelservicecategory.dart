class ModalServiceCategory {
  String sId;
  String catName;
  int iV;
  String avatar;

  ModalServiceCategory({this.sId, this.catName, this.iV, this.avatar});

  ModalServiceCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    catName = json['cat_name'];
    iV = json['__v'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['cat_name'] = this.catName;
    data['__v'] = this.iV;
    data['avatar'] = this.avatar;
    return data;
  }
}