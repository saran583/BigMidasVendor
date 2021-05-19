class ModelPages {
  String sId;
  String pageName;
  String description;

  ModelPages({this.sId, this.pageName, this.description});

  ModelPages.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    pageName = json['page_name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['page_name'] = this.pageName;
    data['description'] = this.description;
    return data;
  }
}