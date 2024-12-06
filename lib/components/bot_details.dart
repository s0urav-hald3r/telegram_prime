import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/models/bot_model.dart';
import 'package:telegram_prime/services/navigator_key.dart';
import 'package:url_launcher/url_launcher.dart';

class BotDetails extends StatelessWidget {
  final BotModel botModel;
  const BotDetails({super.key, required this.botModel});

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
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: bgColor,
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      imageUrl: botModel.image ?? '',
                      fit: BoxFit.cover,
                    ),
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
            Text(
              botModel.displayName ?? 'NA',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 18, color: whiteColor),
            ),
            SizedBox(height: 8.h),
            Text(
              botModel.userName ?? 'NA',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
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
                  onPressed: () async {
                    await Share.share(
                        'Please check out this amazing Bot:\nhttps://t.me/${botModel.userName ?? ''}');
                  },
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
                      'Visit Bot',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final url =
                        Uri.parse('https://t.me/${botModel.userName ?? ''}');
                    try {
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    } catch (e) {
                      debugPrint('error while url launch: $e');
                    }
                  },
                ),
              ),
            ])
          ]),
        ),
      ),
    );
  }
}
