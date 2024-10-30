import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../../authentication/screens/sigin&register/widgets/buttoncheck.dart';
import '../../authentication/screens/sigin&register/widgets/itemtextfeild.dart';
import '../../home_screen/screen/home.dart';
import '../../paperInfolderanimation/screen/paperInfolderanimation_screen.dart';
import '../../scan_vin_number/screen/check_vin_number.dart';

class EnterVinScreen extends StatefulWidget{
  static const String routName='EnterVinScreen';
  const EnterVinScreen({super.key});

  @override
  State<EnterVinScreen> createState() => _EnterVinScreenState();
}

class _EnterVinScreenState extends State<EnterVinScreen> {
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
    vinController = TextEditingController();
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
                      'Enter Vehicle VIN Number',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorOnboarding.whiteColor)),
                    ),
                    Text(
                      'Enter the vehicle VIN number, it is a serial number and contains 17 character alphanumeric',
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
                  Navigator.of(context).pushNamed(HomePage.routeName);
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

                      SizedBox(height: 45.h),
                      GestureDetector(
                        onTap: () {
                          Get.to(  const PaperInFolderAnimation());
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