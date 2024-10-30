import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:vin_sweep/constvalue/onboarding_screen/onboarding_color.dart';
import 'package:vin_sweep/features/authentication/screens/otp_screen/screen/otp_screen.dart';
import 'buttoncheck.dart';
import 'itemtextfeild.dart';

class RegisterTab extends StatelessWidget {
  RegisterTab({super.key}) {
    // Add listeners to update button color based on field inputs
    fullNameController.addListener(_updateButtonColor);
    emailController.addListener(_updateButtonColor);
    passwordController.addListener(_updateButtonColor);
    zipCodeController.addListener(_updateButtonColor);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode zipCodeFocusNode = FocusNode();

  final ValueNotifier<Color> valueNotifierColor =
  ValueNotifier(const Color.fromRGBO(242, 246, 248, 1));

  void _updateButtonColor() {
    valueNotifierColor.value = (fullNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        zipCodeController.text.isNotEmpty)
        ? ColorOnboarding.pointSelected
        : const Color.fromRGBO(242, 246, 248, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 2.h),
            ItemTextFeild(
              nameImage: 'ic-name.png',
              textTextFeild: 'Name',
              isobscureText: false,
              focusNode: fullNameFocusNode,
              textEditingController: fullNameController,
            ),
            SizedBox(height: 2.h),
            ItemTextFeild(
              nameImage: 'ic-mail.png',
              textTextFeild: 'Email',
              isobscureText: false,
              focusNode: emailFocusNode,
              textEditingController: emailController,
            ),
            SizedBox(height: 2.h),
            ItemTextFeild(
              nameImage: 'ic-pass2.png',
              textTextFeild: 'Password',
              isobscureText: true,
              focusNode: passwordFocusNode,
              textEditingController: passwordController,
            ),
            SizedBox(height: 2.h),
            ItemTextFeild(
              nameImage: 'ic-zip.png',
              textTextFeild: 'Zip Code',
              isobscureText: false,
              focusNode: zipCodeFocusNode,
              textEditingController: zipCodeController,
            ),
            SizedBox(height: 5.h),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _registerWithApi();
                }
              },
              child: ValueListenableBuilder<Color>(
                valueListenable: valueNotifierColor,
                builder: (BuildContext context, value, Widget? child) {
                  return ButtonCheck(
                    text: 'Register',
                    color: value,
                    textColor: value == ColorOnboarding.pointSelected
                        ? ColorOnboarding.whiteColor
                        : ColorOnboarding.subTextColor,
                    // Disable button if not filled
                  );
                },
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              '© 2024 VINsweep. All Rights Reserved.',
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                      color: ColorOnboarding.subTextColor)),
            ),
          ],
        ),
      ),
    );
  }

  void _registerWithApi() {
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String zipCode = zipCodeController.text.trim();

    // Validate that all fields are filled
    if (fullName.isEmpty || email.isEmpty || password.isEmpty || zipCode.isEmpty) {
      showError('Please fill in all fields.');
      return;
    }

    if (!isValidName(fullName)) {
      showError('The name should not contain an email or special characters.');
      return;
    }

    if (!GetUtils.isEmail(email)) {
      showError('Please enter a valid email address.');
      return;
    }

    if (!isValidPassword(password)) {
      showError('Password must be at least 8 characters long and include letters, numbers, and special characters.');
      return;
    }

    if (!isValidZipCode(zipCode)) {
      showError('Zip Code must be exactly 5 digits.');
      return;
    }

    Get.toNamed(OtpScreen.routName);
  }

  bool isValidZipCode(String zipCode) {
    return RegExp(r'^\d{5}$').hasMatch(zipCode);
  }

  bool isValidName(String name) {
    return !RegExp(r'[@]').hasMatch(name) && RegExp(r'^[a-zA-Z\s]+$').hasMatch(name);
  }

  bool isValidPassword(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Za-z]').hasMatch(password) &&
        RegExp(r'\d').hasMatch(password) &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  void handleNetworkError(dynamic e) {
    String errorMessage;

    if (e is SocketException) {
      errorMessage = "Network error. Please check your internet connection.";
    } else if (e is http.ClientException) {
      errorMessage = "Client error. Please try again later.";
    } else {
      errorMessage = "An unexpected error occurred: ${e.toString()}";
    }
    showError(errorMessage);
  }

  void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }
}
