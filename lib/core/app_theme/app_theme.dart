import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Colors.orange;
  static const Color secondaryColor = Colors.black;
  static const Color backgroundColor = Colors.white;
  static const Color appBarBackgroundColor = Colors.white;
  static const Color appBarTextColor = Colors.black54;
  static const Color activeCategoryColor = Colors.orange;
  static const Color inactiveCategoryColor = Colors.black;
  static const Color cardShadowColor = Colors.black12;
  static const Color cardBackgroundColor = Colors.white;
  static const Color textColor = Colors.black;
  static const Color textSecondaryColor = Colors.black54;
  static const Color notificationIconColor = Colors.grey;

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: appBarBackgroundColor,
        titleTextStyle: TextStyle(
          color: appBarTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: textSecondaryColor,
        ),
      ),
      iconTheme: const IconThemeData(
        color: notificationIconColor,
      ),
    );
  }
}
