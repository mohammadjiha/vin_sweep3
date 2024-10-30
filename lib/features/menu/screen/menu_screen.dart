import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/features/authentication/screens/deactive/screen/deactivate.dart';
import 'package:vin_sweep/features/changpasswordnew/screen/changepasswordnew.dart';
import 'package:vin_sweep/features/contactus/screen/contactus_screen.dart';
import 'package:vin_sweep/features/menu/widget/contenerwidget.dart';
import 'package:vin_sweep/features/profile/screens/profile_screen.dart';

import '../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../../authentication/screens/sigin&register/screen/signin_screen.dart';

class Menu extends StatelessWidget {
  static const String routName = 'Menu';

  const Menu({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Menu',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: ColorOnboarding.blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        body: Column(children: [
          SizedBox(
            height: 5.h,
          ),
          Countener(
            nameImage: 'ic-profile.png',
            text: 'Profile',
            nameImage2: 'ic-arrow.png',
            onTap: () {
              Navigator.of(context).pushNamed(ProfileScreen.routName);
            },
          ),
          const Divider(
            color: Color.fromRGBO(226, 236, 242, 1),
          ),
          Countener(
            nameImage: 'ic -contact us.png',
            text: 'Contact Us',
            nameImage2: 'ic-arrow.png',
            onTap: () {
              Get.toNamed(ContactusScreen.routName);
            },
          ),
          const Divider(
            color: Color.fromRGBO(226, 236, 242, 1),
          ),
          Countener(
            nameImage: 'ic-pass.png',
            text: 'Change Password',
            nameImage2: 'ic-arrow.png',
            onTap: () {Navigator.of(context).pushNamed(ChanngePasswordNew.routName);},
          ),
          const Divider(
            color: Color.fromRGBO(226, 236, 242, 1),
          ),
          Countener(
            nameImage: 'ic-about us.png',
            text: 'About Us',
            nameImage2: 'ic-link.png',
            onTap: () {},
          ),
          const Divider(
            color: Color.fromRGBO(226, 236, 242, 1),
          ),
          Countener(
            nameImage: 'ic-terms 7 conditions.png',
            text: 'Terms & Conditions',
            nameImage2: 'ic-link.png',
            onTap: () {},
          ),
          const Divider(
            color: Color.fromRGBO(226, 236, 242, 1),
          ),
          Countener(
            nameImage: 'ic-privacy.png',
            text: 'Privacy Policy',
            nameImage2: 'ic-link.png',
            onTap: () {},
          ),
          const Divider(
            color: Color.fromRGBO(226, 236, 242, 1),
          ),
          Countener(
            nameImage: 'ic-deactivate.png',
            text: 'Deactivate',
            nameImage2: 'ic-arrow.png',
            onTap: () {Navigator.of(context).pushNamed(DeactivateScreen.routName);},
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.h),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  SignInScreen.routName,
                      (Route<dynamic> route) => false, // This removes all previous routes
                );
              },
              child: Container(
                height: 5.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.red, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/ic-logout.png'),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      'Logout',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
    );
  }
}
