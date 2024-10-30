import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constvalue/onboarding_screen/onboarding_color.dart';

class ItemTextFeild extends StatefulWidget {
  const ItemTextFeild({
    super.key,
    this.nameImage = '',
    required this.textTextFeild,
    required this.isobscureText,
    required this.textEditingController,
    required this.focusNode,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  });

  final String nameImage; // Optional
  final String textTextFeild;
  final bool isobscureText;
  final TextEditingController textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  @override
  _ItemTextFeildState createState() => _ItemTextFeildState();
}

class _ItemTextFeildState extends State<ItemTextFeild> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isobscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (widget.nameImage.isNotEmpty)
              Image.asset('assets/images/${widget.nameImage}'),
            const SizedBox(width: 8),
            Text(
              widget.textTextFeild,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 15.sp,
                  color: ColorOnboarding.subTextColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          inputFormatters: widget.inputFormatters,
          controller: widget.textEditingController,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: _obscureText,
          onSubmitted: (_) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(248, 250, 252, 1),
            contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            suffixIcon: widget.isobscureText
                ? IconButton(
              onPressed: _togglePasswordVisibility,
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: ColorOnboarding.subTextColor,
              ),
            )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: ColorOnboarding.whiteColor,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: ColorOnboarding.whiteColor,
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
