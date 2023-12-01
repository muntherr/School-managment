import 'dart:convert';


List<studentModel> userFromJson(String str) =>
    List<studentModel>.from(json.decode(str).map((x) => studentModel.fromJson(x)));
String userToJson(List<studentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class studentModel {
  studentModel(
      {this.id = "",
        this.firstName = "",
        this.lastName = "",
        this.email = "",
        this.phoneNumber = 0,
        this.gender ='',
        this.age= 0
      });
  String id;
  String firstName;
  String lastName;
  String email;
  String gender;
  int phoneNumber;
  int age;

  factory studentModel.fromJson(Map<String, dynamic> json) => studentModel(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      gender: json["gender"],
      age: json["age"]

  );
  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "gender": gender,
    "phoneNumber": gender,
    "age": age
  };
}
