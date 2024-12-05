import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/services/navigator_key.dart';

class UpgradePremium extends StatelessWidget {
  const UpgradePremium({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Dialog(
        insetPadding: const EdgeInsets.all(16),
        backgroundColor: primaryColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 28),
                  SvgPicture.asset(upgradePremium),
                  InkWell(
                    onTap: () {
                      NavigatorKey.pop();
                    },
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: whiteColor.withOpacity(.3),
                      child: SvgPicture.asset(cross),
                    ),
                  ),
                ]),
            SizedBox(height: 10.h),
            const Text(
              'Upgrade to Premium',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: whiteColor,
              ),
            ),
            SizedBox(height: 10.h),
            const Text(
              '₹1,999/year',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: whiteColor,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 54.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: whiteColor,
              ),
              child: ElevatedButton(
                child: const Center(
                  child: Text(
                    'Get Premium',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
