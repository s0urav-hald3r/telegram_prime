import 'package:flutter/material.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';

class ChannelCard extends StatelessWidget {
  final bool isPro;
  const ChannelCard({super.key, required this.isPro});

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
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color:
                          isPro ? primaryColor : primaryColor.withOpacity(.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    child: Text(
                      isPro ? 'Paid' : 'Free',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: isPro ? whiteColor : primaryColor,
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
