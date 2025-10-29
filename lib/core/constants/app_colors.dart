import 'package:flutter/material.dart';

/// Centralized color definitions for the Tourist Assistive App
/// Provides consistent Duolingo-style colors throughout the application
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Duolingo Brand Colors
  static const Color duolingoGreen = Color(0xFF58CC02);
  static const Color duolingoBlue = Color(0xFF1CB0F6);
  static const Color duolingoRed = Color(0xFFFF4B4B);
  static const Color duolingoPurple = Color(0xFFCE82FF);
  static const Color duolingoOrange = Color(0xFFFF6B35);
  static const Color duolingoYellow = Color(0xFFFFD93D);
  static const Color duolingoPink = Color(0xFFFF6B9D);
  
  // Primary App Color (Duolingo Blue for consistency)
  static const Color primary = duolingoBlue;

  // Duolingo Dark Theme Colors
  static const Color duolingoDark = Color(0xFF1A1A1A);
  static const Color duolingoCard = Color(0xFF2A2A2A);
  static const Color duolingoSurface = Color(0xFF333333);
  static const Color duolingoBorder = Color(0xFF404040);

  // Text Colors
  static const Color duolingoTextPrimary = Color(0xFFFFFFFF);
  static const Color duolingoTextSecondary = Color(0xFFB3B3B3);
  static const Color duolingoTextTertiary = Color(0xFF808080);
  static const Color duolingoTextDisabled = Color(0xFF666666);

  // Status Colors
  static const Color success = Color(0xFF58CC02);
  static const Color warning = Color(0xFFFFD93D);
  static const Color error = Color(0xFFFF4B4B);
  static const Color info = Color(0xFF1CB0F6);

  // Background Colors
  static const Color backgroundPrimary = Color(0xFF1A1A1A);
  static const Color backgroundSecondary = Color(0xFF2A2A2A);
  static const Color backgroundTertiary = Color(0xFF333333);

  // Surface Colors
  static const Color surfacePrimary = Color(0xFF2A2A2A);
  static const Color surfaceSecondary = Color(0xFF333333);
  static const Color surfaceTertiary = Color(0xFF404040);

  // Border Colors
  static const Color borderPrimary = Color(0xFF404040);
  static const Color borderSecondary = Color(0xFF666666);
  static const Color borderFocus = Color(0xFF58CC02);

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);

  // Gradient Colors
  static const LinearGradient duolingoGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF58CC02),
      Color(0xFF1CB0F6),
    ],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1A1A1A),
      Color(0xFF2A2A2A),
    ],
  );

  // Material Color Swatches
  static const MaterialColor duolingoGreenSwatch = MaterialColor(
    0xFF58CC02,
    <int, Color>{
      50: Color(0xFFF0F9E8),
      100: Color(0xFFD9F2B8),
      200: Color(0xFFB8E682),
      300: Color(0xFF97D94C),
      400: Color(0xFF7FCC27),
      500: Color(0xFF58CC02),
      600: Color(0xFF4FB600),
      700: Color(0xFF439F00),
      800: Color(0xFF378800),
      900: Color(0xFF256100),
    },
  );

  static const MaterialColor duolingoBlueSwatch = MaterialColor(
    0xFF1CB0F6,
    <int, Color>{
      50: Color(0xFFE6F7FF),
      100: Color(0xFFB3E6FF),
      200: Color(0xFF80D4FF),
      300: Color(0xFF4DC2FF),
      400: Color(0xFF26B8FF),
      500: Color(0xFF1CB0F6),
      600: Color(0xFF1A9EDD),
      700: Color(0xFF178BC4),
      800: Color(0xFF1478AB),
      900: Color(0xFF0E5592),
    },
  );
}

