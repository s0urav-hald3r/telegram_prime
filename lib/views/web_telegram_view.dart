import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/controllers/home_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebTelegramView extends StatefulWidget {
  const WebTelegramView({super.key});

  @override
  State<WebTelegramView> createState() => _WebTelegramViewState();
}

class _WebTelegramViewState extends State<WebTelegramView> {
  late WebViewController controller;
  final homeController = HomeController.instance;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(bgColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            homeController.loadingWebView = progress != 100;
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://web.telegram.org/'));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.loadingWebView) {
        return const Center(
          child: CupertinoActivityIndicator(color: whiteColor),
        );
      }
      return WebViewWidget(controller: controller);
    });
  }
}
