import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/features/authentication/screens/deactive/screen/deactivate.dart';
import 'package:vin_sweep/features/authentication/screens/otp_screen/screen/otp_screen.dart';
import 'package:vin_sweep/features/changpasswordnew/screen/changepasswordnew.dart';
import 'package:vin_sweep/features/contactus/screen/contactus_screen.dart';
import 'package:vin_sweep/features/enter_vin/screen/enter_vin_screen.dart';
import 'package:vin_sweep/features/enter_vin_number/screen/enter_vin_number_screen.dart';
import 'package:vin_sweep/features/home_screen/controller/cameracontroller.dart';
import 'package:vin_sweep/features/home_screen/screen/home.dart';
import 'package:vin_sweep/features/loading/screen/loading_screen.dart';
import 'package:vin_sweep/features/menu/screen/menu_screen.dart';
import 'package:vin_sweep/features/onboarding/screens/pagview.dart';
import 'package:vin_sweep/features/paperInfolderanimation/screen/paperInfolderanimation_screen.dart';
import 'package:vin_sweep/features/profile/screens/profile_screen.dart';
import 'package:vin_sweep/features/scan_vin_number/screen/check_vin_number.dart';
import 'package:vin_sweep/features/test/test.dart';

import 'features/authentication/screens/changepasswoed/screen/changepassword_screen.dart';
import 'features/authentication/screens/forgot/screen/forgotscreen.dart';
import 'features/authentication/screens/sigin&register/screen/signin_screen.dart';
import 'features/test/screen.dart';

void main() {
  runApp( const VinSweep());
}

class VinSweep extends StatelessWidget {
  const VinSweep({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext, Orientation, ScreenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vin Sweep',
          routes: {
            '/': (context) => const PageViewScreen(),
            HomePage.routeName:(context)=> HomePage(),
            SignInScreen.routName: (context) => const SignInScreen(),
            ForgotScreen.routName:(context)=>const ForgotScreen(),
            ChangePasswordScreen.routName:(context)=> const ChangePasswordScreen(),
            ProfileScreen.routName:(context)=>const ProfileScreen(),
            ContactusScreen.routName:(context)=>const ContactusScreen(),
            OtpScreen.routName:(context)=>const OtpScreen(),
            Menu.routName:(context)=>const Menu(),
            ChanngePasswordNew.routName:(context)=>const ChanngePasswordNew(),
            CarPlateRecognition.routName:(context)=> const CarPlateRecognition(),
            EnterVinScreen.routName:(context)=>const  EnterVinScreen(),
            SearchHistoryPage.routName:(context)=>SearchHistoryPage(),
            PaperInFolderAnimation.routName:(context)=>const PaperInFolderAnimation(),
            LoadingScreenAnimation.routName:(context)=>const LoadingScreenAnimation(),
            EnterVinNumberScreen.routName:(context)=>const EnterVinNumberScreen(),
            DeactivateScreen.routName:(context)=>const DeactivateScreen(),
            CheckVinNumber.routName: (context) {
              // Retrieve the VIN number from the arguments if you need it
              final args = ModalRoute.of(context)!.settings.arguments as String;
              return CheckVinNumber(vinNumber: args); // Pass VIN here
            },

          },
        );
      },
    );
  }
}
