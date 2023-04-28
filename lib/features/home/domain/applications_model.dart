// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MyApplications welcomeFromJson(String str) =>
    MyApplications.fromJson(json.decode(str));

String welcomeToJson(MyApplications data) => json.encode(data.toJson());

class MyApplications {
  String userId;
  String jobId;
  String userNote;
  String adminNote;
  String status;
  DateTime applicationDate;
  bool isDeleted;

  MyApplications({
    required this.userId,
    required this.jobId,
    required this.userNote,
    required this.adminNote,
    required this.status,
    required this.applicationDate,
    required this.isDeleted,
  });

  factory MyApplications.fromJson(Map<String, dynamic> json) => MyApplications(
        userId: json["userId"],
        jobId: json["jobId"],
        userNote: json["user_note"],
        adminNote: json["admin_note"],
        status: json["status"],
        applicationDate: DateTime.parse(json["application_date"]),
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "jobId": jobId,
        "user_note": userNote,
        "admin_note": adminNote,
        "status": status,
        "application_date": applicationDate.toIso8601String(),
        "isDeleted": isDeleted,
      };
}
