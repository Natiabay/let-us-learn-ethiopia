import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/professional_colors.dart';

/// Professional theme matching the reference app
/// Dark navy theme with vibrant turquoise accents
class ProfessionalTheme {
  ProfessionalTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Color Scheme
      colorScheme: ColorScheme.dark(
        primary: ProfessionalColors.primaryButton,
        secondary: ProfessionalColors.secondaryButton,
        surface: ProfessionalColors.backgroundCard,
        error: ProfessionalColors.errorRed,
        onPrimary: ProfessionalColors.textOnButton,
        onSecondary: ProfessionalColors.textPrimary,
        onSurface: ProfessionalColors.textPrimary,
        onError: ProfessionalColors.textPrimary,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: ProfessionalColors.backgroundDark,
      
      // App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: ProfessionalColors.backgroundDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: ProfessionalColors.textPrimary,
          fontSize: ProfessionalDimensions.font2XL,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: ProfessionalColors.iconPrimary,
        ),
      ),
      
      // Card
      cardTheme: CardThemeData(
        color: ProfessionalColors.backgroundCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ProfessionalDimensions.radiusLG),
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ProfessionalColors.backgroundCard,
        selectedItemColor: ProfessionalColors.primaryButton,
        unselectedItemColor: ProfessionalColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontSize: ProfessionalDimensions.fontSM,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: ProfessionalDimensions.fontXS,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: ProfessionalDimensions.font4XL,
          fontWeight: FontWeight.bold,
          color: ProfessionalColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: ProfessionalDimensions.font3XL,
          fontWeight: FontWeight.bold,
          color: ProfessionalColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: ProfessionalDimensions.font2XL,
          fontWeight: FontWeight.bold,
          color: ProfessionalColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: ProfessionalDimensions.fontXL,
          fontWeight: FontWeight.w600,
          color: ProfessionalColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: ProfessionalDimensions.fontMD,
          color: ProfessionalColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: ProfessionalDimensions.fontSM,
          color: ProfessionalColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: ProfessionalDimensions.fontMD,
          fontWeight: FontWeight.w600,
          color: ProfessionalColors.textPrimary,
        ),
      ),
      
      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ProfessionalColors.primaryButton,
          foregroundColor: ProfessionalColors.textOnButton,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ProfessionalDimensions.radiusMD),
          ),
          minimumSize: const Size(double.infinity, ProfessionalDimensions.buttonHeightLG),
          textStyle: const TextStyle(
            fontSize: ProfessionalDimensions.fontMD,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ProfessionalColors.backgroundCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ProfessionalDimensions.radiusMD),
          borderSide: const BorderSide(
            color: ProfessionalColors.borderLight,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ProfessionalDimensions.radiusMD),
          borderSide: const BorderSide(
            color: ProfessionalColors.borderLight,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ProfessionalDimensions.radiusMD),
          borderSide: const BorderSide(
            color: ProfessionalColors.primaryButton,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ProfessionalDimensions.radiusMD),
          borderSide: const BorderSide(
            color: ProfessionalColors.errorRed,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: ProfessionalDimensions.spaceMD,
          vertical: ProfessionalDimensions.spaceMD,
        ),
        hintStyle: const TextStyle(
          color: ProfessionalColors.textTertiary,
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: ProfessionalColors.iconSecondary,
        size: ProfessionalDimensions.iconLG,
      ),
      
      // Divider
      dividerTheme: const DividerThemeData(
        color: ProfessionalColors.divider,
        thickness: 1,
        space: 1,
      ),
    );
  }
}

