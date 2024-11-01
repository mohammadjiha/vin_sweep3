import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/constvalue/onboarding_screen/onboarding_color.dart';

import '../controller/sigin_controller_title.dart';
import '../widgets/registertab.dart';
import '../widgets/sigin_tab.dart';

class SignInScreen extends StatefulWidget {
  static const String routName = 'SignInScreen';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInControllerTitle controller = Get.put(SignInControllerTitle());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
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
                    Obx(() => SizedBox(height: controller.heightBoxSize.value)),
                    Obx(() => Text(
                      controller.title.value,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorOnboarding.whiteColor)),
                    )),
                    Obx(() => Text(
                      controller.description.value,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              color: ColorOnboarding.whiteColor)),
                    )),
                  ],
                ),
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            Obx(
                  () => Positioned(
                top: controller.height.value,
                left: 0,
                right: 0,
                child: Container(
                  height: 100.h,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: ColorOnboarding.whiteColor,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                        child: Container(
                          height: 7.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromRGBO(242, 246, 248, 1)),
                          child: TabBar(
                            onTap: (index) {
                              controller.updateValues(index);
                            },
                            indicatorPadding: EdgeInsets.symmetric(vertical: 0.8.h),
                            tabAlignment: TabAlignment.center,
                            dividerColor: ColorOnboarding.whiteColor,
                            labelColor: Colors.black,
                            labelStyle: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 17.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal)),
                            unselectedLabelColor: ColorOnboarding.blackColor,
                            indicator: ShapeDecoration(
                                color: ColorOnboarding.whiteColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            tabs: [
                              Tab(
                                child: SizedBox(
                                  width: 36.w,
                                  child: Text(
                                    'Sign In',
                                    style: GoogleFonts.openSans(
                                        textStyle: const TextStyle()),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Tab(
                                child: SizedBox(
                                  width: 36.w,
                                  child: Text(
                                    'Register',
                                    style: GoogleFonts.openSans(
                                        textStyle: const TextStyle()),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [SignInTab(), RegisterTab()],
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
