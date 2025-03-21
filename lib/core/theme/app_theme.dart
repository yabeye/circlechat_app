import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  colorScheme: const ColorScheme.light(secondary: AppColors.secondary),
  scaffoldBackgroundColor: AppColors.backgroundLight,
  cardColor: AppColors.cardLight,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
  ),
  textTheme: GoogleFonts.robotoTextTheme(
    TextTheme(
      bodyLarge: const TextStyle(color: AppColors.textLight),
      titleLarge: const TextStyle(color: AppColors.textLight),
      headlineLarge: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textLight, // Or Colors.white, if that's what you want
      ),
      bodyMedium: TextStyle(
        // Added this
        fontSize: 16,
        color: AppColors.textLight.withOpacity(0.7), // Or Colors.white70
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  colorScheme: const ColorScheme.dark(secondary: AppColors.secondary),
  scaffoldBackgroundColor: AppColors.backgroundDark,
  cardColor: AppColors.cardDark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[850],
    foregroundColor: Colors.white,
  ),
  textTheme: GoogleFonts.robotoTextTheme(
    TextTheme(
      bodyLarge: const TextStyle(color: AppColors.textDark),
      titleLarge: const TextStyle(color: AppColors.textDark),
      headlineLarge: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textLight, // Or Colors.white, if that's what you want
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.textDark.withOpacity(0.7), // Or Colors.white70
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
);
