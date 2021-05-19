class ModelNotification {
  List<Result> result;

  ModelNotification({this.result});

  ModelNotification.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String sId;
  String type;
  String message;
  String id;

  Result({this.sId, this.type, this.message, this.id});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    message = json['message'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['message'] = this.message;
    data['id'] = this.id;
    return data;
  }
}