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
      fontFamily: 'oswald bold',
      appBarTheme: const AppBarTheme(
        backgroundColor: appBarBackgroundColor,
        titleTextStyle: TextStyle(
          fontFamily: 'oswald bold',
          color: appBarTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontFamily: 'oswald bold',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'oswald regular',
          fontSize: 15,
          color: textSecondaryColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'oswald regular',
          fontSize: 14,
          color: textColor,
        ),
        bodySmall: TextStyle(
          fontFamily: 'oswald light',
          fontSize: 13,
          color: textSecondaryColor,
        ),
      ),
      iconTheme: const IconThemeData(
        color: notificationIconColor,
      ),
    );
  }
}
