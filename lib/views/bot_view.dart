import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:telegram_prime/components/bot_card.dart';
import 'package:telegram_prime/components/bot_details.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/controllers/home_controller.dart';
import 'package:telegram_prime/models/bot_model.dart';

class BotView extends StatefulWidget {
  const BotView({super.key});

  @override
  State<BotView> createState() => _BotViewState();
}

class _BotViewState extends State<BotView> {
  final controller = HomeController.instance;
  List<BotModel> filteredItems = <BotModel>[];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadBots();
  }

  Future loadBots() async {
    await controller.getBots();
    filteredItems = controller.bots;
  }

  void _filterList(String query) {
    setState(() {
      searchQuery = query;
      filteredItems = controller.bots
          .where((item) =>
              item.displayName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

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
            onChanged: _filterList,
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
        Obx(() {
          return controller.isLoadingBots
              ? const Expanded(
                  child: Center(
                    child: CupertinoActivityIndicator(color: whiteColor),
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 30.w, // Horizontal spacing
                        mainAxisSpacing: 30.h, // Vertical spacing
                        childAspectRatio: 1.5, // Aspect ratio of each item
                      ),
                      itemCount: filteredItems.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w), // Number of items
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              showAdaptiveDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return const BotDetails();
                                  });
                            },
                            child: const BotCard());
                      }),
                );
        }),
      ]),
    );
  }
}
