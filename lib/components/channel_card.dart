import 'package:flutter/material.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';

class ChannelCard extends StatelessWidget {
  const ChannelCard({super.key});

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
                  const CircleAvatar(radius: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(.5),
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
            const Text(
              'Netflix',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: whiteColor,
              ),
            ),
          ]),
    );
  }
}
