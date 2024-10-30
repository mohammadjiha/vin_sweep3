import 'dart:convert';

class LoginResponse {
  final bool? success;
  final int? code;
  final String? message;
  final ApiUser? user;

  LoginResponse({
    this.success,
    this.code,
    this.message,
    this.user,
  });

  factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    user: json["result"] == null ? null : ApiUser.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
    "result": user?.toJson(),
  };
}

class ApiUser {
  final String? accessToken;
  final String? tokenType;
  final User? user;
  final String? token;

  ApiUser({
    this.token,
    this.accessToken,
    this.tokenType,
    this.user,
  });

  factory ApiUser.fromRawJson(String str) => ApiUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiUser.fromJson(Map<String, dynamic> json) => ApiUser(
    accessToken: json["accessToken"],
    tokenType: json["tokenType"],
    token: json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "tokenType": tokenType,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  final int? id;
  late final String? fullName;
  final String? email;
  late final int? zipCode;

  User({
    this.id,
    this.fullName,
    this.email,
    this.zipCode,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    zipCode: json["zipCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "zipCode": zipCode,
  };
}
