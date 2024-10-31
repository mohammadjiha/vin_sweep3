import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vin_sweep/features/loading/screen/loading_screen.dart';
import 'dart:convert';
import 'package:vin_sweep/http_wrapper/current_session.dart';
import '../models/login_response.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isRememberMe = false.obs;
  String? email;
  String? password;

  Future<void> loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    password = prefs.getString('password');
  }

  Future<void> saveUserCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<void> clearUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _showError("Please fill in both email and password fields.");
      return;
    }

    isLoading(true);

    try {
      var response = await http.post(
        Uri.parse('http://212.47.65.193:8888/api/v1/auth/login'),
        body: jsonEncode({"email": email, "password": password}),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromRawJson(response.body);

        if (loginResponse.success == true && loginResponse.user != null) {
          CurrentSession().setApiUser(loginResponse.user!);
          CurrentSession().setAccessToken(loginResponse.user!.accessToken!);

          if (isRememberMe.value) {
            await saveUserCredentials(email, password);
          }

          Get.offNamed(
            LoadingScreenAnimation.routName,
            arguments: {
              'email': loginResponse.user!.user!.email,
              'name': loginResponse.user!.user!.fullName ?? '',
              'zipCode': loginResponse.user!.user!.zipCode,
            },
          );
        } else {
          _showError(loginResponse.message ?? "Login failed.");
        }
      } else {
        _handleError(response.statusCode);
      }
    } catch (e) {
      _handleNetworkError(e);
    } finally {
      isLoading(false);
    }
  }

  void _handleError(int statusCode) {
    switch (statusCode) {
      case 401:
        _showError("Incorrect email or password.");
        break;
      case 403:
        _showError("Your account has been disabled. Please contact support.");
        break;
      case 404:
        _showError("User not found. Please check your credentials.");
        break;
      case 423:
        _showError("Too many failed attempts. Try again later.");
        break;
      case 500:
        _showError("Server error. Please try again later.");
        break;
      default:
        _showError("Login failed. Please try again.");
    }
  }

  void _handleNetworkError(dynamic error) {
    if (error.toString().contains('SocketException')) {
      _showError("Network error. Please check your internet connection.");
    } else {
      _showError("An unexpected error occurred: $error");
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
