class ModelVehicleSubCategory {
  String sId;
  String subCatName;
  String catName;

  ModelVehicleSubCategory({this.sId, this.subCatName, this.catName});

  ModelVehicleSubCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    subCatName = json['sub_cat_name'];
    catName = json['cat_name'];
    print(subCatName);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['sub_cat_name'] = this.subCatName;
    data['cat_name'] = this.catName;
    return data;
  }
}