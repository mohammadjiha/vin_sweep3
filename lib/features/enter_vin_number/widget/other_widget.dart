import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/constvalue/onboarding_screen/onboarding_color.dart';

class Ohter extends StatelessWidget{
  final String imageName;  final String titele;

  const Ohter({super.key, required this.imageName, required this.titele});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      width: 100.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color.fromRGBO(246, 248, 250, 1)),
      ),
      child: Padding(
        padding:  EdgeInsets.only(left: 3.w),
        child: Row(children: [
          Image.asset('assets/images/$imageName'),
          SizedBox(width:  5.w),
          Text(
            titele,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: ColorOnboarding.blackColor,
                fontSize: 16.sp,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ],),
      ),
    );
  }
  
}