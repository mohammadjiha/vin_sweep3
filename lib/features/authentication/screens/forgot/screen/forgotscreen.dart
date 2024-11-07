import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/features/authentication/screens/changepasswoed/screen/changepassword_screen.dart';
import '../../../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../../../../onboarding/widgets/button.dart';
import '../../sigin&register/widgets/buttoncheck.dart';
import '../../sigin&register/widgets/itemtextfeild.dart';

class ForgotScreen extends StatefulWidget {
  static const String routName = 'ForgotScreen';

  const ForgotScreen({super.key});
  @override
  ForgotScreenState createState() => ForgotScreenState();
}

class ForgotScreenState extends State<ForgotScreen> {
  final TextEditingController emailControllerForgot = TextEditingController();

  final FocusNode emailFocusNodeForgot = FocusNode();
  final ValueNotifier<Color> valueNotifierColorForgotScreen =
  ValueNotifier(const Color.fromRGBO(242, 246, 248, 1));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailControllerForgot.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    emailControllerForgot.removeListener(_updateButtonColor);
    emailControllerForgot.dispose();
    emailFocusNodeForgot.dispose();
    super.dispose();
  }

  void _updateButtonColor() {
    setState(() {
      valueNotifierColorForgotScreen.value =
      (emailControllerForgot.text.isNotEmpty && _validateEmail(emailControllerForgot.text))
          ? ColorOnboarding.pointSelected
          : const Color.fromRGBO(242, 246, 248, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                    SizedBox(height: 13.h),
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
              left: 0,
              right: 0,
              top: 26.h,
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
                      Form(
                        key: _formKey,
                        child: ItemTextFeild(
                          nameImage: 'ic-mail.png',
                          textTextFeild: 'Email',
                          isobscureText: false,
                          focusNode: emailFocusNodeForgot,
                          textEditingController: emailControllerForgot,
                        ),
                      ),
                      SizedBox(height: 47.h),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate() && _validateEmail(emailControllerForgot.text) ) {
                            Navigator.of(context)
                                .pushNamed(ChangePasswordScreen.routName);
                            showDialog(context: context, builder: (_) => showDailog());
                          } else {
                            _showSnackbar("Invalid Input",
                                "Please correct the errors in the form.");
                          }
                        },
                        child: ValueListenableBuilder(
                          valueListenable: valueNotifierColorForgotScreen,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return ButtonCheck(
                              text: 'Submit',
                              color: value,
                              textColor: value ==
                                  ColorOnboarding.pointSelected
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
      ),
    );
  }

  bool _validateEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  void _showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }
}
AlertDialog showDailog() {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    content: SizedBox(
      height: 50.h,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Image.asset(
            'assets/images/checkurmail.png',
            height: 20.h,
          ),
          SizedBox(height: 2.h),
          Text(
            "Please Check your Email",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text(
            "An email with a new password has been sent to you, "
                "please check the junk folder if you didn't find it in the inbox.",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.back(); // Close the dialog when tapped
            },
            child: const Button(
              text: 'Done',
              colorContainer: ColorOnboarding.pointSelected,
              colorText: ColorOnboarding.whiteColor,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            '© 2024 VINsweep. All Rights Reserved.',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.normal,
                color: ColorOnboarding.subTextColor,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}