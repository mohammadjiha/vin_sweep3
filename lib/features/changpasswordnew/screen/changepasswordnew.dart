import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../../../http_wrapper/current_session.dart';
import '../../authentication/screens/sigin&register/widgets/buttoncheck.dart';
import '../../authentication/screens/sigin&register/widgets/itemtextfeild.dart';

class ChanngePasswordNew extends StatefulWidget {
  static const String routName = 'ChanngePasswordNew';

  const ChanngePasswordNew({super.key});

  @override
  State<ChanngePasswordNew> createState() => _ChanngePasswordNewState();
}

class _ChanngePasswordNewState extends State<ChanngePasswordNew> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController reTypePasswordConController = TextEditingController();
  final FocusNode currentPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode reTypePasswordFocusNode = FocusNode();
  final ValueNotifier<Color> valueNotifierColor = ValueNotifier(const Color.fromRGBO(242, 246, 248, 1));

  @override
  void initState() {
    super.initState();
    currentPasswordController.addListener(_updateButtonColor);
    newPasswordController.addListener(_updateButtonColor);
    reTypePasswordConController.addListener(_updateButtonColor);
  }

  void _updateButtonColor() {
    valueNotifierColor.value = (currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        reTypePasswordConController.text.isNotEmpty)
        ? ColorOnboarding.pointSelected
        : const Color.fromRGBO(242, 246, 248, 1);
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    reTypePasswordConController.dispose();
    currentPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    reTypePasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorOnboarding.whiteColor,
      body: Stack(
        children: [
          Container(
            width: 100.w,
            height: 40.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0a2342),
                  Color(0xFF253b5b),
                  Color.fromRGBO(32, 57, 88, 1),
                  Color(0xFF57708f),
                  Color(0xFF728caa),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  Text(
                    'Profile',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorOnboarding.whiteColor)),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'You can only edit your name and ZIP code',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                            color: ColorOnboarding.whiteColor)),
                  ),
                ],
              ),
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset('assets/images/ic-back.png')),
          ),
          Positioned(
            top: 25.h,
            left: 0,
            right: 0,
            child: Container(
              height: 100.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: ColorOnboarding.whiteColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  children: [
                    SizedBox(height: 4.h),
                    ItemTextFeild(
                      nameImage: 'ic-pass2.png',
                      textTextFeild: 'Current Password',
                      isobscureText: true,
                      focusNode: currentPasswordFocusNode,
                      textEditingController: currentPasswordController,
                    ),
                    SizedBox(height: 3.h),
                    ItemTextFeild(
                      nameImage: 'ic-pass2.png',
                      textTextFeild: 'New Password',
                      isobscureText: true,
                      focusNode: newPasswordFocusNode,
                      textEditingController: newPasswordController,
                    ),
                    SizedBox(height: 3.h),
                    ItemTextFeild(
                      nameImage: 'ic-pass2.png',
                      textTextFeild: 'Re-Type New Password',
                      isobscureText: true,
                      focusNode: reTypePasswordFocusNode,
                      textEditingController: reTypePasswordConController,
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        _validateAndSubmit(); // Call validation
                      },
                      child: ValueListenableBuilder(
                        valueListenable: valueNotifierColor,
                        builder: (BuildContext context, value, Widget? child) {
                          return ButtonCheck(
                            text: 'Save',
                            color: value,
                            textColor: value == ColorOnboarding.pointSelected
                                ? ColorOnboarding.whiteColor
                                : ColorOnboarding.subTextColor,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changePasswordApi() async {
    var accessToken = CurrentSession().getAccessToken() ?? '';
    try {
      var responseChangePassword = await http.post(
        Uri.parse('http://212.47.65.193:8888/api/v1/auth/change-password'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "oldPassword": currentPasswordController.text,
          "newPassword": newPasswordController.text,
        }),
      );

      if (responseChangePassword.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Password updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        _showError('Failed to update password. Please try again.');
      }
    } catch (e) {
      _showError('An error occurred. Please try again.');
    }
  }

  bool _isValidPassword(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'\d').hasMatch(password);
  }

  void _validateAndSubmit() {
    final newPassword = newPasswordController.text;
    final reTypePassword = reTypePasswordConController.text;

    if (!_isValidPassword(newPassword)) {
      _showError('Password must be at least 8 characters long, contain uppercase, lowercase, and a number.');
    } else if (newPassword != reTypePassword) {
      _showError('Passwords do not match.');
    } else {
      changePasswordApi();
    }
  }

  void _showError(String message) {
    Get.snackbar('Error', message,
        backgroundColor: Colors.redAccent, colorText: Colors.white);
  }
}
