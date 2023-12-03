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
    this.department = "",
    this.phoneNumber = 0,
    this.courses = const [],
  });

  String id;
  String firstName;
  String lastName;
  String department;
  int phoneNumber;
  List<String> courses;

  factory instructorModel.fromJson(Map<String, dynamic> json) => instructorModel(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    department: json["department"],
    phoneNumber: json["phoneNumber"],
    courses: List<String>.from(json["courses"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "department": department,
    "phoneNumber": phoneNumber,
    "courses": List<dynamic>.from(courses.map((x) => x)),
  };
}
