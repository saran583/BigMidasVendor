class ModelSubCatList {
  String sId;
  String subCatName;
  String catName;

  ModelSubCatList({this.sId, this.subCatName, this.catName});

  ModelSubCatList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    subCatName = json['sub_cat_name'];
    catName = json['cat_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['sub_cat_name'] = this.subCatName;
    data['cat_name'] = this.catName;
    return data;
  }
}