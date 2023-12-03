import 'dart:convert';

List<registrationModel> userFromJson(String str) =>
    List<registrationModel>.from(json.decode(str).map((x) => registrationModel.fromJson(x)));
String userToJson(List<registrationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class registrationModel {
  String id;
  String studentId;
  String courseId;
  String instructorId;
  String paymentStatus;

  registrationModel({
    this.id = "",
    this.studentId = "",
    this.courseId = "",
    this.instructorId = "",
    this.paymentStatus = "",
  });

  factory registrationModel.fromJson(Map<String, dynamic> json) =>
      registrationModel(
        id: json["_id"],
        studentId: json["studentId"],
        courseId: json["courseId"],
        instructorId: json["instructorId"],
        paymentStatus: json["paymentStatus"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "studentId": studentId,
    "courseId": courseId,
    "instructorId": instructorId,
    "paymentStatus": paymentStatus,
  };
}
