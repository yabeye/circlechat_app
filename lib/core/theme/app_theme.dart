import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  colorScheme: const ColorScheme.light(secondary: AppColors.secondary),
  scaffoldBackgroundColor: AppColors.backgroundLight,
  cardColor: AppColors.cardLight,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.textDark,
    foregroundColor: Colors.white,
    iconTheme: const IconThemeData(color: AppColors.textLight),
    titleTextStyle: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: AppColors.textLight,
      fontSize: 20,
    ),
    titleSpacing: 0,
    surfaceTintColor: AppColors.textDark,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    TextTheme(
      bodyLarge: const TextStyle(color: AppColors.textLight),
      titleLarge: const TextStyle(color: AppColors.textLight),
      headlineLarge: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textLight,
      ),
      headlineSmall: const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        color: AppColors.textLight,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.textLight.withOpacity(0.7),
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: AppColors.textLight.withOpacity(0.7),
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
  iconTheme: const IconThemeData(
    color: AppColors.textLight,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: GoogleFonts.poppins(
      fontSize: 12,
      color: AppColors.textLight.withValues(alpha: 0.7),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: WidgetStateProperty.all(
      GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.textLight,
      ),
    ),
  ),
  dividerTheme: DividerThemeData(
    color: AppColors.textLight.withOpacity(0.2),
    thickness: 1,
    space: 8,
  ),
  listTileTheme: ListTileThemeData(
    textColor: AppColors.textLight,
    iconColor: AppColors.textLight,
    selectedColor: AppColors.primary,
    selectedTileColor: AppColors.selectedColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      color: AppColors.textLight,
    ),
    subtitleTextStyle: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      // color: AppColors.textLight.withOpacity(0.6),
      color: AppColors.greyDark,
    ),
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
    iconTheme: const IconThemeData(color: AppColors.textDark),
    surfaceTintColor: Colors.grey[850],
    titleTextStyle: GoogleFonts.poppins(
      fontWeight: FontWeight.w800,
      color: AppColors.textDark,
      fontSize: 18,
    ),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    TextTheme(
      bodyLarge: const TextStyle(color: AppColors.textDark),
      titleLarge: const TextStyle(color: AppColors.textDark),
      headlineLarge: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textLight, // Or Colors.white, if that's what you want
      ),
      headlineSmall: const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
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
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: WidgetStateProperty.all(
      GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),
    ),
  ),
);
