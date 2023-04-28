// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.email,
        required this.fullname,
        required this.companyName,
        required this.username,
        required this.image,
        required this.resume,
        required this.password,
        required this.role,
        required this.jobType,
        required this.phone,
        required this.psniNumber,
        required this.gender,
        required this.professionalHeadline,
        required this.profileSummary,
        required this.vettingFile,
        required this.dispensingSoftware,
        required this.companyWebsite,
        required this.address,
        required this.city,
        required this.county,
        required this.regNumber,
        required this.eirCode,
        required this.info,
        required this.url,
        required this.occupation,
        required this.status,
        required this.isDeleted,
        required this.canRelocate,
        required this.createdAt,
        required this.updatedAt,
    });

    String email;
    String fullname;
    String companyName;
    String username;
    String image;
    String resume;
    String password;
    String role;
    String jobType;
    String phone;
    String psniNumber;
    String gender;
    String professionalHeadline;
    String profileSummary;
    String vettingFile;
    String dispensingSoftware;
    String companyWebsite;
    String address;
    String city;
    String county;
    String regNumber;
    String eirCode;
    String info;
    String url;
    String occupation;
    String status;
    bool isDeleted;
    bool canRelocate;
    DateTime createdAt;
    DateTime updatedAt;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        fullname: json["fullname"],
        companyName: json["company_name"],
        username: json["username"],
        image: json["image"],
        resume: json["resume"],
        password: json["password"],
        role: json["role"],
        jobType: json["jobType"],
        phone: json["phone"],
        psniNumber: json["psniNumber"],
        gender: json["gender"],
        professionalHeadline: json["professionalHeadline"],
        profileSummary: json["profileSummary"],
        vettingFile: json["vettingFile"],
        dispensingSoftware: json["dispensing_software"],
        companyWebsite: json["company_website"],
        address: json["address"],
        city: json["city"],
        county: json["county"],
        regNumber: json["regNumber"],
        eirCode: json["eir_code"],
        info: json["info"],
        url: json["url"],
        occupation: json["occupation"],
        status: json["status"],
        isDeleted: json["isDeleted"],
        canRelocate: json["canRelocate"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "fullname": fullname,
        "company_name": companyName,
        "username": username,
        "image": image,
        "resume": resume,
        "password": password,
        "role": role,
        "jobType": jobType,
        "phone": phone,
        "psniNumber": psniNumber,
        "gender": gender,
        "professionalHeadline": professionalHeadline,
        "profileSummary": profileSummary,
        "vettingFile": vettingFile,
        "dispensing_software": dispensingSoftware,
        "company_website": companyWebsite,
        "address": address,
        "city": city,
        "county": county,
        "regNumber": regNumber,
        "eir_code": eirCode,
        "info": info,
        "url": url,
        "occupation": occupation,
        "status": status,
        "isDeleted": isDeleted,
        "canRelocate": canRelocate,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

