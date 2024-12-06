import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telegram_prime/country_data.dart';
import 'package:telegram_prime/models/channel_model.dart';
import 'package:telegram_prime/services/dio_client.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final pageController = PageController();
  late WebViewController controller;

  final dio = DioClient();

  @override
  void onInit() {
    super.onInit();
    selectedCountry =
        '${countryData[0]['flag']}_${countryData[0]['name']}_${countryData[0]['dial_code']}';
  }

  final channelSearch = TextEditingController();

  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final messageController = TextEditingController();

  // Private variables
  final RxInt _homeIndex = 0.obs;
  final RxInt _offset = 0.obs;
  final RxInt _searchOffset = 0.obs;
  final RxInt _onboardingIndex = 0.obs;
  final RxBool _loadingWebView = true.obs;
  final RxBool _isQuery = false.obs;
  final RxBool _isLoading = true.obs;
  final RxBool _isLoadingMore = false.obs;
  final RxBool _isSearching = false.obs;
  final RxBool _isSearchingMore = false.obs;
  final RxString _selectedCountry = ''.obs;
  final RxList<ChannelModel> _channels = <ChannelModel>[].obs;
  final RxList<ChannelModel> _searchChannels = <ChannelModel>[].obs;

  // Getters
  int get homeIndex => _homeIndex.value;
  int get offset => _offset.value;
  int get searchOffset => _searchOffset.value;
  int get onboardingIndex => _onboardingIndex.value;
  bool get loadingWebView => _loadingWebView.value;
  bool get isQuery => _isQuery.value;
  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get isSearching => _isSearching.value;
  bool get isSearchingMore => _isSearchingMore.value;
  String get selectedCountry => _selectedCountry.value;
  List<ChannelModel> get channels => _channels;
  List<ChannelModel> get searchChannels => _searchChannels;

  // Setters
  set homeIndex(value) => _homeIndex.value = value;
  set offset(value) => _offset.value = value;
  set searchOffset(value) => _searchOffset.value = value;
  set onboardingIndex(value) => _onboardingIndex.value = value;
  set loadingWebView(bool status) => _loadingWebView.value = status;
  set isQuery(bool status) => _isQuery.value = status;
  set isLoading(value) => _isLoading.value = value;
  set isLoadingMore(value) => _isLoadingMore.value = value;
  set isSearching(value) => _isSearching.value = value;
  set isSearchingMore(value) => _isSearchingMore.value = value;
  set selectedCountry(value) => _selectedCountry.value = value;
  set channels(value) => _channels.value = value;
  set searchChannels(value) => _searchChannels.value = value;

  // APIs
  Future<void> getChannels({bool loadMore = false}) async {
    loadMore ? isLoadingMore = true : isLoading = true;
    try {
      final temp = <ChannelModel>[];
      final response =
          await dio.get('chart/all?limit=20&offset=${20 * offset}');

      for (var item in response.data) {
        temp.add(ChannelModel.fromJson(item));
      }

      loadMore ? isLoadingMore = false : isLoading = false;
      channels.addAll(temp);
    } catch (e, stack) {
      loadMore ? isLoadingMore = false : isLoading = false;
      debugPrint('error: $e');
      debugPrint('err-stack: $stack');
    }
  }

  Future<void> getSearchChannels({bool loadMore = false}) async {
    loadMore ? isSearchingMore = true : isSearching = true;
    try {
      final temp = <ChannelModel>[];
      final response = await dio.get(
          'chart/all?limit=20&offset=${20 * searchOffset}&q=${channelSearch.text.trim()}');

      for (var item in response.data) {
        temp.add(ChannelModel.fromJson(item));
      }

      loadMore ? isSearchingMore = false : isSearching = false;
      loadMore ? searchChannels.addAll(temp) : searchChannels = temp;
    } catch (e, stack) {
      loadMore ? isSearchingMore = false : isSearching = false;
      debugPrint('error: $e');
      debugPrint('err-stack: $stack');
    }
  }
}
