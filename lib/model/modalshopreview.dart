class ModalShopReview {
  String sId;
  int rating;
  String review;
  String createdat;
  String customer;
  String customerpic;

  ModalShopReview(
      {this.sId,
        this.rating,
        this.review,
        this.createdat,
        this.customer,
        this.customerpic});

  ModalShopReview.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rating = json['rating'];
    review = json['review'];
    createdat = json['createdat'];
    customer = json['customer'];
    customerpic = json['customerpic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['createdat'] = this.createdat;
    data['customer'] = this.customer;
    data['customerpic'] = this.customerpic;
    return data;
  }
}