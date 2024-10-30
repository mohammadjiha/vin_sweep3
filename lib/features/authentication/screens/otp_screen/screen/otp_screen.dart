import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../../sigin&register/widgets/buttoncheck.dart';

class OtpScreen extends StatefulWidget {
  static const String routName = 'OtpScreen';

  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final ValueNotifier<Color> valueNotifierColor =
  ValueNotifier(const Color.fromRGBO(242, 246, 248, 1));

  OtpFieldController otpController = OtpFieldController();
  String otpValue = "";
  int secondsRemaining = 120;
  bool enableResend = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
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

  void resendCode() {
    if (enableResend) {
      setState(() {
        secondsRemaining = 120;
        enableResend = false;
      });
      startTimer();
      // Call API to resend OTP code
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP Code has been resent!")),
      );
    }
  }

  void updateButtonColor() {
    if (otpValue.length == 6) {
      valueNotifierColor.value = ColorOnboarding.pointSelected;
    } else {
      valueNotifierColor.value = const Color.fromRGBO(242, 246, 248, 1);
    }
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
                    'Enter OTP',
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
                    'Enter the OTP code sent to the registered email address.',
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
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset('assets/images/ic-close.png'),
            ),
          ),
          Positioned(
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
                            },
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: enableResend ? resendCode : null,
                            child: Text(
                              "Resend Code",
                              style: TextStyle(
                                color: enableResend ? Colors.blue : Colors.grey,
                                decoration: enableResend
                                    ? TextDecoration.underline
                                    : null,
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
                              );
                            },
                          ),
                          SizedBox(height: 3.h,),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
