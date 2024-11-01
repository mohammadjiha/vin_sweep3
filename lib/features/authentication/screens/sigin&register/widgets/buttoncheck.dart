import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ButtonCheck extends StatelessWidget {
  final String _text;
  final Color color;
  final Color textColor;
  final VoidCallback? onPressed; // Make onPressed optional

  const ButtonCheck({
    super.key,
    required String text,
    required this.color,
    required this.textColor,
    this.onPressed, // Initialize the optional parameter
  }) : _text = text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Call onPressed when the button is tapped
      child: Container(
        alignment: Alignment.center,
        width: 100.w,
        height: 6.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          _text,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 18.sp,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
