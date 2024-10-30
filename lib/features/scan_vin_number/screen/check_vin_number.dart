import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:vin_sweep/features/home_screen/screen/home.dart';

import '../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../../authentication/screens/sigin&register/widgets/buttoncheck.dart';
import '../../authentication/screens/sigin&register/widgets/itemtextfeild.dart';
import '../../paperInfolderanimation/screen/paperInfolderanimation_screen.dart';

class VinNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9A-Z]'), '');
    StringBuffer formatted = StringBuffer();


    if (digitsOnly.length > 0) {
      formatted.write(digitsOnly.substring(0, 3)); // XXX
    }
    if (digitsOnly.length > 3) {
      formatted.write('-');
      formatted.write(digitsOnly.substring(3, 8)); // XXXXX
    }
    if (digitsOnly.length > 8) {
      formatted.write('-');
      formatted.write(digitsOnly.substring(8, 9)); // X
    }
    if (digitsOnly.length > 9) {
      formatted.write('-');
      formatted.write(digitsOnly.substring(9, 10)); // X
    }
    if (digitsOnly.length > 10) {
      formatted.write('-');
      formatted.write(digitsOnly.substring(10, 11)); // X
    }
    if (digitsOnly.length > 11) {
      formatted.write('-');
      formatted.write(digitsOnly.substring(11, 13)); // XX
    }
    if (digitsOnly.length > 13) {
      formatted.write('-');
      formatted.write(digitsOnly.substring(13, 17)); // XXXX
    }

    return TextEditingValue(
      text: formatted.toString(),
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class CheckVinNumber extends StatefulWidget {
  static const String routName = 'CheckVinNumber';
  final String vinNumber;

  const CheckVinNumber({super.key, required this.vinNumber});

  @override
  State<CheckVinNumber> createState() => _CheckVinNumberState();
}

class _CheckVinNumberState extends State<CheckVinNumber> {
  late TextEditingController vinController;
  final FocusNode vinFocusNodeForgot = FocusNode();
  final ValueNotifier<Color> valueNotifierColoVinNumber =
  ValueNotifier(const Color.fromRGBO(242, 246, 248, 1));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _updateButtonColor() {
    setState(() {
      valueNotifierColoVinNumber.value =
      (vinController.text.isNotEmpty)
          ? ColorOnboarding.pointSelected
          : const Color.fromRGBO(242, 246, 248, 1);
    });
  }

  @override
  void initState() {
    super.initState();
    vinController = TextEditingController(text: widget.vinNumber);
    valueNotifierColoVinNumber.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    vinController.dispose();
    vinFocusNodeForgot.dispose();
    valueNotifierColoVinNumber.removeListener(_updateButtonColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              width: 100.w,
              height: 40.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0a2342),
                    Color(0xFF253b5b),
                    Color.fromRGBO(32, 57, 88, 1),
                    Color(0xFF57708f),
                    Color(0xFF728caa),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 13.h),
                    Text(
                      'Scan Vehicle VIN Number',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorOnboarding.whiteColor)),
                    ),
                    Text(
                      'Scan your vehicle VIN number through the camera',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              color: ColorOnboarding.whiteColor)),
                    ),
                  ],
                ),
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: GestureDetector(
                onTap: () {
                  Get.toNamed(HomePage.routeName);
                },
                child: Image.asset('assets/images/ic-close.png'),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 26.h,
              child: Container(
                height: 100.h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: ColorOnboarding.whiteColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      SizedBox(height: 4.h),
                      Form(
                        key: _formKey,
                        child: ItemTextFeild(
                          textTextFeild: 'VIN Number',
                          isobscureText: false,
                          focusNode: vinFocusNodeForgot,
                          textEditingController: vinController,
                          inputFormatters: [VinNumberFormatter()],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                          height: 5.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: ColorOnboarding.pointSelected, width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ic-scan.png'),
                              SizedBox(width: 2.w),
                              Text(
                                'Re-Scan',
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorOnboarding.pointSelected)),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 35.h),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Get.to( const PaperInFolderAnimation());
                          }
                        },
                        child: ValueListenableBuilder(
                          valueListenable: valueNotifierColoVinNumber,
                          builder: (BuildContext context, value, Widget? child) {
                            return const ButtonCheck(
                              text: 'Search',
                              color: ColorOnboarding.pointSelected,
                              textColor:  ColorOnboarding.whiteColor
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
