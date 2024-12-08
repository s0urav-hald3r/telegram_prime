import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/models/bot_model.dart';

class BotCard extends StatelessWidget {
  final BotModel botModel;
  const BotCard({super.key, required this.botModel});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: CachedNetworkImage(
          imageUrl: botModel.image ?? '',
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(height: 10.h),
      Text(
        botModel.displayName ?? 'NA',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
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
        Text(
          botModel.userName ?? 'NA',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 11,
            color: Color(0xFFA7ABB1),
          ),
        )
      ])
    ]);
  }
}
