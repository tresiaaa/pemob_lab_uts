import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.blueAccent;
  static const Color accent = Colors.amber;
  static const Color backgroundLight = Colors.white;
  static const Color backgroundDark = Color(0xFF121212);
  static const Color textLight = Colors.black87;
  static const Color textDark = Colors.white;
}

class AppSizes {
  static const double sPadding = 8.0;
  static const double mPadding = 16.0;
  static const double lPadding = 24.0;
  static const double borderRadius = 10.0;
}

class ScreenUtils {
  static double getWidthPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  static double getHeightPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }
}