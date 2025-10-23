import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

/// Duolingo-inspired dark theme with exact color matching
/// Provides the authentic Duolingo look and feel
class DuolingoTheme {
  // Private constructor to prevent instantiation
  DuolingoTheme._();

  /// Duolingo Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.duolingoGreen,
        secondary: AppColors.duolingoBlue,
        tertiary: AppColors.duolingoPurple,
        surface: AppColors.duolingoCard,
        background: AppColors.duolingoDark,
        onPrimary: AppColors.duolingoTextPrimary,
        onSecondary: AppColors.duolingoTextPrimary,
        onSurface: AppColors.duolingoTextPrimary,
        onBackground: AppColors.duolingoTextPrimary,
        error: AppColors.duolingoRed,
        onError: AppColors.duolingoTextPrimary,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.duolingoDark,
        foregroundColor: AppColors.duolingoTextPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: AppColors.duolingoDark,

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.duolingoCard,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.duolingoGreen,
          foregroundColor: AppColors.duolingoTextPrimary,
          elevation: 2,
          shadowColor: AppColors.duolingoGreen.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
          minimumSize: const Size(double.infinity, 48),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.duolingoGreen,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.duolingoTextPrimary,
          side: const BorderSide(color: AppColors.duolingoBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
          minimumSize: const Size(double.infinity, 48),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.duolingoSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.duolingoBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.duolingoBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.duolingoGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.duolingoRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.duolingoRed, width: 2),
        ),
        labelStyle: const TextStyle(
          color: AppColors.duolingoTextSecondary,
          fontSize: 16,
          fontFamily: 'Inter',
        ),
        hintStyle: const TextStyle(
          color: AppColors.duolingoTextTertiary,
          fontSize: 16,
          fontFamily: 'Inter',
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
        displayMedium: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
        displaySmall: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
        headlineLarge: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        headlineMedium: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        headlineSmall: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        titleLarge: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        titleMedium: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        titleSmall: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        bodyLarge: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontFamily: 'Inter',
        ),
        bodyMedium: TextStyle(
          color: AppColors.duolingoTextSecondary,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontFamily: 'Inter',
        ),
        bodySmall: TextStyle(
          color: AppColors.duolingoTextTertiary,
          fontSize: 12,
          fontWeight: FontWeight.normal,
          fontFamily: 'Inter',
        ),
        labelLarge: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
        labelMedium: TextStyle(
          color: AppColors.duolingoTextSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
        labelSmall: TextStyle(
          color: AppColors.duolingoTextTertiary,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.duolingoCard,
        selectedItemColor: AppColors.duolingoGreen,
        unselectedItemColor: AppColors.duolingoTextTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.duolingoGreen,
        foregroundColor: AppColors.duolingoTextPrimary,
        elevation: 4,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.duolingoBorder,
        thickness: 1,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.duolingoTextSecondary,
        size: 24,
      ),

      // List Tile Theme
      listTileTheme: const ListTileThemeData(
        tileColor: AppColors.duolingoCard,
        textColor: AppColors.duolingoTextPrimary,
        iconColor: AppColors.duolingoTextSecondary,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.duolingoGreen;
          }
          return AppColors.duolingoTextTertiary;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.duolingoGreen.withValues(alpha: 0.3);
          }
          return AppColors.duolingoBorder;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.duolingoGreen;
          }
          return AppColors.duolingoSurface;
        }),
        checkColor: MaterialStateProperty.all(AppColors.duolingoTextPrimary),
        side: const BorderSide(color: AppColors.duolingoBorder),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.duolingoGreen;
          }
          return AppColors.duolingoTextTertiary;
        }),
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.duolingoGreen,
        inactiveTrackColor: AppColors.duolingoBorder,
        thumbColor: AppColors.duolingoGreen,
        overlayColor: AppColors.duolingoGreen.withValues(alpha: 0.2),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.duolingoGreen,
        linearTrackColor: AppColors.duolingoBorder,
        circularTrackColor: AppColors.duolingoBorder,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.duolingoSurface,
        selectedColor: AppColors.duolingoGreen.withValues(alpha: 0.2),
        labelStyle: const TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontFamily: 'Inter',
        ),
        secondaryLabelStyle: const TextStyle(
          color: AppColors.duolingoTextSecondary,
          fontFamily: 'Inter',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.duolingoCard,
        titleTextStyle: const TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        contentTextStyle: const TextStyle(
          color: AppColors.duolingoTextSecondary,
          fontSize: 16,
          fontFamily: 'Inter',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.duolingoCard,
        contentTextStyle: const TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontFamily: 'Inter',
        ),
        actionTextColor: AppColors.duolingoGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Tooltip Theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.duolingoSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  /// Duolingo Light Theme (for reference)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.duolingoGreen,
        secondary: AppColors.duolingoBlue,
        surface: Colors.white,
        background: Color(0xFFF8F9FA),
      ),
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
    );
  }
}
