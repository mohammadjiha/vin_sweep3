import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../../sigin&register/screen/sigin_screen.dart';
import '../../sigin&register/widgets/buttoncheck.dart';

class DeactivateScreen extends StatefulWidget {
  static const String routName = 'DeactivateScreen';

  const DeactivateScreen({super.key});

  @override
  State<DeactivateScreen> createState() => _DeactivateScreenState();
}

class _DeactivateScreenState extends State<DeactivateScreen> {
  final ValueNotifier<Color> valueNotifierColor = ValueNotifier(const Color.fromRGBO(242, 246, 248, 1));

  OtpFieldController otpController = OtpFieldController();
  String otpValue = "";
  int secondsRemaining = 120;
  bool enableResend = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
    // sendOtp();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          enableResend = true;
        }
      });
    });
  }

  // Future<void> sendOtp() async {
  //   final url = Uri.parse('http://212.47.65.193:8888/api/v1/users/delete');
  //   try {
  //     var accessToken = CurrentSession().getApiUser()!.accessToken ?? '';
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Accept': 'application/json',
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //      if(mounted) {
  //        ScaffoldMessenger.of(context).showSnackBar(
  //            const SnackBar(content: Text("OTP has been sent!")));
  //      }  } else {
  //       handleErrorResponse(response.statusCode);
  //     }
  //   } catch (e) { if(mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text("An error occurred. Please try again.")));
  //   }}
  // }

  void handleErrorResponse(int statusCode) {
    String message;
    switch (statusCode) {
      case 400:
        message = "Bad request. Please check your input.";
        break;
      case 401:
        message = "Unauthorized. Please log in again.";
        break;
      case 403:
        message = "Forbidden. You do not have permission.";
        break;
      case 404:
        message = "User not found. Please check your information.";
        break;
      case 500:
        message = "Server error. Please try again later.";
        break;
      default:
        message = "Failed to verify OTP. Please try again.";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void resendCode() {
    if (enableResend) {
      setState(() {
        secondsRemaining = 120;
        enableResend = false;
      });
      startTimer();
      // sendOtp();
    }
  }

  void updateButtonColor() {
    valueNotifierColor.value = (otpValue.length == 6) ? ColorOnboarding.pointSelected : const Color.fromRGBO(242, 246, 248, 1);
  }

  // Future<void> verifyOtpAndDeactivateAccount(String otp) async {
  //   final url = Uri.parse('http://212.47.65.193:8888/api/v1/users/update');
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Accept': 'application/json',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({'otp': otp, 'action': 'deactivate'}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       if (data['success'] == true) {
  //         if(mounted){
  //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account successfully deactivated")));
  //         Get.offAllNamed('/login');
  //       } }else {
  //         if(mounted){
  //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid OTP")));
  //       }}
  //     } else {
  //       if(mounted){
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to verify OTP. Please try again.")));
  //     }}
  //   } catch (e) {
  //     if(mounted){
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("An error occurred. Please try again.")));
  //   } }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorOnboarding.whiteColor,
      body: Stack(
        children: [
          buildBackgroundContainer(),
          buildAppBar(),
          buildMainContainer(),
        ],
      ),
    );
  }

  Widget buildBackgroundContainer() {
    return Container(
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
              'Deactivate',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorOnboarding.whiteColor,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Please enter the OTP to deactivate your account',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: ColorOnboarding.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Image.asset('assets/images/ic-back.png'),
      ),
    );
  }

  Widget buildMainContainer() {
    return Positioned(
      top: 28.h,
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
              Expanded(
                child: Column(
                  children: [
                    OTPTextField(
                      controller: otpController,
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 40,
                      style: const TextStyle(fontSize: 17),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      onChanged: (pin) {
                        otpValue = pin;
                        updateButtonColor();
                      },
                      onCompleted: (pin) {
                        otpValue = pin;
                        updateButtonColor();
                        // verifyOtpAndDeactivateAccount(otpValue); // Automatically verify when OTP is completed
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        if (enableResend) {
                          resendCode();
                        }
                      },
                      child: Text(
                        "Resend Code",
                        style: TextStyle(
                          color: enableResend ? Colors.blue : Colors.grey,
                          decoration: enableResend ? TextDecoration.underline : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "(${secondsRemaining ~/ 60}:${(secondsRemaining % 60).toString().padLeft(2, '0')})",
                      style: const TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 37.h),
                    ValueListenableBuilder(
                      valueListenable: valueNotifierColor,
                      builder: (BuildContext context, value, Widget? child) {
                        return ButtonCheck(
                          text: 'Submit',
                          color: value,
                          textColor: value == ColorOnboarding.pointSelected
                              ? ColorOnboarding.whiteColor
                              : ColorOnboarding.subTextColor,
                          onPressed: () {
                            if (otpValue.length == 6) {
                              _showCustomDialog(context); // Show the dialog when OTP is valid
                            } else {
                              Get.snackbar(
                                  backgroundColor: Colors.redAccent,
                                  colorText: ColorOnboarding.whiteColor,
                                  'error', '"Please enter a valid 6-digit OTP"');
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void _showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: GestureDetector(
          onTap: (){  Navigator.of(context).pushReplacementNamed(SignInScreen.routName);},
          child: SizedBox(
            height: 38.h,
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){  Navigator.of(context).pushReplacementNamed(SignInScreen.routName);
                  },
                  child: const Align(alignment: Alignment.bottomRight,
                    child: Icon(Icons.close),
                  ),
                ),
                Lottie.asset(
                    'assets/animations/Animation - 1724759483512 (1).json'),
                Text(
                  'Success Message',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color.fromRGBO(61, 193, 121, 1),
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Success description text here',
                  style: TextStyle(
                      color: ColorOnboarding.subTextColor,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}