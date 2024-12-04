import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final messageController = TextEditingController();

  final searchController = TextEditingController();

  // Private variables
  final RxInt _homeIndex = 0.obs;
  final RxInt _onboardingIndex = 0.obs;
  final RxBool _loadingWebView = true.obs;

  // Getters
  int get homeIndex => _homeIndex.value;
  int get onboardingIndex => _onboardingIndex.value;
  bool get loadingWebView => _loadingWebView.value;

  // Setters
  set homeIndex(value) => _homeIndex.value = value;
  set onboardingIndex(value) => _onboardingIndex.value = value;
  set loadingWebView(bool status) => _loadingWebView.value = status;
}
