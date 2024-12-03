import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/constants.dart';
import 'package:telegram_prime/controllers/home_controller.dart';
import 'package:telegram_prime/services/local_storage.dart';
import 'package:telegram_prime/services/navigator_key.dart';
import 'package:telegram_prime/views/home_view.dart';
import 'package:telegram_prime/views/onboarding_view.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize storage
  await GetStorage.init();

  // Dependency injection
  Get.lazyPut(() => HomeController());

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: bgColor,
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            minimumSize: Size.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(48),
            ),
          ),
        ),
      ),
      navigatorKey: NavigatorKey.navigatorKey,
      home: LocalStorage.getData(isOnboardingDone, KeyType.BOOL)
          ? const HomeView()
          : const OnboardingView(),
    );
  }
}
