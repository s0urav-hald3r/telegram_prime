import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:telegram_prime/components/channel_card.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/controllers/home_controller.dart';

class ChannelView extends StatefulWidget {
  const ChannelView({super.key});

  @override
  State<ChannelView> createState() => _ChannelViewState();
}

class _ChannelViewState extends State<ChannelView> {
  final ScrollController _scrollController = ScrollController();
  final controller = HomeController.instance;

  @override
  void initState() {
    super.initState();
    controller.getChannels();
    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMore() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      controller.offset = controller.offset++;
      controller.getChannels(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Obx(() {
        return Column(children: [
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
          controller.isLoading
              ? const Expanded(
                  child: Center(
                    child: CupertinoActivityIndicator(color: whiteColor),
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10.w, // Horizontal spacing
                        mainAxisSpacing: 10.h, // Vertical spacing
                        childAspectRatio: 1.6, // Aspect ratio of each item
                      ),
                      itemCount: controller.channels.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w), // Number of items
                      itemBuilder: (context, index) {
                        print(controller.channels[index]);
                        return InkWell(
                          onTap: () {
                            // if (index % 3 == 0) {
                            //   showAdaptiveDialog(
                            //       context: context,
                            //       barrierDismissible: false,
                            //       builder: (context) {
                            //         return const UpgradePremium();
                            //       });
                            // } else {
                            //   NavigatorKey.push(const ChannelListView());
                            // }
                          },
                          child:
                              ChannelCard(channel: controller.channels[index]),
                        );
                      }),
                ),
          if (controller.isLoadingMore)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CupertinoActivityIndicator(color: whiteColor),
            )
        ]);
      }),
    );
  }
}
