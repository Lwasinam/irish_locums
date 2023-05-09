// To parse this JSON data, do
//
//     final jobModel = jobModelFromJson(jsonString);

import 'dart:convert';

JobModel jobModelFromJson(String str) => JobModel.fromJson(json.decode(str));

String jobModelToJson(JobModel data) => json.encode(data.toJson());

class JobModel {
  JobModel({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.payFrequency,
    required this.workHour,
    required this.workPattern,
    required this.startDate,
    required this.category,
    required this.endDate,
    required this.vacancies,
    required this.salary,
    required this.jobType,
    required this.branchId,
    required this.publishedDate,
    required this.expiredDate,
    required this.benefit,
    required this.requirements,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
  });
  String? id;
  String? userId;
  String title;
  String description;
  String payFrequency;
  String workHour;
  String workPattern;
  DateTime startDate;
  String category;
  DateTime endDate;
  int vacancies;
  int salary;
  String jobType;
  String branchId;
  DateTime publishedDate;
  DateTime expiredDate;
  List<String> benefit;
  List<String> requirements;
  bool isActive;
  bool isDeleted;
  DateTime createdAt;

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        id: json["_id"],
        userId: '',
        title: json["title"],
        description: json["description"],
        payFrequency: json["payFrequency"],
        workHour: json["workHour"],
        workPattern: json["workPattern"],
        startDate: DateTime.parse(json["startDate"]),
        category: json["category"],
        endDate: DateTime.parse(json["endDate"]),
        vacancies: json["vacancies"],
        salary: json["salary"],
        jobType: json["jobType"],
        branchId: json["branchId"],
        publishedDate: DateTime.parse(json["publishedDate"]),
        expiredDate: DateTime.parse(json["expiredDate"]),
        benefit: List<String>.from(json["benefit"].map((x) => x)),
        requirements: List<String>.from(json["requirements"].map((x) => x)),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "title": title,
        "description": description,
        "payFrequency": payFrequency,
        "workHour": workHour,
        "workPattern": workPattern,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "category": category,
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "vacancies": vacancies,
        "salary": salary,
        "jobType": jobType,
        "branchId": branchId,
        "publishedDate": publishedDate.toIso8601String(),
        "expiredDate":
            "${expiredDate.year.toString().padLeft(4, '0')}-${expiredDate.month.toString().padLeft(2, '0')}-${expiredDate.day.toString().padLeft(2, '0')}",
        "benefit": List<dynamic>.from(benefit.map((x) => x)),
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
      };
}
