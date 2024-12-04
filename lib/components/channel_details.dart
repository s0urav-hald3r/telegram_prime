import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/services/navigator_key.dart';

class ChannelDetails extends StatelessWidget {
  const ChannelDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Dialog(
        insetPadding: const EdgeInsets.all(16),
        backgroundColor: faddedBgColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  const CircleAvatar(
                    radius: 36,
                  ),
                  InkWell(
                    onTap: () {
                      NavigatorKey.pop();
                    },
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: bgColor,
                      child: SvgPicture.asset(cross),
                    ),
                  ),
                ]),
            SizedBox(height: 8.h),
            const Text(
              'Vevo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: whiteColor,
              ),
            ),
            SizedBox(height: 8.h),
            const Text(
              'Channel/Music',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFFA7ABB1),
              ),
            ),
            SizedBox(height: 8.h),
            const Text(
              '3.0K',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(0xFFA7ABB1),
              ),
            ),
            SizedBox(height: 20.h),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                width: 150.w,
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: whiteColor,
                ),
                child: ElevatedButton(
                  child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(shareBot),
                          SizedBox(width: 8.w),
                          const Text(
                            'Share',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: bgColor,
                            ),
                          ),
                        ]),
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                width: 150.w,
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: primaryColor,
                ),
                child: ElevatedButton(
                  child: const Center(
                    child: Text(
                      'Visit Channel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ])
          ]),
        ),
      ),
    );
  }
}
