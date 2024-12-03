import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telegram_prime/components/premium_appbar.dart';
import 'package:telegram_prime/components/premium_links.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/config/images.dart';

class PremiumView extends StatelessWidget {
  const PremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(children: [
          Image.asset(premiumBg),
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  bgColor.withOpacity(.05),
                  bgColor.withOpacity(.95),
                  bgColor,
                  bgColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SizedBox(
            width: size.width,
            height: size.height,
            child: SafeArea(
              child: Column(children: [
                const PremiumAppBar(),
                const Spacer(),
                SvgPicture.asset(premiumLogo),
                SizedBox(height: 16.h),
                const Text(
                  'Get Premium Membership',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                  ),
                ),
                SizedBox(height: 16.h),
                const Text(
                  ' Unlock Full access, Claim This Offer now & Unlock Exclusive Features Today!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFA7ABB1),
                  ),
                ),
                SizedBox(height: 16.h),
                const Text(
                  '₹399/month',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 4.h),
                const Text(
                  'Billed yearly',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: whiteColor,
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: primaryColor,
                  ),
                  child: ElevatedButton(
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(verified),
                        SizedBox(width: 8.w),
                        const Text(
                          'No Payment Now',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: whiteColor,
                          ),
                        )
                      ]),
                ),
                const PremiumLinks(),
                SizedBox(height: 8.h)
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
