import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/http_wrapper/current_session.dart';
import '../../../constvalue/onboarding_screen/onboarding_color.dart';
import '../../authentication/screens/sigin&register/widgets/buttoncheck.dart';
import '../../authentication/screens/sigin&register/widgets/itemtextfeild.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  static const String routName = 'ProfileScreen';

  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameControllerPrpfile = TextEditingController();
  final TextEditingController emailControllerPrpfile = TextEditingController();
  final TextEditingController zipCodeConControllerProfile = TextEditingController();
  final FocusNode fullNameFocusNodeProfile = FocusNode();
  final FocusNode emailFocusNodeProfile = FocusNode();
  final FocusNode zipCodeFocusNodeProfile = FocusNode();
  final ValueNotifier<Color> valueNotifierColorProfile = ValueNotifier(const Color.fromRGBO(242, 246, 248, 1));
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    var user = CurrentSession().getApiUser();
    if (user != null) {
      fullNameControllerPrpfile.text = user.user!.fullName ?? '';
      emailControllerPrpfile.text = user.user!.email ?? '';
      zipCodeConControllerProfile.text = user.user!.zipCode?.toString() ?? ''; // التأكد من تعيين الرمز البريدي بشكل صحيح
    }

    fullNameControllerPrpfile.addListener(_updateButtonColor);
    emailControllerPrpfile.addListener(_updateButtonColor);
    zipCodeConControllerProfile.addListener(_updateButtonColor);
  }

  void _updateButtonColor() {
    valueNotifierColorProfile.value =
    (fullNameControllerPrpfile.text.isNotEmpty &&
        emailControllerPrpfile.text.isNotEmpty &&
        zipCodeConControllerProfile.text.isNotEmpty)
        ? ColorOnboarding.pointSelected
        : const Color.fromRGBO(242, 246, 248, 1);
  }

  @override
  void dispose() {
    fullNameControllerPrpfile.dispose();
    emailControllerPrpfile.dispose();
    zipCodeConControllerProfile.dispose();
    fullNameFocusNodeProfile.dispose();
    emailFocusNodeProfile.dispose();
    zipCodeFocusNodeProfile.dispose();
    super.dispose();
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
                    'Profile',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorOnboarding.whiteColor
                        )
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'You can only edit your name and ZIP code',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                            color: ColorOnboarding.whiteColor
                        )
                    ),
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
                child: Image.asset('assets/images/ic-back.png')
            ),
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
                      ItemTextFeild(
                        nameImage: 'ic-name.png',
                        textTextFeild: 'Name',
                        isobscureText: false,
                        focusNode: fullNameFocusNodeProfile,
                        textEditingController: fullNameControllerPrpfile,
                      ),
                      SizedBox(height: 3.h),
                      ItemTextFeild(
                        nameImage: 'ic-mail.png',
                        textTextFeild: 'Email',
                        isobscureText: false,
                        focusNode: emailFocusNodeProfile,
                        textEditingController: emailControllerPrpfile,
                      ),
                      SizedBox(height: 3.h),
                      ItemTextFeild(
                        nameImage: 'ic-zip.png',
                        textTextFeild: 'ZipCode',
                        isobscureText: false,
                        focusNode: zipCodeFocusNodeProfile,
                        textEditingController: zipCodeConControllerProfile,
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (_validateFields()) {
                              _profileApi();
                            }
                          }
                        },
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : ValueListenableBuilder(
                          valueListenable: valueNotifierColorProfile,
                          builder: (BuildContext context, value, Widget? child) {
                            return ButtonCheck(
                              text: 'Save',
                              color: value,
                              textColor: value == ColorOnboarding.pointSelected
                                  ? ColorOnboarding.whiteColor
                                  : ColorOnboarding.subTextColor,
                            );
                          },
                        ),
                      ),
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

  bool _validateFields() {
    if (!_isValidName(fullNameControllerPrpfile.text)) {
      _showError("Full name must not contain special characters.");
      return false;
    }

    if (!_isValidZipCode(zipCodeConControllerProfile.text)) {
      _showError("Zip code must be exactly 5 digits.");
      return false;
    }

    if (!GetUtils.isEmail(emailControllerPrpfile.text)) {
      _showError("Invalid email format.");
      return false;
    }

    return true;
  }

  void _profileApi() async {
    setState(() {
      _isLoading = true;
    });

    final fullName = fullNameControllerPrpfile.text;
    final zipCode = zipCodeConControllerProfile.text;

    try {
      var accessToken = CurrentSession().getAccessToken() ?? '';
      var response = await http.post(
        Uri.parse('http://212.47.65.193:8888/api/v1/users/update'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'fullName': fullName,
          'zipCode': zipCode,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        var user = CurrentSession().getApiUser();
        if (user != null) {
          user.user!.fullName = fullName;
          user.user!.zipCode = int.tryParse(zipCode);
          CurrentSession().setApiUser(user);
        }

      } else {
        String errorMessage = jsonDecode(response.body)['message'] ?? 'Failed to update profile';
        Get.snackbar(
          'Error',
          errorMessage,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;

      });
    }
  }

  bool _isValidName(String name) {
    final regex = RegExp(r'^[a-zA-Z\s]+$');
    return regex.hasMatch(name);
  }

  bool _isValidZipCode(String zipCode) {
    return zipCode.length == 5 && int.tryParse(zipCode) != null;
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }
}
