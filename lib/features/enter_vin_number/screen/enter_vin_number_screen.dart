import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/features/enter_vin_number/widget/general_info.dart';
import 'package:vin_sweep/features/enter_vin_number/widget/other_widget.dart';
import '../../../../../constvalue/onboarding_screen/onboarding_color.dart';

class EnterVinNumberScreen extends StatefulWidget {
  static const String routName = 'EnterVinNumberScreen';

  const EnterVinNumberScreen({super.key});

  @override
  EnterVinNumberScreenState createState() => EnterVinNumberScreenState();
}

class EnterVinNumberScreenState extends State<EnterVinNumberScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  final GlobalKey _generalInfoKey = GlobalKey();
  final GlobalKey _engineKey = GlobalKey();
  final GlobalKey _mechanicalKey = GlobalKey();
  late final Color colorText;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                padding: EdgeInsets.only(left: 5.w, top: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2008 Mercedes C-Class',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorOnboarding.whiteColor,
                        ),
                      ),
                    ),
                    Text(
                      'Passenger Car',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: ColorOnboarding.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset('assets/images/ic-close.png'),
              ),
              title:  Text(
                '4Y1-SL658-4-8-Z-41-1439',
                style: TextStyle(
                  fontSize: 17.sp,
                    color: ColorOnboarding.whiteColor,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
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
                      ButtonsTabBar(
                        onTap: (index) {
                          switch (index) {
                            case 0:
                              _scrollToSection(_generalInfoKey);
                              break;
                            case 1:
                              _scrollToSection(_engineKey);
                              break;
                            case 2:
                              _scrollToSection(_mechanicalKey);
                              break;
                          }
                        },
                        controller: _tabController,
                        physics: const BouncingScrollPhysics(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                        height: 6.h,
                        backgroundColor: ColorOnboarding.pointSelected,
                        unselectedBackgroundColor:
                            ColorOnboarding.pointUnselected,
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        radius: 25,
                        tabs: const [
                          Tab(
                            text: 'General Info',
                          ),
                          Tab(
                            text: 'Engine',
                          ),
                          Tab(
                            text: 'Mechanical / Battery',
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              Container(
                                key: _generalInfoKey,
                                child: buildTabContent(),
                              ),
                              SizedBox(height: 4.h),
                              Container(
                                key: _engineKey,
                                child: buildTabEngine(),
                              ),
                              SizedBox(height: 4.h),
                              Container(
                                key: _mechanicalKey,
                                child: buildMechanicalBatterySection(),
                              ),
                            ],
                          ),
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

  Widget buildTabContent() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(242, 246, 248, 1)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/images/General Info.png'),
                SizedBox(width: 3.w),
                Text(
                  'General Info',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorOnboarding.blackColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            const Divider(color: Color.fromRGBO(233, 241, 245, 1)),
            const GeneralInfo(generalInfo: 'Destination Market',dataInfo: 'Europe',),
            const GeneralInfo(generalInfo: 'Make',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Manufacturer Name',dataInfo: 'Mercedes Benz',),
            const GeneralInfo(generalInfo: 'Model',dataInfo: 'C-Class',),
            const GeneralInfo(generalInfo: 'Model Year',dataInfo: '2008',),
            const GeneralInfo(generalInfo: 'Plant City',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Plant Company Name',dataInfo: 'Information not available',),
            const GeneralInfo(generalInfo: 'Plant State',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Series',dataInfo: 'Value'),
            const GeneralInfo(generalInfo: 'Series 2',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Trim',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Trim 2',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Vehicle Type',dataInfo: 'Value',),
          ],
        ),
      ),
    );
  }

  Widget buildTabEngine() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(242, 246, 248, 1)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/images/Engine.png'),
                SizedBox(width: 3.w),
                Text(
                  'Engine',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorOnboarding.blackColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            const Divider(color: Color.fromRGBO(233, 241, 245, 1)),
            const GeneralInfo(generalInfo: 'Cooling Type',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Displacement (CC)',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Displacement (CI)',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Displacement (L)',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Electrification Level',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Engine Configuration',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Engine Brake (hp) From',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Engine Brake (hp) To',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Engine Manufacturer',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Engine Model',dataInfo: 'Value',),
            const GeneralInfo(
                generalInfo: 'Fuel Delivery / Fuel Injection Type',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Engine Power (kW)',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Fuel Type - Primary',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Fuel Type - Secondary',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Top Speed (MPH)',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Turbo',dataInfo: 'Value',),
            const GeneralInfo(generalInfo: 'Valve Train Design',dataInfo: 'Value',),
            SizedBox(
              height: 3.h,
            ),
            const Ohter(
                imageName: 'Mechanical - Battery.png',
                titele: 'Mechanical / Battery'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Transmission.png',
                titele: 'Mechanical / Transmission'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Mechanical - Battery.png',
                titele: 'Interior / Seat'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Interior - Seat.png', titele: 'Interior / Seat'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Exterior - Body.png', titele: 'Exterior / Body'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Exterior - Dimension.png',
                titele: 'Exterior / Dimension'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Wheel.png', titele: 'Exterior / Wheel tire'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(imageName: 'Brake.png', titele: 'Mechanical / Brake'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Mechanical - Battery.png',
                titele: 'Mechanical / Battery / Charger'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Passive Safety System.png',
                titele: 'Passive Safety System / Air Bag Location'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(imageName: 'Interior.png', titele: 'Interior'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Active Safety - Safe Distance.png',
                titele: 'Active Safety System / Maintaining '),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Active Safety.png', titele: 'Mechanical / Battery'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Mechanical - Battery.png',
                titele: 'Mechanical / Battery'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Lighting Technology.png',
                titele: 'AActive Safety System / Lane '),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Lane & Side Assist.png',
                titele: 'Mechanical / Battery'),
            SizedBox(
              height: 2.h,
            ),
            const Ohter(
                imageName: 'Passive Safety System.png',
                titele: 'Passive Safety System'),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMechanicalBatterySection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(242, 246, 248, 1)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/images/Mechanical - Battery.png'),
                SizedBox(width: 3.w),
                Text(
                  'Mechanical / Battery',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorOnboarding.blackColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            const Divider(color: Color.fromRGBO(233, 241, 245, 1)),
            const Ohter(
                imageName: 'Mechanical - Battery.png',
                titele: 'Mechanical / Battery'),
          ],
        ),
      ),
    );
  }
}
