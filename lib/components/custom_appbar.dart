import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/services/navigator_key.dart';
import 'package:telegram_prime/views/premium_view.dart';
import 'package:telegram_prime/views/settings_view.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Default AppBar height

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: bgColor,
        leadingWidth: 44.w,
        leading: InkWell(
          onTap: () {
            NavigatorKey.push(const SettingsView());
          },
          child: Container(
            margin: EdgeInsets.only(left: 24.w),
            width: 20.w,
            child: SvgPicture.asset(
              settingIcon,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: const Text('Telegram Prime'),
        actions: [
          InkWell(
            onTap: () {
              NavigatorKey.push(const PremiumView());
            },
            child: Container(
              margin: EdgeInsets.only(right: 24.w),
              width: 24.w,
              child: SvgPicture.asset(
                premiumIcon,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ]);
  }
}
