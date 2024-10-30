import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constvalue/onboarding_screen/onboarding_color.dart';

class ContainerContactUs extends StatelessWidget{
  final String nameImageContactUs;
  final String textContactUs;

  const ContainerContactUs({super.key, required this.nameImageContactUs, required this.textContactUs});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: const Color.fromRGBO(236, 245, 250, 1))),
      height: 6.h,
      width: 100.w,
      child: Row(
        children: [
          SizedBox(width: 5.w,),
          Image.asset('assets/images/$nameImageContactUs'),
          SizedBox(width: 5.w,),
          Text(
            textContactUs,
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.normal,
                    color: ColorOnboarding.blackColor)),
          ),
        ],
      ),
    );
  }

}