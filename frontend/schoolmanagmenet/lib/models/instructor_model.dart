import 'dart:convert';

List<instructorModel> userFromJson(String str) =>
    List<instructorModel>.from(json.decode(str).map((x) => instructorModel.fromJson(x)));
String userToJson(List<instructorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class instructorModel{

  instructorModel({
    this.id = "",
    this.firstName = "",
    this.lastName = "",
    this.phoneNumber = "",
    this.courses = "",
  });

  String id;
  String firstName;
  String lastName;
  String phoneNumber;
  String courses;

  factory instructorModel.fromJson(Map<String, dynamic> json) => instructorModel(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    courses: json["courses"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "phoneNumber": phoneNumber,
    "courses": courses,
  };
}