// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
// import 'package:vin_sweep/constvalue/onboarding_screen/onboarding_color.dart';
//
// import '../widgets/registertab.dart';
// import '../widgets/signIntab.dart';
//
// class SignInScreen extends StatefulWidget {
//   static const String routName = 'SignInScreen';
//
//   const SignInScreen({super.key});
//
//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen>
//     with SingleTickerProviderStateMixin {
//   ValueNotifier<double> valueNotifierHeight = ValueNotifier(35.h);
//   ValueNotifier<String> valueNotifierTitel = ValueNotifier('Login');
//   ValueNotifier<String> valueNotifierDescription =
//       ValueNotifier('Please enter your credentials below');
//   ValueNotifier<double> valueNotifierHeightBoxSize = ValueNotifier(25.h);
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       setState(() {
//         if (_tabController.index == 1) {
//           valueNotifierHeight.value = 20.h;
//           valueNotifierTitel.value = 'Create your Account';
//           valueNotifierDescription.value = 'Please fill your information below';
//           valueNotifierHeightBoxSize.value = 10.h;
//         } else {
//           valueNotifierHeight.value = 35.h;
//           valueNotifierTitel.value = 'Login';
//           valueNotifierHeightBoxSize.value = 25.h;
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Container(
//               width: 100.w,
//               height: 40.h,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color(0xFF0a2342),
//                     Color(0xFF253b5b),
//                     Color.fromRGBO(32, 57, 88, 1),
//                     Color(0xFF57708f),
//                     Color(0xFF728caa),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(left: 5.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ValueListenableBuilder(
//                       valueListenable: valueNotifierHeightBoxSize,
//                       builder: (BuildContext context, value, Widget? child) {
//                         return SizedBox(
//                           height: valueNotifierHeightBoxSize.value,
//                         );
//                       },
//                     ),
//                     ValueListenableBuilder(
//                       valueListenable: valueNotifierTitel,
//                       builder: (BuildContext context, value, Widget? child) {
//                         return Text(
//                           valueNotifierTitel.value,
//                           style: GoogleFonts.openSans(
//                               textStyle: TextStyle(
//                                   fontSize: 20.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: ColorOnboarding.whiteColor)),
//                         );
//                       },
//                     ),
//                     ValueListenableBuilder(
//                       valueListenable: valueNotifierDescription,
//                       builder: (BuildContext context, value, Widget? child) {
//                         return Text(
//                           valueNotifierDescription.value,
//                           style: GoogleFonts.openSans(
//                               textStyle: TextStyle(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.normal,
//                                   color: ColorOnboarding.whiteColor)),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               automaticallyImplyLeading: false,
//             ),
//             ValueListenableBuilder(
//               valueListenable: valueNotifierHeight,
//               builder: (BuildContext context, value, Widget? child) {
//                 return Positioned(
//                   top: valueNotifierHeight.value,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     height: 100.h,
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(50),
//                         topRight: Radius.circular(50),
//                       ),
//                       color: ColorOnboarding.whiteColor,
//                     ),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 5.w, vertical: 3.h),
//                           child: Container(
//                             height: 7.h,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(50),
//                                 color: const Color.fromRGBO(242, 246, 248, 1)),
//                             child: TabBar(
//                               controller: _tabController,
//                               indicatorPadding:
//                                   EdgeInsets.symmetric(vertical: 0.8.h),
//                               tabAlignment: TabAlignment.center,
//                               dividerColor: ColorOnboarding.whiteColor,
//                               labelColor: Colors.black,
//                               labelStyle: GoogleFonts.openSans(
//                                   textStyle: TextStyle(
//                                       fontSize: 17.sp,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.normal)),
//                               unselectedLabelColor: ColorOnboarding.blackColor,
//                               indicator: ShapeDecoration(
//                                   color: ColorOnboarding.whiteColor,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(50))),
//                               tabs: [
//                                 Tab(
//                                   child: SizedBox(
//                                     width: 36.w,
//                                     child: Text(
//                                       'Sign In',
//                                       style: GoogleFonts.openSans(
//                                           textStyle: const TextStyle()),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                 ),
//                                 Tab(
//                                   child: SizedBox(
//                                     width: 36.w,
//                                     child: Text(
//                                       'Register',
//                                       style: GoogleFonts.openSans(
//                                           textStyle: const TextStyle()),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: TabBarView(
//                             controller: _tabController, children: [ SignInTab(), RegisterTab()],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
