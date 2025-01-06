import 'package:final_ibilling/assets/colors/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    textTheme: TextTheme(
      displayLarge: TextStyles.displayLarge.copyWith(color: Colors.black),
      displayMedium: TextStyles.displayMedium.copyWith(color: Colors.black),
      displaySmall: TextStyles.displaySmall.copyWith(color: Colors.black),
      bodyLarge: TextStyles.bodyLarge.copyWith(color: Colors.black),
      bodyMedium: TextStyles.bodyMedium.copyWith(color: Colors.black),
      bodySmall: TextStyles.bodySmall.copyWith(color: Colors.black),
      headlineLarge: TextStyles.headlineLarge.copyWith(color: Colors.black),
      headlineMedium: TextStyles.headlineMedium.copyWith(color: Colors.black),
      headlineSmall: TextStyles.headlineSmall.copyWith(color: Colors.black),
      labelLarge: TextStyles.labelLarge.copyWith(color: Colors.black),
      labelMedium: TextStyles.labelMedium.copyWith(color: Colors.black),
      labelSmall: TextStyles.labelSmall.copyWith(color: Colors.black),
      titleLarge: TextStyles.titleLarge.copyWith(color: Colors.black),
      titleMedium: TextStyles.titleMedium.copyWith(color: Colors.black),
      titleSmall: TextStyles.titleSmall.copyWith(color: Colors.black),
    ),
  );
}

abstract class DarkTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    primaryColor: Colors.deepPurple,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.black),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.darkDarker,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(color: Colors.white),
      selectedLabelStyle: TextStyle(color: Colors.yellow),
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.white,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      displayLarge: TextStyles.displayLarge.copyWith(color: Colors.white),
      displayMedium: TextStyles.displayMedium.copyWith(color: Colors.white),
      displaySmall: TextStyles.displaySmall.copyWith(color: Colors.white),
      bodyLarge: TextStyles.bodyLarge.copyWith(color: Colors.white),
      bodyMedium: TextStyles.bodyMedium.copyWith(color: Colors.white),
      bodySmall: TextStyles.bodySmall.copyWith(color: Colors.white),
      headlineLarge: TextStyles.headlineLarge.copyWith(color: Colors.white),
      headlineMedium: TextStyles.headlineMedium.copyWith(color: Colors.white),
      headlineSmall: TextStyles.headlineSmall.copyWith(color: Colors.white),
      labelLarge: TextStyles.labelLarge.copyWith(color: Colors.white),
      labelMedium: TextStyles.labelMedium.copyWith(color: Colors.white),
      labelSmall: TextStyles.labelSmall.copyWith(color: Colors.white),
      titleLarge: TextStyles.titleLarge.copyWith(color: Colors.white),
      titleMedium: TextStyles.titleMedium.copyWith(color: Colors.white),
      titleSmall: TextStyles.titleSmall.copyWith(color: Colors.white),
    ),
  );
}

@immutable
class FontSizes {
  const FontSizes._();

  static double size7 = 7;
  static double size8 = 8;
  static double size10 = 10;
  static double size11 = 11;
  static double size12 = 12;
  static double size14 = 14;
  static double size15 = 15;
  static double size16 = 16;
  static double size18 = 18;
  static double size20 = 20;
  static double size24 = 24;
  static double size30 = 30;
  static double size34 = 34;
  static double size48 = 48;
  static double size60 = 60;
  static double size96 = 96;
}

abstract class TextStyles {
  static const String fontFamily = "Ubuntu";

  // Display styles
  static TextStyle displayLarge = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: FontSizes.size20,
    fontFamily: fontFamily,
    color: Colors.black,
  );
  static TextStyle displayMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSizes.size16,
    fontFamily: fontFamily,
    color: Colors.black,
  );
  static TextStyle displaySmall = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: FontSizes.size14,
    fontFamily: fontFamily,
    color: Colors.black,
  );

  // Body styles
  static TextStyle bodyLarge = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: FontSizes.size18,
    fontFamily: fontFamily,
    color: Colors.black,
  );
  static TextStyle bodyMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSizes.size14,
    fontFamily: fontFamily,
    color: Colors.black,
  );
  static TextStyle bodySmall = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: FontSizes.size12,
    fontFamily: fontFamily,
    color: Colors.black,
  );

  // Headline styles
  static TextStyle headlineLarge = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: FontSizes.size24,
    fontFamily: fontFamily,
    color: Colors.black,
  );
  static TextStyle headlineMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSizes.size18,
    fontFamily: fontFamily,
    color: Colors.black,
  );
  static TextStyle headlineSmall = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: FontSizes.size14,
    fontFamily: fontFamily,
    color: Colors.black,
  );

  // Label styles
  static TextStyle labelLarge = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: FontSizes.size20,
    fontFamily: fontFamily,
    color: Colors.black,
  );
  static TextStyle labelMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSizes.size14,
    fontFamily: fontFamily,
    color: Colors.black,
  );
  static TextStyle labelSmall = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: FontSizes.size12,
    fontFamily: fontFamily,
    color: Colors.black,
  );

  // Title styles
  static TextStyle titleLarge = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: FontSizes.size20,
    fontFamily: fontFamily,
    color: Colors.black,
  );
  static TextStyle titleMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: FontSizes.size16,
    fontFamily: fontFamily,
    color: Colors.black,
  );
  static TextStyle titleSmall = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: FontSizes.size14,
    fontFamily: fontFamily,
    color: Colors.black,
  );
}
