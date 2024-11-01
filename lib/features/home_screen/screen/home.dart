import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/constvalue/onboarding_screen/onboarding_color.dart';
import 'package:vin_sweep/features/enter_vin/screen/enter_vin_screen.dart';
import 'package:vin_sweep/features/home_screen/controller/cameracontroller.dart';

import '../controller/home_controoler.dart';
import '../widget/navbar01widget.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'HomePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final HomeController homeController = Get.put(HomeController());

  bool isDilalOpen = false;
  late String email;
  late String name;
  late int zipCode;

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> userData = Get.arguments ?? {};
    email = userData['email'] ?? 'No Email';
    name = userData['name'] ?? 'No Name';
    zipCode = userData['zipCode'] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorOnboarding.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Home',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: ColorOnboarding.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              SizedBox(height: 5.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text.rich(
                  TextSpan(
                    text: 'Welcome\t',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: ColorOnboarding.blackColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 18.sp,
                      ),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '$name,',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: ColorOnboarding.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Stack(children: [
                Image.asset('assets/images/Illustration_with_card.png'),
                Positioned(
                  right: 10.w,
                  top: 5.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '120',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 22.sp,
                            color: ColorOnboarding.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Total Sweeps',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 15.sp,
                            color: ColorOnboarding.subTextColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              SizedBox(height: 4.h),
              TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle:
                        const TextStyle(color: ColorOnboarding.subTextColor),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: ColorOnboarding.subTextColor,
                    filled: true,
                    fillColor: const Color.fromRGBO(248, 250, 252, 1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(242, 246, 248, 1),
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
                  onTap: () {}),
              SizedBox(height: 3.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Latest Scans',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 17.sp,
                      color: ColorOnboarding.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Image.asset('assets/images/Illustration.png'),
              Column(
                children: [
                  SizedBox(height: 2.h),
                  Text(
                    'No Scans Yet',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 17.sp,
                        color: ColorOnboarding.pointSelected,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'The list is currently empty',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 17.sp,
                        color: ColorOnboarding.subTextColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        height: 9.h,
        width: 20.w,
        child: Obx(
          () => SpeedDial(
            spacing: 1.h,
            overlayColor: const Color.fromRGBO(61, 61, 61, 1),
            backgroundColor: const Color.fromRGBO(186, 104, 200, 1),
            animatedIcon: homeController.isDialOpen.value
                ? AnimatedIcons.menu_close
                : AnimatedIcons.add_event,
            activeBackgroundColor: const Color.fromRGBO(186, 104, 200, 1),
            animatedIconTheme: IconThemeData(color: Colors.white, size: 22.sp),
            childrenButtonSize: Size.square(35.sp),
            openCloseDial: ValueNotifier(homeController.isDialOpen.value),
            onOpen: () => homeController.toggleDial(),
            onClose: () => homeController.toggleDial(),
            children: [
              SpeedDialChild(
                  label: 'Upload',
                  labelStyle: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  backgroundColor: const Color.fromRGBO(168, 200, 220, 1),
                  child: Image.asset('assets/images/ic-upload.png'),
                  onTap: () {}),
              SpeedDialChild(
                label: 'Scan',
                labelStyle: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                backgroundColor: const Color.fromRGBO(120, 161, 187, 1),
                child: Image.asset('assets/images/ic-scsn.png'),
                onTap: () {
                  Get.to(const CarPlateRecognition());
                },
              ),
              SpeedDialChild(
                label: 'Enter VIN',
                labelStyle: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                backgroundColor: const Color.fromRGBO(83, 141, 178, 1),
                child: Image.asset('assets/images/ic-number.png'),
                onTap: () {
                  Get.to(const EnterVinScreen());
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
        FloatingActionButtonLocation.centerDocked,
        yOffset: homeController.isDialOpen.value == false ? 5.h : -6.h,
      ),
      bottomNavigationBar: Obx(
        () => AnimatedSize(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: isDilalOpen
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 15.h,
                  child: homeController.isDialOpen.value
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 15.h,
                          child: const Navbar01Widget(),
                        )),
        ),
      ),
    );
  }
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final FloatingActionButtonLocation baseLocation;
  final double yOffset;

  CustomFloatingActionButtonLocation(this.baseLocation, {this.yOffset = 0.0});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final Offset baseOffset = baseLocation.getOffset(scaffoldGeometry);
    return Offset(baseOffset.dx, baseOffset.dy + yOffset);
  }
}

extension WidgetList on List<Widget> {
  List<Widget> divide(Widget divider) => [
        for (int i = 0; i < length; i++) ...[
          if (i > 0) divider,
          this[i],
        ],
      ];
}
