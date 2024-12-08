import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:telegram_prime/components/action_button.dart';
import 'package:telegram_prime/components/back_appbar.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/constants.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/controllers/settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;

    StoreProduct monthly = controller.storeProduct
        .firstWhere((element) => element.identifier == monthlyPlan);

    return Scaffold(
      appBar: const BackAppbar(title: 'Settings'),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          SizedBox(height: 20.h),
          SvgPicture.asset(premiumLogo),
          SizedBox(height: 20.h),
          const Text(
            'Upgrade to Premium',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: whiteColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${monthly.priceString}/month',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: whiteColor,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 52,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: primaryColor,
            ),
            child: Obx(() {
              return ElevatedButton(
                child: Text(
                  controller.isPremium ? 'Subscribed' : 'Continue ≻',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: whiteColor,
                  ),
                ),
                onPressed: () {
                  if (controller.isPremium) {
                    null;
                  } else {
                    controller.purchaseProduct(monthly);
                  }
                },
              );
            }),
          ),
          const ActionButton(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 52,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: faddedBgColor,
            ),
            child: ElevatedButton(
              child: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SvgPicture.asset(cloud),
                  SizedBox(width: 10.w),
                  const Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: whiteColor,
                    ),
                  ),
                ]),
              ),
              onPressed: () {},
            ),
          ),
        ]),
      ),
    );
  }
}
