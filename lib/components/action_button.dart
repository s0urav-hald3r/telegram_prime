import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(children: [
            Expanded(
              child: _actionCard(
                rate,
                'Rate This App',
                const Color(0xFFF15757),
                () {},
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _actionCard(
                share,
                'Share This App',
                const Color(0xFF00C979),
                () {},
              ),
            )
          ]),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(children: [
            Expanded(
              child: _actionCard(
                privacy,
                'Privacy Policy',
                const Color(0xFFF0A059),
                () {},
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _actionCard(
                terms,
                'Terms of Use',
                const Color(0xFF7A65FE),
                () {},
              ),
            )
          ]),
        ),
      ]),
    );
  }

  Widget _actionCard(String icon, String title, Color bg, Function callBack) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 64.h,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(icon),
            ),
          ),
          SizedBox(width: 15.w),
          SizedBox(
            width: 60.w,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: whiteColor,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
