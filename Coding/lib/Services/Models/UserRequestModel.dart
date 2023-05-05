// To parse this JSON data, do
//
//     final userRequestModel = userRequestModelFromJson(jsonString);

import 'dart:convert';

UserRequestModel userRequestModelFromJson(String str) =>
    UserRequestModel.fromJson(json.decode(str));

String userRequestModelToJson(UserRequestModel data) =>
    json.encode(data.toJson());

class UserRequestModel {
  UserRequestModel({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  int status;
  List<UserRequestDatum> data;

  factory UserRequestModel.fromJson(Map<String, dynamic> json) =>
      UserRequestModel(
        message: json["message"],
        status: json["status"],
        data: json["data"].toList().isEmpty || json["data"] == null
            ? []
            : List<UserRequestDatum>.from(
                json["data"].map((x) => UserRequestDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UserRequestDatum {
  UserRequestDatum({
    required this.id,
    required this.msg,
    required this.category,
    required this.image,
    required this.preferredDate,
    required this.preferredSlot,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String msg;
  String category;
  String image;
  DateTime preferredDate;
  String preferredSlot;
  String status;
  String user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory UserRequestDatum.fromJson(Map<String, dynamic> json) =>
      UserRequestDatum(
        id: json["_id"],
        msg: json["msg"],
        category: json["category"],
        image: json["image"] ?? "",
        preferredDate: DateTime.parse(json["preferredDate"]),
        preferredSlot: json["preferredSlot"],
        status: json["status"],
        user: json["user"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "msg": msg,
        "category": category,
        "image": image,
        "preferredDate": preferredDate.toIso8601String(),
        "preferredSlot": preferredSlot,
        "status": status,
        "user": user,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
