import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constvalue/onboarding_screen/onboarding_color.dart';

class Countener extends StatelessWidget{
  final String nameImage;
  final String text;
  final String nameImage2;
  final VoidCallback onTap;
  const Countener({super.key, required this.nameImage, required this.text, required this.nameImage2, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.h),
      child: GestureDetector(
        onTap:onTap ,
        child: SizedBox(
          height: 5.h,
          width: 100.w,
          child: Row(
            children: [

              Image.asset('assets/images/$nameImage'),
              const Spacer(flex: 1,),
              Text(
                text,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: ColorOnboarding.blackColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 17.sp,
                  ),
                ),
              ),
              const Spacer(flex:10,),
              Image.asset('assets/images/$nameImage2'),

            ],
          ),
        ),
      ),
    );
  }

}