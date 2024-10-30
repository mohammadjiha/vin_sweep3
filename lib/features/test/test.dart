// import 'dart:convert';
//
// class SearchHistoryApi {
//   final bool? success;
//   final int? code;
//   final String? message;
//   final List<Result>? result;
//
//   SearchHistoryApi({
//     this.success,
//     this.code,
//     this.message,
//     this.result,
//   });
//
//   factory SearchHistoryApi.fromRawJson(String str) => SearchHistoryApi.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory SearchHistoryApi.fromJson(Map<String, dynamic> json) => SearchHistoryApi(
//     success: json["success"],
//     code: json["code"],
//     message: json["message"],
//     result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "code": code,
//     "message": message,
//     "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
//   };
// }
//
// class Result {
//   final String? vehicleNumber;
//   final String? vehicleMake;
//   final String? vehicleModel;
//   final String? vehicleModelYear;
//   final DateTime? searchTime;
//
//   Result({
//     this.vehicleNumber,
//     this.vehicleMake,
//     this.vehicleModel,
//     this.vehicleModelYear,
//     this.searchTime,
//   });
//
//   factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     vehicleNumber: json["vehicleNumber"],
//     vehicleMake: json["vehicleMake"],
//     vehicleModel: json["vehicleModel"],
//     vehicleModelYear: json["vehicleModelYear"],
//     searchTime: json["searchTime"] == null ? null : DateTime.parse(json["searchTime"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "vehicleNumber": vehicleNumber,
//     "vehicleMake": vehicleMake,
//     "vehicleModel": vehicleModel,
//     "vehicleModelYear": vehicleModelYear,
//     "searchTime": searchTime?.toIso8601String(),
//   };
// }
