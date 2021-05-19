class ModalMySubs {
  String sId;
  int totaldayssubscribed;
  int daysremaining;

  ModalMySubs({this.sId, this.totaldayssubscribed, this.daysremaining});

  ModalMySubs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totaldayssubscribed = json['totaldayssubscribed'];
    daysremaining = json['daysremaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['totaldayssubscribed'] = this.totaldayssubscribed;
    data['daysremaining'] = this.daysremaining;
    return data;
  }
}