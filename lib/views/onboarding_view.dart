import 'package:fadingpageview/fadingpageview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/images.dart';
import 'package:telegram_prime/controllers/home_controller.dart';
import 'package:telegram_prime/services/navigator_key.dart';
import 'package:telegram_prime/views/premium_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  FadingPageViewController pageController = FadingPageViewController(0, 3);
  final controller = HomeController.instance;

  DateTime? lastTapTime;

  final contentBody = [
    {
      'image': onboarding1,
      'title': 'Manage Accounts',
      'description':
          'Easily manage and switch between multiple Telegram accounts on a single device.'
    },
    {
      'image': onboarding2,
      'title': 'Channels',
      'description':
          'Stay informed with exclusive updates, news, and content by joining Telechannels.'
    },
    {
      'image': onboarding3,
      'title': 'Bots',
      'description':
          'Unlock unique resources and valuable content by harnessing the power of Telebots.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FadingPageView(
              controller: pageController,
              disableWhileAnimating: true,
              fadeInDuration: const Duration(milliseconds: 250),
              fadeOutDuration: const Duration(milliseconds: 250),
              itemBuilder: (context, itemIndex) {
                return Column(children: [
                  SizedBox(
                    width: 375.w,
                    height: 190.h,
                    child: Image.asset(
                      itemIndex % 2 == 0 ? onboardingBg1 : onboardingBg2,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
                    child: Column(children: [
                      SizedBox(
                        width: 150.w,
                        height: 150.w,
                        child: Image.asset(
                          contentBody[itemIndex]['image']!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 55.h),
                      Text(
                        contentBody[itemIndex]['title']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        contentBody[itemIndex]['description']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: whiteColor,
                        ),
                      ),
                    ]),
                  )
                ]);
              }),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: SafeArea(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Obx(() {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.onboardingIndex == index
                            ? whiteColor
                            : whiteColor.withOpacity(.4),
                      ),
                    );
                  });
                }),
              ),
              SizedBox(height: 30.h),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(48),
                  color: primaryColor,
                ),
                child: ElevatedButton(
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: whiteColor,
                    ),
                  ),
                  onPressed: () {
                    final cTime = DateTime.now();
                    if (lastTapTime == null ||
                        cTime.difference(lastTapTime!) >
                            const Duration(milliseconds: 500)) {
                      lastTapTime = cTime;
                      // Your button action here
                      debugPrint("Button tapped");
                    } else {
                      debugPrint("Double tap detected - ignored");
                      return;
                    }

                    if (controller.onboardingIndex < 2) {
                      controller.onboardingIndex++;

                      pageController.next();
                    } else {
                      // LocalStorage.addData(isOnboardingDone, true);
                      NavigatorKey.pushReplacement(const PremiumView());
                    }
                  },
                ),
              )
            ]),
          ),
        )
      ]),
    );
  }
}
