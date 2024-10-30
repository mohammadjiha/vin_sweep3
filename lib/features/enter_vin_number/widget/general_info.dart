import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constvalue/onboarding_screen/onboarding_color.dart';

class GeneralInfo extends StatelessWidget {
   final String generalInfo;
  const GeneralInfo({super.key, required this.generalInfo});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 2.h,),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            generalInfo, // هنا يتم استخدام العنوان الممرر أو الافتراضي
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                color: ColorOnboarding.subTextColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          height: 6.h,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromRGBO(233, 241, 245, 1),
          ),
          child: const SizedBox(),
        ),
      ],
    );
  }
}
