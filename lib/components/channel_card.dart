import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/models/channel_model.dart';

class ChannelCard extends StatelessWidget {
  final ChannelModel channel;
  const ChannelCard({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: faddedBgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(imageUrl: channel.image ?? ''),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    child: const Text(
                      'Free',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ]),
            Text(
              channel.tName ?? 'NA',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: whiteColor,
              ),
            ),
          ]),
    );
  }
}
