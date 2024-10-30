import 'dart:convert';

class RegisterResponseOtp {
  final bool? success;
  final int? code;
  final String? message;
  final String? result;

  RegisterResponseOtp({
    this.success,
    this.code,
    this.message,
    this.result,
  });

  factory RegisterResponseOtp.fromRawJson(String str) => RegisterResponseOtp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponseOtp.fromJson(Map<String, dynamic> json) => RegisterResponseOtp(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
    "result": result,
  };
}
