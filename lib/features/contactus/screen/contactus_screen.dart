import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vin_sweep/features/contactus/widget/container_contactus.dart';
import 'package:vin_sweep/features/contactus/widget/container_social.dart';

import '../../../constvalue/onboarding_screen/onboarding_color.dart';

class ContactusScreen extends StatefulWidget {
  static const String routName = 'ContactusScreen';

  const ContactusScreen({super.key});

  @override
  ContactusScreenState createState() => ContactusScreenState();
}

class ContactusScreenState extends State<ContactusScreen> {
  final _formKey = GlobalKey<FormState>();
  final String phoneNumber = '+962796592789';
  final String email = 'mohammadhindy2020@gmail.com';
  final String instagramUrl = 'https://www.instagram.com/mohammad_ji02/';
  final String facebookUrl = 'https://www.facebook.com/profile.php?id=100004205232406&locale=ar_AR';


  Future<void> _launchWhatsAppChat() async {
    final url = Uri.parse('https://wa.me/$phoneNumber');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  Future<void> _makePhoneCall() async {
    final url = Uri.parse('tel:$phoneNumber');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
      await Clipboard.setData(ClipboardData(text: phoneNumber));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Phone number has been copied to clipboard'),
      ));
    } catch (e) {
      print("Error launching phone call: $e");
    }
  }
  Future<void> _openEmailApp() async {
    final url = Uri.parse('mailto:$email');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }

      await Clipboard.setData(ClipboardData(text: email));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email has been copied to clipboard'),
      ));
    } catch (e) {
      print("Error launching email: $e");
    }
  }
  Future<void> _openInstagram() async {
    final url = Uri.parse(instagramUrl);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }

      await Clipboard.setData(ClipboardData(text: instagramUrl));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Instagram link has been copied to clipboard'),
      ));
    } catch (e) {
      print("Error launching Instagram: $e");
    }
  }
  Future<void> _openFacebook() async {
    final url = Uri.parse(facebookUrl);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }

      await Clipboard.setData(ClipboardData(text: facebookUrl));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Facebo ok link has been copied to clipboard'),
      ));
    } catch (e) {
      print("Error launching Facebook: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorOnboarding.whiteColor,
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
              padding: EdgeInsets.only(left: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  Text(
                    'Contact Us',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorOnboarding.whiteColor)),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Please select the suitable way for you to reach us.',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                            color: ColorOnboarding.whiteColor)),
                  ),
                ],
              ),
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset('assets/images/ic-back.png')),
          ),
          Positioned(
            top: 25.h,
            left: 0,
            right: 0,
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 4.h),
                      GestureDetector(
                        onTap: _makePhoneCall,
                        child: const ContainerContactUs(
                            nameImageContactUs: 'ic -contact us.png',
                            textContactUs: 'Call Us'),
                      ),
                      SizedBox(height: 2.h),
                      GestureDetector(
                        onTap:
                          _launchWhatsAppChat,
                        child: const ContainerContactUs(
                            nameImageContactUs: 'Whatsapp icon.png',
                            textContactUs: 'Whatsapp'),
                      ),
                      SizedBox(height: 2.h),
                      GestureDetector(
                        onTap: _openEmailApp,
                        child: const ContainerContactUs(
                            nameImageContactUs: 'ic-mail2.png',
                              textContactUs: 'Email'),
                      ),
                      SizedBox(height: 2.h),
                      const ContainerContactUs(
                          nameImageContactUs: 'ic-website.png',
                          textContactUs: 'Website'),
                      SizedBox(height: 7.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap:  _openInstagram,
                              child: const ContainerSocial(imageSocial: 'ic-instagram.png')),
                          SizedBox(width: 4.w,),
                          const ContainerSocial(imageSocial: 'ic-tiktok.png'),
                          SizedBox(width: 4.w,),
                          const ContainerSocial(imageSocial: 'Twitter X.png'),
                          SizedBox(width: 4.w,),
                          GestureDetector(
                              onTap: _openFacebook,
                              child: const ContainerSocial(imageSocial: 'c-facebook.png')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
