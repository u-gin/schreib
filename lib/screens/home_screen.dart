import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  static Color colorFromHex(String colorCode) {
    final hexCode = colorCode.replaceAll('#', '');
    Color newColor = Color(int.parse('FF$hexCode', radix: 16));
    return newColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFromHex('#F2F8FC'),
      body: Center(
        child: Lottie.asset(
          'assets/lottie/logo.json',
          width: 200,
          height: 200,
          frameRate: FrameRate(300),
        ),
      ),
    );
  }
}
