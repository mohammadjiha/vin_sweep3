import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/features/onboarding/widgets/pointer_widget.dart';

import '../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../controller/page_view_controller.dart';

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // final OnboardingController controller = Get.put(OnboardingController()); //same same
    final OnboardingController controller = Get.find();
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.width < 600 ? 0.h : 10.h),
        MediaQuery.of(context).size.width < 600
            ? Image.asset(imagePath)
            : Transform.scale(
          scale: 2,
          child: Image.asset(imagePath),
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: EdgeInsets.only(left: 5.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.width < 600 ? 0.h : 5.h),
              Text(
                title,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 600 ? 19.sp : 22.5.sp,
                    color: ColorOnboarding.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                description,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 600 ? 15.4.sp : 17.sp,
                    color: ColorOnboarding.subTextColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.only(right: 1.w),
                child: Row(
                  children: List.generate(
                    3,
                        (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: PointerContainer(
                        colorContainer: controller.currentPage.value == index
                            ? ColorOnboarding.pointSelected
                            : ColorOnboarding.pointUnselected,
                        numberWith: 6,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}