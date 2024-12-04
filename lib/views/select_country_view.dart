import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:telegram_prime/components/back_appbar.dart';
import 'package:telegram_prime/config/colors.dart';
import 'package:telegram_prime/config/extension.dart';
import 'package:telegram_prime/config/icons.dart';
import 'package:telegram_prime/controllers/home_controller.dart';
import 'package:telegram_prime/country_data.dart';
import 'package:telegram_prime/services/navigator_key.dart';

class SelectCountryView extends StatefulWidget {
  const SelectCountryView({super.key});

  @override
  State<SelectCountryView> createState() => _SelectCountryViewState();
}

class _SelectCountryViewState extends State<SelectCountryView> {
  final controller = HomeController.instance;
  List<Map<String, dynamic>> filteredItems = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredItems = countryData; // Initially display all items
  }

  void _filterList(String query) {
    setState(() {
      searchQuery = query;
      filteredItems = countryData
          .where((item) =>
              item['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbar(title: 'Select Country'),
      body: Column(children: [
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
            placeholder: 'Search Country',
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
        SizedBox(height: 10.h),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Row(children: [
                  Container(
                    width: 30.w,
                    height: 30.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: faddedBgColor,
                    ),
                    child: Center(
                      child: Text(
                        filteredItems[index]['flag'],
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            filteredItems[index]['name'],
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: whiteColor,
                            ),
                          ),
                        ),
                        Text(
                          filteredItems[index]['dial_code'],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFA7ABB1),
                          ),
                        ),
                      ]),
                  const Spacer(),
                  Obx(() {
                    return SizedBox(
                      width: 30,
                      height: 30,
                      child: Radio<String>.adaptive(
                        value:
                            '${countryData[index]['flag']}_${countryData[index]['name']}_${countryData[index]['dial_code']}',
                        groupValue: controller.selectedCountry,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          controller.selectedCountry = value;
                          NavigatorKey.pop();
                        },
                      ),
                    );
                  }),
                ]),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                indent: 16.w,
                endIndent: 16.w,
                height: 1.h,
                color: whiteColor.withOpacity(.1),
              );
            },
            itemCount: filteredItems.length,
          ),
        )
      ]),
    );
  }
}
