import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/constvalue/onboarding_screen/onboarding_color.dart';
import 'package:vin_sweep/features/onboarding/widgets/button.dart';
import '../../authentication/screens/sigin&register/screen/sigin_screen.dart';
import '../controller/page_view_controller.dart';
import '../widgets/onboarding.dart';

class PageViewScreen extends GetView<OnboardingController> {
  const PageViewScreen({super.key});
  static const String routName = 'PageViewScreen';

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.put(OnboardingController());
    final PageController pageController = PageController(); 

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: ColorOnboarding.whiteColor,
        statusBarIconBrightness: Brightness.dark));
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorOnboarding.whiteColor,
        body: Column(
          children: [
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    // controller.skip();
                    pageController.jumpToPage(2);
                  },
                  child: FittedBox(
                    child: Text(
                      'Skip',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 18.sp,
                              color: ColorOnboarding.subTextColor,
                              fontWeight: FontWeight.normal)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 7.h),
            SizedBox(
                height: MediaQuery.of(context).size.width < 600 ? 65.h : 70.h,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (index) => controller.currentPage.value = index,
                  children:  const [
                    OnboardingPage(
                      imagePath: 'assets/images/image-removebg-preview.png',
                      title: 'Easily Scan Any Vehicle Type for Details',
                      description:
                      'Supports sedans, hatchbacks, trucks, and more. Get information on any vehicle type easily.',
                    ),
                    OnboardingPage(
                      imagePath: 'assets/images/image-removebg-preview2.png',
                      title: 'Enter VIN by Camera, Image, or Manually',
                      description:
                      'Quickly get information about any vehicle by entering the VIN manually, scanning an image, or taking a photo.',
                    ),
                    OnboardingPage(
                      imagePath: 'assets/images/image-removebg-preview3.png',
                      title: 'Get Detailed and Accurate Vehicle Information',
                      description:
                      'Retrieve comprehensive details about any vehicle, including make, model, year, and specifications.',
                    ),
                  ],
                )),
            SizedBox(height: MediaQuery.of(context).size.height <= 670 ? 6.h : 1.h),
            Obx(() {
              return controller.currentPage.value == 0
                  ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: GestureDetector(
                  onTap: () {
                    controller.nextPage();
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 100.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                        color: ColorOnboarding.pointSelected,
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      'Next',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 18.sp,
                            color: ColorOnboarding.whiteColor,
                            fontWeight: FontWeight.normal),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (controller.currentPage.value > 0)
                    GestureDetector(
                      onTap: () {
                        controller.previousPage();
                        pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: const Button(
                        text: 'Back',
                        colorContainer: ColorOnboarding.whiteColor,
                        colorText: ColorOnboarding.pointSelected,
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      if (controller.currentPage.value == 2) {
                        Get.offAll(() => const SignInScreen());
                      } else {
                        controller.nextPage();
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      }
                    },
                    child: Button(
                      text: controller.currentPage.value == 2
                          ? 'Get Started'
                          : 'Next',
                      colorContainer: ColorOnboarding.pointSelected,
                      colorText: ColorOnboarding.whiteColor,
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}


