import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telegram_prime/country_data.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    selectedCountry =
        '${countryData[0]['flag']}_${countryData[0]['name']}_${countryData[0]['dial_code']}';
  }

  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final messageController = TextEditingController();

  final searchController = TextEditingController();

  // Private variables
  final RxInt _homeIndex = 0.obs;
  final RxInt _onboardingIndex = 0.obs;
  final RxBool _loadingWebView = true.obs;
  final RxString _selectedCountry = ''.obs;

  // Getters
  int get homeIndex => _homeIndex.value;
  int get onboardingIndex => _onboardingIndex.value;
  bool get loadingWebView => _loadingWebView.value;
  String get selectedCountry => _selectedCountry.value;

  // Setters
  set homeIndex(value) => _homeIndex.value = value;
  set onboardingIndex(value) => _onboardingIndex.value = value;
  set loadingWebView(bool status) => _loadingWebView.value = status;
  set selectedCountry(value) => _selectedCountry.value = value;
}
