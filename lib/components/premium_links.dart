import 'package:flutter/material.dart';

class PremiumLinks extends StatelessWidget {
  const PremiumLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'Terms',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: Color(0xFFA7ABB1),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: CircleAvatar(
          radius: 2,
          backgroundColor: Color(0xFFA7ABB1),
        ),
      ),
      Text(
        'Privacy Policy',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: Color(0xFFA7ABB1),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: CircleAvatar(
          radius: 2,
          backgroundColor: Color(0xFFA7ABB1),
        ),
      ),
      Text(
        'Restore',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: Color(0xFFA7ABB1),
        ),
      ),
    ]);
  }
}
