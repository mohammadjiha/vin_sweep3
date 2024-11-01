import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/constvalue/onboarding_screen/onboarding_color.dart';
import 'package:vin_sweep/features/authentication/screens/forgot/screen/forgotscreen.dart';
import '../controller/sigin_controller.dart';
import 'buttoncheck.dart';

class SignInTab extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.put(LoginController());

  SignInTab({super.key}) {
    loginController.loadUserCredentials().then((_) {
      emailController.text = loginController.email ?? '';
      passwordController.text = loginController.password ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          _buildTextField(
            label: 'Email',
            controller: emailController,
            iconPath: 'assets/images/ic-mail.png',
            isPassword: false,
          ),
          const SizedBox(height: 16),
          _buildPasswordField(),
          const SizedBox(height: 16),
          _buildRememberMeAndForgotPassword(),
          SizedBox(height: 10.h),
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String iconPath,
    required bool isPassword,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(iconPath),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 15.sp,
                  color: ColorOnboarding.subTextColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(248, 250, 252, 1),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: ColorOnboarding.whiteColor,
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
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    final RxBool isPasswordVisible = false.obs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset('assets/images/ic-pass2.png'),
            const SizedBox(width: 8),
            Text(
              'Password',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 15.sp,
                  color: ColorOnboarding.subTextColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Obx(() {
          return TextField(
            controller: passwordController,
            obscureText: !isPasswordVisible.value,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(248, 250, 252, 1),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: ColorOnboarding.whiteColor,
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
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: ColorOnboarding.subTextColor,
                ),
                onPressed: () {
                  isPasswordVisible.value = !isPasswordVisible.value;
                },
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildRememberMeAndForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Obx(() {
              return Checkbox(
                side: const BorderSide(color: ColorOnboarding.subTextColor,width: 1,),
                activeColor: ColorOnboarding.pointSelected,
                checkColor:ColorOnboarding.whiteColor ,
                value: loginController.isRememberMe.value,
                onChanged: (value) {
                  loginController.isRememberMe.value = value!;

                  if (value) {
                    loginController.saveUserCredentials(
                      emailController.text,
                      passwordController.text,
                    );
                  } else {
                    loginController.clearUserCredentials();
                  }
                },
              );
            }),
            Text(
              'Remember me',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  color: ColorOnboarding.subTextColor,
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(ForgotScreen.routName);
          },
          child: Text(
            'Forgot Password?',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 16.sp,
                color: const Color.fromRGBO(0, 147, 255, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Obx(() {
      return loginController.isLoading.value
          ? const CircularProgressIndicator()
          : GestureDetector(
        onTap: () {
          loginController.login(
            emailController.text,
            passwordController.text,
          );
        },
        child: const ButtonCheck(
          text: 'Login',
          color: ColorOnboarding.pointSelected,
          textColor: ColorOnboarding.whiteColor,
        ),
      );
    });
  }
}
