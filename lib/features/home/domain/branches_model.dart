// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

BranchModel branchModelFromJson(String str) => BranchModel.fromJson(json.decode(str));

String branchModelToJson(BranchModel data) => json.encode(data.toJson());

class BranchModel {
    BranchModel({
        required this.id,
        required this.name,
        required this.address,
        required this.county,
        required this.userId,
        required this.isDeleted,
    });

    String id;
    String name;
    String address;
    String county;
    String userId;
    bool isDeleted;

    factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        id: json["_id"],
        name: json["name"],
        address: json["address"],
        county: json["county"],
        userId: json["userId"],
        isDeleted: json["isDeleted"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "address": address,
        "county": county,
        "userId": userId,
        "isDeleted": isDeleted,
    };
}

