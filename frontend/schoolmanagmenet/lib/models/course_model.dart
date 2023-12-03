import 'dart:convert';

List<courseModel> userFromJson(String str) =>
    List<courseModel>.from(json.decode(str).map((x) => courseModel.fromJson(x)));
String userToJson(List<courseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class courseModel {
  courseModel({
    this.id = "",
    this.courseName = "",
    this.instructor = "",
    this.startDate = "",
    this.endDate = "",
  });

  String id;
  String courseName;
  String instructor;
  String startDate;
  String endDate;

  factory courseModel.fromJson(Map<String, dynamic> json) => courseModel(
    id: json["_id"],
    courseName: json["courseName"],
    instructor: json["instructor"],
    startDate: json["startDate"],
    endDate: json["endDate"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "courseName": courseName,
    "instructor": instructor,
    "startDate": startDate,
    "endDate": endDate,
  };
}
