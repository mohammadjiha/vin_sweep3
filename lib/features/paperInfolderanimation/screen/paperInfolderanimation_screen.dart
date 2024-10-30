import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../../enter_vin_number/screen/enter_vin_number_screen.dart';

class PaperInFolderAnimation extends StatefulWidget {
  static const String routName='PaperInFolderAnimation';

  const PaperInFolderAnimation({super.key});
  @override
  PaperInFolderAnimationState createState() => PaperInFolderAnimationState();
}

class PaperInFolderAnimationState extends State<PaperInFolderAnimation> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(EnterVinNumberScreen.routName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/fZKpPlN2ff.json',
              fit: BoxFit.contain,
            ),
        SizedBox(height: 2.h,),
        Text(
          'Searching for Info',
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
