import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/config/images.dart';

class BotCard extends StatelessWidget {
  const BotCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(onboarding3),
          ),
        ),
      ),
      SizedBox(height: 10.h),
      const Text(
        'Netflix',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: whiteColor,
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: 12,
          height: 12,
          child: SvgPicture.asset(bot),
        ),
        SizedBox(width: 4.w),
        const Text(
          'I am a bot',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 11,
            color: Color(0xFFA7ABB1),
          ),
        )
      ])
    ]);
  }
}
