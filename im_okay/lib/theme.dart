import 'package:flutter/material.dart';

class AppTheme {
  // Light mode colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF0A0A0A);
  static const Color lightTextSecondary = Color(0xFF6E6E6E);
  static const Color lightCardBorder = Color(0xFFE4E4E4);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  
  // Dark mode colors
  static const Color darkBackground = Color(0xFF050506);
  static const Color darkText = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFF9E9E9E);
  static const Color darkCardBorder = Color(0xFF2A2A2A);
  static const Color darkCardBackground = Color(0xFF1A1A1A);
  
  // Accent colors (shared, slightly brighter in dark mode)
  static const Color babyBlue = Color(0xFF87CEEB);
  static const Color mintGreen = Color(0xFF98D8C8);
  static const Color softOrange = Color(0xFFFFB366);
  static const Color softPink = Color(0xFFFFB3C1);
  static const Color softPurple = Color(0xFFB39DDB);
  static const Color softRed = Color(0xFFEF9A9A);
  static const Color neutralGray = Color(0xFFB0B0B0);

  // Light theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: const ColorScheme.light(
      primary: lightText,
      surface: lightBackground,
      onSurface: lightText,
      secondary: lightTextSecondary,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'DmSans',
        fontSize: 42,
        fontWeight: FontWeight.w700,
        color: lightText,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontFamily: 'DmSans',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: lightText,
        height: 1.3,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'DmSans',
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: lightText,
        height: 1.2,
      ),
      titleLarge: TextStyle(
        fontFamily: 'DmSans',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: lightText,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 17,
        height: 1.5,
        color: lightTextSecondary,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: lightText,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        color: lightTextSecondary,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: lightBackground,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: lightText),
      titleTextStyle: TextStyle(
        fontFamily: 'DmSans',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: lightText,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: lightCardBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: lightCardBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: lightText, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: softRed, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: softRed, width: 1.5),
      ),
      hintStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        color: lightTextSecondary,
      ),
    ),
  );

  // Dark theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: darkText,
      surface: darkBackground,
      onSurface: darkText,
      secondary: darkTextSecondary,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'DmSans',
        fontSize: 42,
        fontWeight: FontWeight.w700,
        color: darkText,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontFamily: 'DmSans',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: darkText,
        height: 1.3,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'DmSans',
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: darkText,
        height: 1.2,
      ),
      titleLarge: TextStyle(
        fontFamily: 'DmSans',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: darkText,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 17,
        height: 1.5,
        color: darkTextSecondary,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: darkText,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        color: darkTextSecondary,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: darkBackground,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: darkText),
      titleTextStyle: TextStyle(
        fontFamily: 'DmSans',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: darkText,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: darkCardBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: darkCardBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: darkText, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: softRed, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: softRed, width: 1.5),
      ),
      hintStyle: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        color: darkTextSecondary,
      ),
    ),
  );
}
