// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.message,
    required this.status,
    required this.loginData,
  });

  String message;
  int status;
  LoginData loginData;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        status: json["status"],
        loginData: LoginData.fromJson(json["data"] == null ? {} : json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": loginData.toJson(),
      };
}

class LoginData {
  LoginData({
    required this.accessToken,
    required this.loginUser,
  });

  String accessToken;
  LoginUser loginUser;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        accessToken: json["access_token"],
        loginUser: LoginUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "user": loginUser.toJson(),
      };
}

class LoginUser {
  LoginUser({
    required this.id,
    required this.username,
    required this.email,
    required this.usertype,
    required this.password,
    required this.image,
    this.otp,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String username;
  String email;
  String usertype;
  String password;
  String image;
  dynamic otp;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        usertype: json["usertype"],
        password: json["password"],
        image: json["image"],
        otp: json["otp"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "usertype": usertype,
        "password": password,
        "image": image,
        "otp": otp,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
