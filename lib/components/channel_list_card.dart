import 'package:flutter/material.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';

class ChannelListCard extends StatelessWidget {
  const ChannelListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      decoration: BoxDecoration(
        color: faddedBgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(children: [
        const CircleAvatar(radius: 24),
        SizedBox(width: 16.w),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Vevo',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: whiteColor,
            ),
          ),
          SizedBox(height: 4.h),
          Row(children: [
            SizedBox(width: 4.w),
            const Text(
              '9,180',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Color(0xFFA7ABB1),
              ),
            ),
          ])
        ])
      ]),
    );
  }
}
