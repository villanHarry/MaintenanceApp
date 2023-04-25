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
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String msg;
  String category;
  String status;
  RequestUser user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory AdminRequestDatum.fromJson(Map<String, dynamic> json) =>
      AdminRequestDatum(
        id: json["_id"],
        msg: json["msg"],
        category: json["category"],
        status: json["status"],
        user: RequestUser.fromJson(json["user"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "msg": msg,
        "category": category,
        "status": status,
        "user": user.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class RequestUser {
  RequestUser({
    required this.id,
    required this.username,
    required this.image,
    required this.contactNumber,
    required this.floorNumber,
  });

  String id;
  String username;
  String image;
  int contactNumber;
  int floorNumber;

  factory RequestUser.fromJson(Map<String, dynamic> json) => RequestUser(
        id: json["_id"],
        username: json["username"],
        image: json["image"],
        contactNumber: json["contactNumber"],
        floorNumber: json["floorNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "image": image,
        "contactNumber": contactNumber,
        "floorNumber": floorNumber,
      };
}
