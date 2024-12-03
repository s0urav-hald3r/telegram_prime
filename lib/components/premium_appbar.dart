import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/services/navigator_key.dart';
import 'package:telegram_prime/views/home_view.dart';

class PremiumAppBar extends StatelessWidget {
  const PremiumAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
          onTap: () {
            NavigatorKey.pushAndRemoveUntil(const HomeView());
          },
          child: SvgPicture.asset(closeIcon),
        ),
        InkWell(
          onTap: () {
            NavigatorKey.pushAndRemoveUntil(const HomeView());
          },
          child: Container(
            width: 60.w,
            height: 28.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: whiteColor,
            ),
            child: const Center(
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: bgColor,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
