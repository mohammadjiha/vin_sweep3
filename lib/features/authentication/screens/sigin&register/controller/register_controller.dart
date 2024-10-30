import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vin_sweep/features/home_screen/screen/home.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

  Future<void> register(String name, String email, String password, String zipCode) async {
    isLoading(true);
    try {
      var url = Uri.parse('https://food-api-omega.vercel.app/api/v1/user/signup');
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      var body = json.encode({
        'name': name,
        'email': email,
        'password': password,
        'zipCode': zipCode,
        'optToken': ''
      });

      var response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['success']) {
          Get.snackbar(
            'Success',
            'Registration successful',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed(HomePage.routeName);
        } else {
          _showError(jsonResponse['message']);
        }
      } else {
        _showError("Error: ${response.statusCode}");
      }
    } catch (e) {
      _showError("An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }
}
