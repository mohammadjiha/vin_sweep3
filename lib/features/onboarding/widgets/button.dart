import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/constvalue/onboarding_screen/onboarding_color.dart';

class Button extends StatelessWidget {
  final String text;
  final Color colorContainer;
  final Color colorText;

  const Button({super.key, required this.text, required this.colorContainer, required this.colorText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40.w,
      height: 6.h,
      decoration: BoxDecoration(color: colorContainer,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: ColorOnboarding.pointSelected)

      ),
      child: Text(
        text,
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
              fontSize: 16.sp,
              color: colorText,
              fontWeight: FontWeight.bold),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}