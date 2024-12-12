import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/controllers/home_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebTelegramView extends StatefulWidget {
  const WebTelegramView({super.key});

  @override
  State<WebTelegramView> createState() => _WebTelegramViewState();
}

class _WebTelegramViewState extends State<WebTelegramView>
    with AutomaticKeepAliveClientMixin<WebTelegramView> {
  final homeController = HomeController.instance;

  @override
  void initState() {
    super.initState();

    homeController.controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(bgColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            homeController.loadingWebView = progress != 100;
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if (url.contains('web.telegram.org')) {
              // homeController.controller.runJavaScript("""
              //   function waitForElement(selector, callback) {
              //     const interval = setInterval(() => {
              //       const element = document.querySelector(selector);
              //       if (element) {
              //         clearInterval(interval);
              //         callback(element);
              //       }
              //     }, 0); // Check every 100ms
              //   }

              //   waitForElement('.ripple-container', (element) => {
              //     const event = new MouseEvent('click', { bubbles: true, cancelable: true });
              //     element.dispatchEvent(event);
              //   });
              // """);
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setUserAgent(
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36",
      )
      ..loadRequest(Uri.parse('https://web.telegram.org'));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required when using AutomaticKeepAliveClientMixin
    return Obx(() {
      if (homeController.loadingWebView) {
        return const Center(
          child: CupertinoActivityIndicator(color: whiteColor),
        );
      }
      return WebViewWidget(
        controller: homeController.controller,
        key: const PageStorageKey('web_telegram_view'),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
