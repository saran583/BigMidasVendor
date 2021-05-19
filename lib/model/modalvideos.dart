class ModelVideos {
  String sId;
  String name;
  String url;
  String displayOption;

  ModelVideos({this.sId, this.name, this.url, this.displayOption});

  ModelVideos.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    url = json['url'];
    displayOption = json['display_option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['url'] = this.url;
    data['display_option'] = this.displayOption;
    return data;
  }
}