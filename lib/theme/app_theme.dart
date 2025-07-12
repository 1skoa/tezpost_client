import 'package:flutter/material.dart';

class AppTheme {

  /// Цветовая палитра
  static const Color primaryColor = Color(0xFFFF7A33);
  static const Color backgroundColor = Color(0xFFF6F6F6);
  static const Color darkBackground = Color(0xFF121212);

  static const Color appBarColor = Color(0xFFEF7F24);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color onSurfaceColor = Color(0xFF333333);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: Color(0xFFFF8A27),
      onSecondary: Colors.white,
      background: backgroundColor,
      onBackground: Colors.black87,
      surface: surfaceColor,
      onSurface: onSurfaceColor,
      error: Colors.red,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: backgroundColor,
    cardColor: surfaceColor,
    dividerColor: Colors.grey.shade200,
    textTheme: _textThemeLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: Color(0xFF351B08),
      onSecondary: Colors.white,
      background: darkBackground,
      onBackground: Colors.white70,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: darkBackground,
    cardColor: Color(0xFF422F21),
    dividerColor: Colors.white24,
    textTheme: _textThemeDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
  );

  /// Общий текстовый стиль
  static const TextTheme _textThemeLight = TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF4A4A4A)),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFF4A4A4A)),
    bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF555555)),
    bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF666666)),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF777777)),
  );

  static const TextTheme _textThemeDark = TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w600,
        color: Color.fromRGBO(244, 145, 59, 1.0)
    ),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  );

  static const double padding = 16.0;
  static const double radius = 12.0;
  static const double iconSize = 24.0;
}
