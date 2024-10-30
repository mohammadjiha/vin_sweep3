import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/constvalue/onboarding_screen/onboarding_color.dart';
import 'package:vin_sweep/features/onboarding/widgets/button.dart';
import 'package:vin_sweep/features/onboarding/widgets/pointer_widget.dart';

import '../../authentication/screens/sigin&register/screen/signin_screen.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});
  static const String routName = 'PageViewScreen';

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final PageController _pageController = PageController();
  ValueNotifier<String> valueNotifier =
      ValueNotifier('assets/images/image-removebg-preview.png');
  int currentPage = 0;
  void _onChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: ColorOnboarding.whiteColor,
        statusBarIconBrightness: Brightness.dark));
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    _pageController.jumpToPage(2);
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
            SizedBox(
              height: 7.h,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width < 600 ? 65.h : 70.h,
              // color: Colors.black,
              child: ValueListenableBuilder(
                valueListenable: valueNotifier,
                builder: (BuildContext context, value, Widget? child) {
                  return PageView(
                    controller: _pageController,
                    onPageChanged: _onChanged,
                    children: [
                      OnboardingPage(
                        imagePath: 'assets/images/image-removebg-preview.png',
                        title: 'Easily Scan Any Vehicle Type for Details',
                        description:
                            'Supports sedans, hatchbacks, trucks, and more. Get information on any vehicle type easily.',
                        currentPage: currentPage,
                        pageIndex: 0,
                        pageCount: 3,
                      ),
                      OnboardingPage(
                        imagePath: 'assets/images/image-removebg-preview2.png',
                        title: 'Enter VIN by Camera, Image, or Manually',
                        description:
                            'Quickly get information about any vehicle by entering the VIN manually, scanning an image, or taking a photo.',
                        currentPage: currentPage,
                        pageIndex: 1,
                        pageCount: 3,
                      ),
                      OnboardingPage(
                        imagePath: 'assets/images/image-removebg-preview3.png',
                        title: 'Get Detailed and Accurate Vehicle Information',
                        description:
                            'Retrieve comprehensive details about any vehicle, including make, model, year, and specifications.',
                        currentPage: currentPage,
                        pageIndex: 2,
                        pageCount: 3,
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height <= 670 ? 6.h : 1.h,
            ),
            currentPage == 0
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: GestureDetector(
                      onTap: () {
                        _pageController.nextPage(
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
                      GestureDetector(
                          onTap: () {
                            _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          child: const Button(
                            text: 'Back',
                            colorContainer: ColorOnboarding.whiteColor,
                            colorText: ColorOnboarding.pointSelected,
                          )),
                      GestureDetector(
                          onTap: () {
                            currentPage == 2
                                ? Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const SignInScreen()),
                                    (Route<dynamic> route) => false,
                                  )
                                : _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                          },
                          child: Button(
                            text: currentPage == 2 ? 'Get Started' : 'Next',
                            colorContainer: ColorOnboarding.pointSelected,
                            colorText: ColorOnboarding.whiteColor,
                          )),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final int currentPage;
  final int pageIndex;
  final int pageCount;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.currentPage,
    required this.pageIndex,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: MediaQuery.of(context).size.width < 600 ? 0.h : 5.h,
              ),
              Text(
                title,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 600
                        ? 19.sp
                        : 22.5.sp,
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
                    fontSize: MediaQuery.of(context).size.width < 600
                        ? 15.4.sp
                        : 17.sp,
                    color: ColorOnboarding.subTextColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.w),
                child: Row(
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: PointerContainer(
                        colorContainer: currentPage == index
                            ? ColorOnboarding.pointSelected
                            : ColorOnboarding.pointUnselected,
                        numberWith: currentPage == index ? 9 : 6,
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
