import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../../home_screen/screen/home.dart';

class Navbar02Widget extends StatelessWidget {
  const Navbar02Widget({super.key});

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
                      Navigator.of(context).pushNamed(
                        HomePage.routeName,
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/Ic-Home.png'),
                        const Text(
                          'Home',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/menu.png'),
                      const Text(
                        'Menu',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
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
            child: Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Container(
                width: 20.w,
                height: 9.h,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(186, 104, 200, 1), // shadow color
                      blurRadius: 30,
                      spreadRadius: 1,
                    )
                  ],
                  color: Color.fromRGBO(186, 104, 200, 1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
