import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:telegram_prime/components/custom_appbar.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/controllers/home_controller.dart';
import 'package:telegram_prime/views/bot_view.dart';
import 'package:telegram_prime/views/channel_view.dart';
import 'package:telegram_prime/views/chat_view.dart';
import 'package:telegram_prime/views/web_telegram_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    final controller = HomeController.instance;

    return Obx(() {
      return Scaffold(
          backgroundColor: bgColor,
          resizeToAvoidBottomInset: false,
          appBar: CustomAppbar(
              title: [
            'Tele Prime',
            'Tele Channels',
            'Tele Bots',
            'Direct Chat'
          ][controller.homeIndex]),
          body: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                WebTelegramView(),
                ChannelView(),
                BotView(),
                ChatView()
              ]),
          bottomNavigationBar: Container(
            height: 60 + bottomPadding,
            padding: EdgeInsets.fromLTRB(0, 10, 0, bottomPadding),
            color: faddedBgColor,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(0, home, 'Dual', () {
                    controller.homeIndex = 0;
                    controller.pageController.jumpToPage(0);
                  }),
                  _navItem(1, channel, 'Channel', () {
                    controller.homeIndex = 1;
                    controller.pageController.jumpToPage(1);
                  }),
                  _navItem(2, bot, 'Bots', () {
                    controller.homeIndex = 2;
                    controller.pageController.jumpToPage(2);
                  }),
                  _navItem(3, chat, 'Chat', () {
                    controller.numberController.clear();
                    controller.nameController.clear();
                    controller.messageController.clear();
                    controller.homeIndex = 3;
                    controller.pageController.jumpToPage(3);
                  }),
                ]),
          ));
    });
  }

  Widget _navItem(int index, String icon, String title, Function callBack) {
    return InkWell(
      onTap: () {
        callBack();
      },
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(
          icon,
          color: HomeController.instance.homeIndex == index
              ? whiteColor
              : const Color(0xFFA7ABB1),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: HomeController.instance.homeIndex == index
                ? whiteColor
                : const Color(0xFFA7ABB1),
          ),
        )
      ]),
    );
  }
}
