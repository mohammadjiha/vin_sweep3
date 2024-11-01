import 'package:get/get.dart';

class HomeController extends GetxController {
  var email = 'No Email'.obs;
  var name = 'No Name'.obs;
  var zipCode = 0.obs;
  var isDialOpen = false.obs;

  void setUserData(Map<String, dynamic> userData) {
    email.value = userData['email'] ?? 'No Email';
    name.value = userData['name'] ?? 'No Name';
    zipCode.value = userData['zipCode'] ?? 0;
  }
  void toggleDial(){
    isDialOpen.value= !isDialOpen.value;
  }
}
