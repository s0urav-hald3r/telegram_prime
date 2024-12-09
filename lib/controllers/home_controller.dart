import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:telegram_prime/config/constants.dart';
import 'package:telegram_prime/country_data.dart';
import 'package:telegram_prime/models/bot_model.dart';
import 'package:telegram_prime/models/channel_model.dart';
import 'package:telegram_prime/services/dio_client.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final RxBool _isLoading = false.obs;
  final RxBool _isLoadingMore = false.obs;
  final RxBool _isLoadingBots = false.obs;
  final RxBool _isLoadingMoreBots = false.obs;
  final RxBool _isSearching = false.obs;
  final RxBool _isSearchingMore = false.obs;
  final RxString _selectedCountry = ''.obs;
  final RxString _lastBotId = ''.obs;
  final RxList<ChannelModel> _channels = <ChannelModel>[].obs;
  final RxList<ChannelModel> _searchChannels = <ChannelModel>[].obs;
  final RxList<BotModel> _bots = <BotModel>[].obs;

  // Getters
  int get homeIndex => _homeIndex.value;
  int get offset => _offset.value;
  int get searchOffset => _searchOffset.value;
  int get onboardingIndex => _onboardingIndex.value;
  bool get loadingWebView => _loadingWebView.value;
  bool get isQuery => _isQuery.value;
  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get isLoadingBots => _isLoadingBots.value;
  bool get isLoadingMoreBots => _isLoadingMoreBots.value;
  bool get isSearching => _isSearching.value;
  bool get isSearchingMore => _isSearchingMore.value;
  String get selectedCountry => _selectedCountry.value;
  String get lastBotId => _lastBotId.value;
  List<ChannelModel> get channels => _channels;
  List<ChannelModel> get searchChannels => _searchChannels;
  List<BotModel> get bots => _bots;

  // Setters
  set homeIndex(value) => _homeIndex.value = value;
  set offset(value) => _offset.value = value;
  set searchOffset(value) => _searchOffset.value = value;
  set onboardingIndex(value) => _onboardingIndex.value = value;
  set loadingWebView(bool status) => _loadingWebView.value = status;
  set isQuery(bool status) => _isQuery.value = status;
  set isLoading(value) => _isLoading.value = value;
  set isLoadingMore(value) => _isLoadingMore.value = value;
  set isLoadingBots(value) => _isLoadingBots.value = value;
  set isLoadingMoreBots(value) => _isLoadingMoreBots.value = value;
  set isSearching(value) => _isSearching.value = value;
  set isSearchingMore(value) => _isSearchingMore.value = value;
  set selectedCountry(value) => _selectedCountry.value = value;
  set lastBotId(value) => _lastBotId.value = value;
  set channels(value) => _channels.value = value;
  set searchChannels(value) => _searchChannels.value = value;
  set bots(value) => _bots.value = value;

  // APIs
  Future<void> getChannels({bool loadMore = false}) async {
    if (isLoading) return;

    loadMore ? isLoadingMore = true : isLoading = true;
    try {
      final temp = <ChannelModel>[];
      final response = await dio
          .get('${channelUrl}chart/all?limit=20&offset=${20 * offset}');

      for (var item in response.data) {
        temp.add(ChannelModel.fromJson(item));
      }

      loadMore ? isLoadingMore = false : isLoading = false;
      loadMore ? channels.addAll(temp) : channels = temp;
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
          '${channelUrl}chart/all?limit=20&offset=${20 * searchOffset}&q=${channelSearch.text.trim()}');

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

  Future<void> getBots({bool loadMore = false}) async {
    if (isLoadingBots) return;

    loadMore ? isLoadingMoreBots = true : isLoadingBots = true;
    try {
      final temp = <BotModel>[];
      Response response;
      if (lastBotId.isEmpty) {
        response = await dio.get('${botUrl}bots');
      } else {
        response = await dio.get('${botUrl}bots?cursor=$lastBotId');
      }

      for (var item in response.data['data']) {
        temp.add(BotModel.fromJson(item));
      }
      lastBotId = temp.last.id;

      loadMore ? isLoadingMoreBots = false : isLoadingBots = false;
      loadMore ? bots.addAll(temp) : bots = temp;
    } catch (e, stack) {
      loadMore ? isLoadingMoreBots = false : isLoadingBots = false;
      debugPrint('error: $e');
      debugPrint('err-stack: $stack');
    }
  }

  Future<void> sendMessage() async {
    Uri url;
    if (numberController.text.isNotEmpty) {
      url = Uri.parse(
          'https://t.me/${selectedCountry.split('_')[2]}${numberController.text}?text=${messageController.text}');
    } else {
      url = Uri.parse(
          'https://t.me/${nameController.text}?text=${messageController.text}');
    }
    try {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('error while url launch: $e');
    }
  }
}
