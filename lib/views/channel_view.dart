import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:telegram_prime/components/channel_card.dart';
import 'package:telegram_prime/components/channel_details.dart';
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

  // Declare a debounce timer
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    if (controller.channels.isEmpty) controller.getChannels();
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
      if (controller.isQuery) {
        controller.searchOffset = ++controller.searchOffset;
        controller.getSearchChannels(loadMore: true);
      } else {
        controller.offset = ++controller.offset;
        controller.getChannels(loadMore: true);
      }
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
              controller: controller.channelSearch,
              // Inside your widget
              onChanged: (value) {
                controller.isQuery = value.isNotEmpty;

                // Cancel the previous timer if it exists
                if (_debounce?.isActive ?? false) _debounce!.cancel();

                // Set up a new timer
                _debounce = Timer(const Duration(milliseconds: 300), () {
                  if (controller.isQuery) {
                    controller.getSearchChannels();
                  }
                });
              },
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
          controller.isLoading || controller.isSearching
              ? const Expanded(
                  child: Center(
                    child: CupertinoActivityIndicator(color: whiteColor),
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width > 780
                            ? 3
                            : 2, // Number of columns
                        crossAxisSpacing: 10.w, // Horizontal spacing
                        mainAxisSpacing: 10.h, // Vertical spacing
                        childAspectRatio: 1.6, // Aspect ratio of each item
                      ),
                      itemCount: controller.isQuery
                          ? controller.searchChannels.length
                          : controller.channels.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w), // Number of items
                      itemBuilder: (context, index) {
                        final channel = controller.isQuery
                            ? controller.searchChannels[index]
                            : controller.channels[index];

                        return InkWell(
                          onTap: () {
                            showAdaptiveDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return ChannelDetails(channel: channel);
                                });
                          },
                          child: ChannelCard(channel: channel),
                        );
                      }),
                ),
          if (controller.isLoadingMore || controller.isSearchingMore)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CupertinoActivityIndicator(color: whiteColor),
            )
        ]);
      }),
    );
  }
}
