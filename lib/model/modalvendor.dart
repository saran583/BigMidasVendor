class ModelVendor
{
  final String userId;
  final String mail;
  final String phonenumber;
  final String password;
  final String createdDate;
  final String name;

  ModelVendor({this.userId,this.mail,this.phonenumber, this.password,this.createdDate,this.name});
  factory ModelVendor.fromJson(Map<String, dynamic> parsedJson) {
//    print(parsedJson['token']);
//    print(parsedJson['id']);
    return new ModelVendor(
        userId: parsedJson['_id'] ?? "",
        mail: parsedJson['mail'] ?? "",
        phonenumber: parsedJson['phonenumber'] ?? "",
        password: parsedJson['password'] ?? "",
        createdDate: parsedJson['createddate'] ?? "",
        name: parsedJson['name'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
//      "userid": this.userId,
//      "usertype": this.userType
      "_id": this.userId,
      "mail": this.mail,
      "phonenumber": this.phonenumber,
      "name": this.name,
      "password": this.password,
      "createddate": this.createdDate,
    };
  }

}