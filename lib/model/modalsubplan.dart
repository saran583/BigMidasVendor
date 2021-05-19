class ModalSubsPlans {
  String sId;
  int days;
  int cost;

  ModalSubsPlans({this.sId, this.days, this.cost});

  ModalSubsPlans.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    days = json['days'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['days'] = this.days;
    data['cost'] = this.cost;
    return data;
  }
}