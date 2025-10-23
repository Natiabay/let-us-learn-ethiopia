import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tourist_assistive_app/core/constants/app_colors.dart';

/// Comprehensive Duolingo Dark Theme Fix
/// Ensures the dark theme is properly applied throughout the app
class DuolingoThemeFix {
  // Private constructor to prevent instantiation
  DuolingoThemeFix._();

  /// Get the complete Duolingo dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Primary Color Scheme
      primaryColor: AppColors.duolingoGreen,
      primaryColorDark: AppColors.duolingoGreen,
      primaryColorLight: AppColors.duolingoGreen,
      
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
        surfaceContainerHighest: AppColors.duolingoCard,
        surfaceContainerHigh: AppColors.duolingoSurface,
        surfaceContainer: AppColors.duolingoSurface,
        surfaceContainerLow: AppColors.duolingoSurface,
        surfaceContainerLowest: AppColors.duolingoDark,
        surfaceVariant: AppColors.duolingoSurface,
        onSurfaceVariant: AppColors.duolingoTextSecondary,
        outline: AppColors.duolingoBorder,
        outlineVariant: AppColors.duolingoBorder,
        shadow: Colors.black,
        scrim: Colors.black54,
        inverseSurface: AppColors.duolingoTextPrimary,
        onInverseSurface: AppColors.duolingoDark,
        inversePrimary: AppColors.duolingoGreen,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: AppColors.duolingoDark,

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
        iconTheme: IconThemeData(
          color: AppColors.duolingoTextPrimary,
          size: 24,
        ),
        actionsIconTheme: IconThemeData(
          color: AppColors.duolingoTextPrimary,
          size: 24,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.duolingoCard,
        elevation: 4,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(8),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.duolingoGreen,
          foregroundColor: AppColors.duolingoTextPrimary,
          elevation: 2,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
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
          foregroundColor: AppColors.duolingoGreen,
          side: const BorderSide(color: AppColors.duolingoGreen, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
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
          color: AppColors.duolingoTextSecondary,
          fontSize: 16,
          fontFamily: 'Inter',
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.duolingoCard,
        selectedItemColor: AppColors.duolingoGreen,
        unselectedItemColor: AppColors.duolingoTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),

      // Tab Bar Theme
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.duolingoGreen,
        unselectedLabelColor: AppColors.duolingoTextSecondary,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColors.duolingoGreen, width: 3),
        ),
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.duolingoTextPrimary,
        size: 24,
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
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
        bodyMedium: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
        bodySmall: TextStyle(
          color: AppColors.duolingoTextSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
        labelLarge: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        labelMedium: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        labelSmall: TextStyle(
          color: AppColors.duolingoTextSecondary,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),

      // Tooltip Theme
      tooltipTheme: const TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.duolingoCard,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        textStyle: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 12,
          fontFamily: 'Inter',
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
          color: AppColors.duolingoTextPrimary,
          fontSize: 16,
          fontFamily: 'Inter',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
      ),

      // Snack Bar Theme
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.duolingoCard,
        contentTextStyle: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
        actionTextColor: AppColors.duolingoGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.duolingoSurface,
        labelStyle: const TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
        side: const BorderSide(color: AppColors.duolingoBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.duolingoGreen,
        linearTrackColor: AppColors.duolingoSurface,
        circularTrackColor: AppColors.duolingoSurface,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.duolingoBorder,
        thickness: 1,
        space: 1,
      ),

      // List Tile Theme
      listTileTheme: const ListTileThemeData(
        tileColor: AppColors.duolingoCard,
        textColor: AppColors.duolingoTextPrimary,
        iconColor: AppColors.duolingoTextPrimary,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.duolingoGreen;
          }
          return AppColors.duolingoTextSecondary;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.duolingoGreen.withValues(alpha: 0.3);
          }
          return AppColors.duolingoSurface;
        }),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.duolingoGreen;
          }
          return AppColors.duolingoTextSecondary;
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

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.duolingoGreen,
        inactiveTrackColor: AppColors.duolingoSurface,
        thumbColor: AppColors.duolingoGreen,
        overlayColor: AppColors.duolingoGreen.withValues(alpha: 0.2),
        valueIndicatorColor: AppColors.duolingoGreen,
        valueIndicatorTextStyle: const TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 12,
          fontFamily: 'Inter',
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.duolingoCard,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      // Popup Menu Theme
      popupMenuTheme: const PopupMenuThemeData(
        color: AppColors.duolingoCard,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        textStyle: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
      ),

      // Drawer Theme
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.duolingoCard,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
        ),
      ),

      // Navigation Bar Theme
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: AppColors.duolingoCard,
        indicatorColor: AppColors.duolingoGreen,
        labelTextStyle: MaterialStatePropertyAll(
          TextStyle(
            color: AppColors.duolingoTextPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        iconTheme: MaterialStatePropertyAll(
          IconThemeData(
            color: AppColors.duolingoTextPrimary,
            size: 24,
          ),
        ),
      ),

      // Navigation Rail Theme
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: AppColors.duolingoCard,
        selectedIconTheme: IconThemeData(
          color: AppColors.duolingoGreen,
          size: 24,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.duolingoTextSecondary,
          size: 24,
        ),
        selectedLabelTextStyle: TextStyle(
          color: AppColors.duolingoGreen,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        unselectedLabelTextStyle: TextStyle(
          color: AppColors.duolingoTextSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),

      // Data Table Theme
      dataTableTheme: const DataTableThemeData(
        headingRowColor: MaterialStatePropertyAll(AppColors.duolingoSurface),
        dataRowColor: MaterialStatePropertyAll(AppColors.duolingoCard),
        headingTextStyle: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        dataTextStyle: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
      ),

      // Text Selection Theme
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.duolingoGreen,
        selectionColor: AppColors.duolingoGreen,
        selectionHandleColor: AppColors.duolingoGreen,
      ),

      // Time Picker Theme
      timePickerTheme: const TimePickerThemeData(
        backgroundColor: AppColors.duolingoCard,
        hourMinuteTextColor: AppColors.duolingoTextPrimary,
        dayPeriodTextColor: AppColors.duolingoTextPrimary,
        dialHandColor: AppColors.duolingoGreen,
        dialBackgroundColor: AppColors.duolingoSurface,
        hourMinuteTextStyle: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        dayPeriodTextStyle: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 12,
          fontFamily: 'Inter',
        ),
      ),

      // Date Picker Theme
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: AppColors.duolingoCard,
        headerBackgroundColor: AppColors.duolingoSurface,
        headerForegroundColor: AppColors.duolingoTextPrimary,
        weekdayStyle: TextStyle(
          color: AppColors.duolingoTextSecondary,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
        dayStyle: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 16,
          fontFamily: 'Inter',
        ),
        yearStyle: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 16,
          fontFamily: 'Inter',
        ),
      ),

      // Banner Theme
      bannerTheme: const MaterialBannerThemeData(
        backgroundColor: AppColors.duolingoCard,
        contentTextStyle: TextStyle(
          color: AppColors.duolingoTextPrimary,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
      ),

      // Badge Theme
      badgeTheme: const BadgeThemeData(
        backgroundColor: AppColors.duolingoRed,
        textColor: AppColors.duolingoTextPrimary,
        textStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),

      // Material Tap Target Size
      materialTapTargetSize: MaterialTapTargetSize.padded,

      // Font Family
      fontFamily: 'Inter',
    );
  }
}
