import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  void nextPage() {
    if (currentPage.value < 2) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  void skip() {
    currentPage.value = 2;
  }
}