import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/constvalue/onboarding_screen/onboarding_color.dart';

class CustemTabBar extends StatelessWidget {
  final String textTabBar;
  final bool isSelected;

  const CustemTabBar({super.key, required this.textTabBar, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isSelected ? ColorOnboarding.pointSelected : const Color.fromRGBO(237, 245, 255, 1),
      ),
      height: 6.h,
      child: Text(
        textTabBar,
        style: GoogleFonts.lato(
          textStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16.sp,
          ),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
