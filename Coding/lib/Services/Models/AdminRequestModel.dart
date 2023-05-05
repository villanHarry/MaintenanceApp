// To parse this JSON data, do
//
//     final adminRequestModel = adminRequestModelFromJson(jsonString);

import 'dart:convert';

AdminRequestModel adminRequestModelFromJson(String str) =>
    AdminRequestModel.fromJson(json.decode(str));

String adminRequestModelToJson(AdminRequestModel data) =>
    json.encode(data.toJson());

class AdminRequestModel {
  AdminRequestModel({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  int status;
  List<AdminRequestDatum> data;

  factory AdminRequestModel.fromJson(Map<String, dynamic> json) =>
      AdminRequestModel(
        message: json["message"],
        status: json["status"],
        data: json["data"].toList().isEmpty || json["data"] == null
            ? []
            : List<AdminRequestDatum>.from(
                json["data"].map((x) => AdminRequestDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AdminRequestDatum {
  AdminRequestDatum({
    required this.id,
    required this.msg,
    required this.category,
    required this.preferredDate,
    required this.preferredSlot,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.image,
  });

  String id;
  String msg;
  String category;
  DateTime preferredDate;
  String preferredSlot;
  String status;
  RequestUser user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? image;

  factory AdminRequestDatum.fromJson(Map<String, dynamic> json) =>
      AdminRequestDatum(
        id: json["_id"],
        msg: json["msg"],
        category: json["category"],
        preferredDate: DateTime.parse(json["preferredDate"]),
        preferredSlot: json["preferredSlot"],
        status: json["status"],
        user: RequestUser.fromJson(json["user"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "msg": msg,
        "category": category,
        "preferredDate": preferredDate.toIso8601String(),
        "preferredSlot": preferredSlot,
        "status": status,
        "user": user.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "image": image,
      };
}

class RequestUser {
  RequestUser({
    required this.id,
    required this.username,
    required this.image,
    required this.address,
    required this.contactNumber,
    required this.floorNumber,
    required this.unitNumber,
  });

  String id;
  String username;
  String image;
  String address;
  int contactNumber;
  int floorNumber;
  int unitNumber;

  factory RequestUser.fromJson(Map<String, dynamic> json) => RequestUser(
        id: json["_id"],
        username: json["username"],
        image: json["image"],
        address: json["address"],
        contactNumber: json["contactNumber"],
        floorNumber: json["floorNumber"],
        unitNumber: json["unitNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "image": image,
        "address": address,
        "contactNumber": contactNumber,
        "floorNumber": floorNumber,
        "unitNumber": unitNumber,
      };
}
