import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/controllers/settings_controller.dart';
import 'package:telegram_prime/services/navigator_key.dart';
import 'package:telegram_prime/views/premium_view.dart';

class BackAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const BackAppbar({super.key, required this.title});

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
            NavigatorKey.pop();
          },
          child: Container(
            margin: EdgeInsets.only(left: 24.w),
            width: 20.w,
            child: SvgPicture.asset(
              arrowLeft,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(title),
        actions: [
          if (!SettingsController.instance.isPremium)
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
