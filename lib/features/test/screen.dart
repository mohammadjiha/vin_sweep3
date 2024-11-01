import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vin_sweep/http_wrapper/current_session.dart';

class SearchHistoryApi {
  final bool? success;
  final int? code;
  final String? message;
  final List<Result>? result;

  SearchHistoryApi({
    this.success,
    this.code,
    this.message,
    this.result,
  });

  factory SearchHistoryApi.fromRawJson(String str) =>
      SearchHistoryApi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchHistoryApi.fromJson(Map<String, dynamic> json) =>
      SearchHistoryApi(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  final String? vehicleNumber;
  final String? vehicleMake;
  final String? vehicleModel;
  final String? vehicleModelYear;
  final DateTime? searchTime;

  Result({
    this.vehicleNumber,
    this.vehicleMake,
    this.vehicleModel,
    this.vehicleModelYear,
    this.searchTime,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    vehicleNumber: json["vehicleNumber"],
    vehicleMake: json["vehicleMake"],
    vehicleModel: json["vehicleModel"],
    vehicleModelYear: json["vehicleModelYear"],
    searchTime: json["searchTime"] == null
        ? null
        : DateTime.parse(json["searchTime"]),
  );

  Map<String, dynamic> toJson() => {
    "vehicleNumber": vehicleNumber,
    "vehicleMake": vehicleMake,
    "vehicleModel": vehicleModel,
    "vehicleModelYear": vehicleModelYear,
    "searchTime": searchTime?.toIso8601String(),
  };
}

class SearchHistoryPage extends StatefulWidget {
  static const String routName ='SearchHistoryPage';

  const SearchHistoryPage({super.key});
  @override
  SearchHistoryPageState createState() => SearchHistoryPageState();
}

class SearchHistoryPageState extends State<SearchHistoryPage> {
  Future<SearchHistoryApi> fetchSearchHistory() async {
    final response = await http.get(
        Uri.parse(
            "http://212.47.65.193:8888/api/v1/users/get-user-search-history"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CurrentSession().getAccessToken()}'
        }
    );

    if (response.statusCode == 200) {
      return SearchHistoryApi.fromRawJson(response.body);
    } else {
      throw Exception('Failed to load search history');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search History'),
      ),
      body: FutureBuilder<SearchHistoryApi>(
        future: fetchSearchHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final searchHistory = snapshot.data;
            if (searchHistory?.result == null ||
                searchHistory!.result!.isEmpty) {
              return const Center(child: Text(
                  'You have no search history. Start searching now!'));
            }

            return ListView.builder(
              itemCount: searchHistory.result!.length,
              itemBuilder: (context, index) {
                final item = searchHistory.result![index];
                return ListTile(
                  title: Text(item.vehicleNumber ?? 'N/A'),
                  subtitle: Text(
                    '${item.vehicleMake ?? 'N/A'} ${item.vehicleModel ??
                        'N/A'} (${item.vehicleModelYear ?? 'N/A'})\n'
                        'Searched on: ${item.searchTime?.toLocal().toString() ??
                        'N/A'}',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}