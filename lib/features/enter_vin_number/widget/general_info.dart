import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constvalue/onboarding_screen/onboarding_color.dart';

class GeneralInfo extends StatelessWidget {
   final String generalInfo;
   final String dataInfo;
   const GeneralInfo({super.key, required this.generalInfo ,  this.dataInfo=''});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 2.h,),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            generalInfo,
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
          padding: EdgeInsets.only(left: 5.w),
          alignment: Alignment.centerLeft,
          height: 6.h,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromRGBO(233, 241, 245, 1),
          ),
          child: Text(dataInfo,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16.sp),),
        ),
      ],
    );
  }
}
