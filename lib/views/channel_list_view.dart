import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telegram_prime/components/back_appbar.dart';
import 'package:telegram_prime/components/channel_details.dart';
import 'package:telegram_prime/components/channel_list_card.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';

class ChannelListView extends StatelessWidget {
  const ChannelListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbar(title: 'Music'),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Container(
            height: 45.h,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: CupertinoTextField(
              decoration: BoxDecoration(
                color: faddedBgColor,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.only(left: 0.w),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: whiteColor,
              ),
              placeholder: 'Search',
              keyboardType: TextInputType.text,
              placeholderStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFFA7ABB1),
              ),
              prefix: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SvgPicture.asset(search),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(
                itemCount: 9,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        showAdaptiveDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return const ChannelDetails();
                            });
                      },
                      child: const ChannelListCard());
                }),
          )
        ]),
      ),
    );
  }
}
