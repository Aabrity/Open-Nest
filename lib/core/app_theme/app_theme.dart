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
      fontFamily: 'Montserrat Bold', 
      appBarTheme: const AppBarTheme(
        backgroundColor: appBarBackgroundColor,
        titleTextStyle: TextStyle(
          fontFamily: 'Montserrat Bold',
          color: appBarTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontFamily: 'Montserrat Italic',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Montserrat Itallic ',
          fontSize: 15,
          color: textSecondaryColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Montserrat Italic',
          fontSize: 13,
          color: textColor,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Montserrat Italic',
          fontSize: 12,
          color: textSecondaryColor,
        ),
      ),
      iconTheme: const IconThemeData(
        color: notificationIconColor,
      ),
    );
  }
}
