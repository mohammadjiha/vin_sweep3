import 'dart:convert';

// Class to represent individual vehicle information
class VehicleInfo {
  final String vehicleNumber;
  final String vehicleMake;
  final String vehicleModel;
  final String vehicleModelYear;
  final DateTime searchTime;

  VehicleInfo({
    required this.vehicleNumber,
    required this.vehicleMake,
    required this.vehicleModel,
    required this.vehicleModelYear,
    required this.searchTime,
  });

  // Factory constructor to create a VehicleInfo object from JSON
  factory VehicleInfo.fromJson(Map<String, dynamic> json) {
    return VehicleInfo(
      vehicleNumber: json['vehicleNumber'],
      vehicleMake: json['vehicleMake'],
      vehicleModel: json['vehicleModel'],
      vehicleModelYear: json['vehicleModelYear'],
      searchTime: DateTime.parse(json['searchTime']),
    );
  }

  // Method to convert a VehicleInfo object to JSON
  Map<String, dynamic> toJson() => {
    "vehicleNumber": vehicleNumber,
    "vehicleMake": vehicleMake,
    "vehicleModel": vehicleModel,
    "vehicleModelYear": vehicleModelYear,
    "searchTime": searchTime.toIso8601String(),
  };
}

// Class to handle the API response that includes vehicle information
class SearchHistoryApi {
  final bool? success;
  final int? code;
  final String? message;
  final List<VehicleInfo>? result; // List of VehicleInfo

  SearchHistoryApi({
    this.success,
    this.code,
    this.message,
    this.result,
  });

  factory SearchHistoryApi.fromRawJson(String str) => SearchHistoryApi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchHistoryApi.fromJson(Map<String, dynamic> json) => SearchHistoryApi(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    result: json["result"] == null
        ? []
        : List<VehicleInfo>.from(json["result"].map((x) => VehicleInfo.fromJson(x))), // Convert to List<VehicleInfo>
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())), // Convert VehicleInfo to JSON
  };
}
