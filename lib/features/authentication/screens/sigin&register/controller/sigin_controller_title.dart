import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignInControllerTitle extends GetxController {
  RxDouble height = 35.0.h.obs;
  RxString title = 'Login'.obs;
  RxString description = 'Please enter your credentials below'.obs;
  RxDouble heightBoxSize = 25.0.h.obs;

  @override
  void onInit() {
    super.onInit();
    everAll([height, title, description, heightBoxSize], (_) {
    });
  }

  void updateValues(int index) {
    if (index == 1) {
      height.value = 20.0.h;
      title.value = 'Create your Account';
      description.value = 'Please fill your information below';
      heightBoxSize.value = 10.0.h;
    } else {
      height.value = 35.0.h;
      title.value = 'Login';
      description.value = 'Please enter your credentials below';
      heightBoxSize.value = 25.0.h;
    }
  }
}
