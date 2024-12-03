import 'package:flutter/material.dart';
import 'package:telegram_prime/components/custom_appbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(),
    );
  }
}
