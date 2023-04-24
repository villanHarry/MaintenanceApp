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
        loginData: json["data"] == null
            ? LoginData(
                accessToken: "",
                loginUser: LoginUser(
                    id: "",
                    username: "",
                    email: "",
                    isverified: false,
                    usertype: "",
                    password: "",
                    image: "",
                    otp: 0,
                    contactNumber: 0,
                    floorNumber: 0,
                    v: 0,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now()))
            : LoginData.fromJson(json["data"]),
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
        accessToken: json["access_token"] == null ? "" : json["access_token"],
        loginUser: json["user"] == null
            ? LoginUser(
                id: "",
                username: "",
                email: "",
                isverified: false,
                usertype: "",
                password: "",
                image: "",
                otp: 0,
                contactNumber: 0,
                floorNumber: 0,
                v: 0,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now())
            : LoginUser.fromJson(json["user"]),
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
    required this.isverified,
    required this.usertype,
    required this.password,
    required this.image,
    required this.otp,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.contactNumber,
    required this.floorNumber,
  });

  String id;
  String username;
  String email;
  bool isverified;
  String usertype;
  String password;
  String image;
  int otp;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int contactNumber;
  int floorNumber;

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        isverified: json["isverified"],
        usertype: json["usertype"],
        password: json["password"],
        image: json["image"],
        otp: json["otp"] == null ? 0 : json["otp"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        contactNumber: json["contactNumber"],
        floorNumber: json["floorNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "isverified": isverified,
        "usertype": usertype,
        "password": password,
        "image": image,
        "otp": otp,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "contactNumber": contactNumber,
        "floorNumber": floorNumber,
      };
}
