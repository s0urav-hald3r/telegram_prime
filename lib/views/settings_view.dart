import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telegram_prime/components/action_button.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: bgColor,
          iconTheme: const IconThemeData(color: whiteColor),
          title: const Text('Settings'),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 24.w),
              width: 24.w,
              child: SvgPicture.asset(
                premiumIcon,
                fit: BoxFit.contain,
              ),
            ),
          ]),
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
          const Text(
            '₹1,999/year',
            style: TextStyle(
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
            child: ElevatedButton(
              child: const Text(
                'Get Premium',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: whiteColor,
                ),
              ),
              onPressed: () {},
            ),
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
