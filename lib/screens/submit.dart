import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Submit extends StatelessWidget {
  const Submit({super.key});

  static Color colorFromHex(String colorCode) {
    final hexCode = colorCode.replaceAll('#', '');
    Color newColor = Color(int.parse('FF$hexCode', radix: 16));
    return newColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFromHex('#F2F8FC'),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
