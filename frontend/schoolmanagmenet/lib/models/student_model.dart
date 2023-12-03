import 'dart:convert';

List<studentModel> userFromJson(String str) =>
    List<studentModel>.from(json.decode(str).map((x) => studentModel.fromJson(x)));
String userToJson(List<studentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class studentModel {
  String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String age;
  String gender;

  studentModel({
    this.id = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.phoneNumber = "",
    this.age = "",
    this.gender = "",
  });

  factory studentModel.fromJson(Map<String, dynamic> json) => studentModel(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    age: json["age"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phoneNumber": phoneNumber,
    "age": age,
    "gender": gender,
  };
}