import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  // Private variables
  final RxInt _homeIndex = 0.obs;
  final RxInt _onboardingIndex = 0.obs;

  // Getters
  int get homeIndex => _homeIndex.value;
  int get onboardingIndex => _onboardingIndex.value;

  // Setters
  set homeIndex(value) => _homeIndex.value = value;
  set onboardingIndex(value) => _onboardingIndex.value = value;
}
