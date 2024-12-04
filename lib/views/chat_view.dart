import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/controllers/home_controller.dart';
import 'package:telegram_prime/services/navigator_key.dart';
import 'package:telegram_prime/views/select_country_view.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView(children: [
        SizedBox(height: 20.h),
        SvgPicture.asset(chatLogo),
        SizedBox(height: 20.h),
        const Text(
          'Direct Chat',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: whiteColor,
          ),
        ),
        SizedBox(height: 20.h),
        const Text(
          'Choose your country code and enter your Telegram number or username',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Color(0xFFA7ABB1),
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          height: 45.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: CupertinoTextField(
            controller: controller.numberController,
            decoration: BoxDecoration(
              color: faddedBgColor,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.only(left: 0.w),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: whiteColor,
            ),
            placeholder: 'Enter Mobile Number',
            keyboardType: TextInputType.number,
            placeholderStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFFA7ABB1),
            ),
            prefix: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                NavigatorKey.push(const SelectCountryView());
              },
              child: Obx(() {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    '${controller.selectedCountry.split('_')[0]} ${controller.selectedCountry.split('_')[2]} ▾',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: whiteColor,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(height: 15.h),
        Container(
          height: 45.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: CupertinoTextField(
            controller: controller.nameController,
            decoration: BoxDecoration(
              color: faddedBgColor,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.only(left: 16.w),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: whiteColor,
            ),
            placeholder: 'Enter Username',
            keyboardType: TextInputType.name,
            placeholderStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFFA7ABB1),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
          child: CupertinoTextField(
            controller: controller.messageController,
            decoration: BoxDecoration(
              color: faddedBgColor,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: whiteColor,
            ),
            placeholder: 'Enter your message...\n\n\n\n',
            keyboardType: TextInputType.multiline,
            placeholderStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFFA7ABB1),
            ),
            maxLines: 5,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 52,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: primaryColor,
          ),
          child: ElevatedButton(
            child: const Text(
              'Send Message',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ]),
    );
  }
}
