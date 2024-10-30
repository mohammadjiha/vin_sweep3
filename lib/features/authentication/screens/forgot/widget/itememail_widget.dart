import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constvalue/onboarding_screen/onboarding_color.dart';

class ItemEmailWiget extends StatelessWidget{
  final String nameImage;
  final String textTextFeild;
  const ItemEmailWiget({super.key, required this.nameImage, required this.textTextFeild});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/$nameImage'),
        const SizedBox(width: 8),
        Text(
          textTextFeild,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 15.sp,
              color: ColorOnboarding.subTextColor,
            ),
          ),
        ),
      ],
    );
  }

}