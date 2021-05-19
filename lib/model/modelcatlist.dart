
class ModelCatList {
String sId;
String catName;
String createddate;
int iV;

ModelCatList({this.sId, this.catName, this.createddate, this.iV});

ModelCatList.fromJson(Map<String, dynamic> json) {
sId = json['_id'];
catName = json['cat_name'];
createddate = json['createddate'];
iV = json['__v'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['_id'] = this.sId;
  data['cat_name'] = this.catName;
  data['createddate'] = this.createddate;
  data['__v'] = this.iV;
  return data;
}
}