import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../../home_screen/screen/home.dart';
import '../../menu/screen/menu_screen.dart';
import '../../test/screen.dart';

class Navbar01Widget extends StatelessWidget {
  const Navbar01Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 27, 0, 0),
          child: Container(
            decoration: const BoxDecoration(
              color: ColorOnboarding.pointSelected,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 76),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(SearchHistoryPage.routName); // Navigate to HomePage
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/Ic-Home.png'),
                         Text(
                          'Home',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(Menu.routName); // Navigate to Menu
                    },
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/ic-menu23.png'),
                           Text(
                            'Menu',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              color: Colors.white,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ].divide(const SizedBox(width: 8)),
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0, -1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeIn,
            width: 22.w,
            height: 10.h,
            decoration: const BoxDecoration(
              color: ColorOnboarding.pointSelected,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
