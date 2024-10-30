import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../../home_screen/screen/home.dart';

class LoadingScreenAnimation extends StatefulWidget {
  static const String routName = 'LoadingScreenAnimation';

  const LoadingScreenAnimation({super.key});

  @override
  LoadingScreenAnimationState createState() => LoadingScreenAnimationState();
}

class LoadingScreenAnimationState extends State<LoadingScreenAnimation> with SingleTickerProviderStateMixin {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    userData = Get.arguments ?? {};
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(
        HomePage.routeName,
        arguments: userData,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 30.h,
                width: 60.w,
                child: Lottie.asset('assets/animations/xZ2YiXjgHi.json',)),
            Text(
              'Loading',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 15.sp,
                  color: ColorOnboarding.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
