import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../../sigin&register/widgets/buttoncheck.dart';
import '../../sigin&register/widgets/itemtextfeild.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routName = 'ChangePasswordScreen';

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode newPasswordFocusNode = FocusNode();

  final FocusNode confirmPasswordFocusNode = FocusNode();

  final ValueNotifier<Color> valueNotifierColor =
      ValueNotifier(const Color.fromRGBO(242, 246, 248, 1));

  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    newPasswordController.addListener(_updateButtonState);
    confirmPasswordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    isButtonEnabled = newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        newPasswordController.text == confirmPasswordController.text;

    valueNotifierColor.value = isButtonEnabled
        ? ColorOnboarding.pointSelected
        : const Color.fromRGBO(242, 246, 248, 1);
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(
                    height: 13.h,
                  ),
                  Text(
                    'Forgot Password',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorOnboarding.whiteColor)),
                  ),
                  Text(
                    'Please fill in your information below to reset your password',
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
              child: Image.asset('assets/images/ic-close.png'),
            ),
          ),
          Positioned(
            top: 26.h,
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
                            textTextFeild: 'Confirm Password',
                            isobscureText: true,
                            focusNode: confirmPasswordFocusNode,
                            textEditingController: confirmPasswordController,
                          ),
                          SizedBox(height: 35.h),
                          ValueListenableBuilder(
                            valueListenable: valueNotifierColor,
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return const ButtonCheck(
                                text: 'Submit',
                                color: Color.fromRGBO(242, 246, 248, 1),
                                textColor: Color.fromRGBO(149, 149, 149, 1),

                              );
                            },
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
