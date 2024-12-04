import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telegram_prime/components/channel_card.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/services/navigator_key.dart';
import 'package:telegram_prime/views/channel_list_view.dart';

class ChannelView extends StatelessWidget {
  const ChannelView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10.w, // Horizontal spacing
                mainAxisSpacing: 10.h, // Vertical spacing
                childAspectRatio: 1.6, // Aspect ratio of each item
              ),
              itemCount: 21,
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w), // Number of items
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      if (index % 3 == 0) {
                      } else {
                        NavigatorKey.push(const ChannelListView());
                      }
                    },
                    child: ChannelCard(isPro: index % 3 == 0));
              }),
        )
      ]),
    );
  }
}
