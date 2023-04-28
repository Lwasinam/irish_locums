// To parse this JSON data, do
//
//     final applicationModel = applicationModelFromJson(jsonString);

import 'dart:convert';

ApplicationModel applicationModelFromJson(String str) =>
    ApplicationModel.fromJson(json.decode(str));

String applicationModelToJson(ApplicationModel data) =>
    json.encode(data.toJson());

class ApplicationModel {
  ApplicationModel({
    required this.userId,
    required this.jobId,
    required this.userNote,
    required this.adminNote,
    required this.status,
    required this.applicationDate,
    required this.isDeleted,
  });

  String userId;
  String jobId;
  String userNote;
  String adminNote;
  String status;
  DateTime applicationDate;
  bool isDeleted;

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      ApplicationModel(
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
