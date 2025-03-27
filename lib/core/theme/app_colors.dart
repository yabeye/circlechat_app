import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF388E3C);
  static const Color secondary = Color.fromARGB(255, 187, 225, 144);
  static Color primaryFade = AppColors.primary.withValues(alpha: .6);
  static Color selectedColor = AppColors.primary.withValues(alpha: 0.1);

  static const Color accent = Color(0xFFCDDC39);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF303030);
  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF424242);
  static const Color textLight = Colors.black;
  static const Color textDark = Colors.white70;
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color externalLinkColor = Color.fromARGB(255, 13, 83, 214);
  static const Color seenIndicator = Color.fromARGB(255, 13, 83, 214);

  // BASIC
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFE0E0E0);
  static const Color greyDark = Color(0xFF616161);
  static const Color red = Color(0xFFD32F2F);
  static const Color green = Color(0xFF388E3C);
  static const Color blue = Color(0xFF1976D2);
  static const Color blueLight = Color(0xFF64B5F6);
  static const Color blueDark = Color(0xFF0D47A1);
  static const Color yellow = Color(0xFFFFA000);
  static const Color yellowLight = Color(0xFFFFD54F);
  static const Color yellowDark = Color(0xFFFF6F00);
  static const Color orange = Color(0xFFFF6F00);
  static const Color orangeLight = Color(0xFFFFCC80);
}
