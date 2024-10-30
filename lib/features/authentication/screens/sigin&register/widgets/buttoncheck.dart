import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ButtonCheck extends StatelessWidget{
  final String _text;
  final Color color;
  final Color textColor;

  const ButtonCheck({super.key,required String text, required this.color, required this.textColor, }):_text=text ;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100.w,
      height: 6.h,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25)),
      child: Text(
        _text,
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
              fontSize: 18.sp,
              color:  textColor,
              fontWeight: FontWeight.bold),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

}
