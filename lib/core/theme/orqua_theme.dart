import 'package:flutter/material.dart';

class OrquaTheme {
  static const Color primaryBlue = Color(0xFF1A4D6D);
  static const Color accentCoral = Color(0xFFE8927C);
  static const Color lightBlue = Color(0xFF6B9CB8);
  static const Color seafoam = Color(0xFF8FB8A8);
  static const Color sand = Color(0xFFF4F1ED);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkGrey = Color(0xFF2C3E50);
  static const Color lightGrey = Color(0xFFECF0F1);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primaryBlue,
        secondary: accentCoral,
        tertiary: seafoam,
        surface: white,
        background: sand,
        error: Color(0xFFD32F2F),
        onPrimary: white,
        onSecondary: white,
        onSurface: darkGrey,
        onBackground: darkGrey,
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: darkGrey,
        ),
        displayMedium: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w300,
          letterSpacing: 0,
          color: darkGrey,
        ),
        displaySmall: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
          color: darkGrey,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          color: primaryBlue,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          color: primaryBlue,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          color: darkGrey,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: darkGrey,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: darkGrey,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: darkGrey,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: darkGrey,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: darkGrey,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: white,
        ),
      ),

      // Boutons sobres et rectangulaires
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Angles droits
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
          ),
        ),
      ),

      // Cards minimalistes
      cardTheme: const CardThemeData(
        elevation: 1,
        shadowColor: Color(0x1A000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Angles droits
        ),
        color: white,
        margin: EdgeInsets.zero,
      ),

      // AppBar sobre
      appBarTheme: const AppBarTheme(
        backgroundColor: white,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: darkGrey, size: 20),
        titleTextStyle: TextStyle(
          color: darkGrey,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),

      // Input sobre
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightGrey,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero, // Angles droits
          borderSide: BorderSide(color: Color(0xFFBDC3C7)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Color(0xFFBDC3C7)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: primaryBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      // Dividers
      dividerTheme: const DividerThemeData(
        color: Color(0xFFBDC3C7),
        thickness: 1,
        space: 1,
      ),
    );
  }
}

