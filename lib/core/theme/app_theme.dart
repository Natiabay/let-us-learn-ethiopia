import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  // Professional color palette (matching reference app)
  static const Color primary = Color(0xFF00D9B8); // Vibrant turquoise (PRIMARY ACTION)
  static const Color primaryLight = Color(0xFF00F5D4); // Lighter turquoise
  static const Color primaryDark = Color(0xFF00BFA5); // Darker turquoise
  static const Color primaryContainer = Color(0xFF1A2F44); // Navy container
  
  static const Color secondary = Color(0xFF3B82F6); // Blue
  static const Color secondaryLight = Color(0xFF60A5FA); // Lighter blue
  static const Color secondaryDark = Color(0xFF2563EB); // Darker blue
  static const Color secondaryContainer = Color(0xFF1A2F44); // Navy container
  
  static const Color accent = Color(0xFF8B5CF6); // Purple
  static const Color accentLight = Color(0xFFA78BFA); // Light purple
  static const Color accentDark = Color(0xFF7C3AED); // Dark purple
  static const Color accentContainer = Color(0xFF1A2F44); // Navy container
  
  // Modern neutral palette (DARK THEME)
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF1A1A1A);
  static const Color grey50 = Color(0xFF404040);
  static const Color grey100 = Color(0xFF4D4D4D);
  static const Color grey200 = Color(0xFF666666);
  static const Color grey300 = Color(0xFF808080);
  static const Color grey400 = Color(0xFF999999);
  static const Color grey500 = Color(0xFFB3B3B3);
  static const Color grey600 = Color(0xFFCCCCCC);
  static const Color grey700 = Color(0xFFE0E0E0);
  static const Color grey800 = Color(0xFF333333);
  static const Color grey900 = Color(0xFF2A2A2A);
  
  // Background Colors (PROFESSIONAL DARK NAVY THEME - like reference app)
  static const Color background = Color(0xFF0A1929); // Deep navy blue (like reference app)
  static const Color surface = Color(0xFF1A2F44); // Lighter navy for cards
  static const Color surfaceVariant = Color(0xFF243B53);
  static const Color surfaceContainer = Color(0xFF1A2F44);
  
  // Text Colors for DARK THEME
  static const Color textPrimary = Color(0xFFFFFFFF); // White text on dark
  static const Color textSecondary = Color(0xFFB3B3B3); // Light gray
  static const Color textTertiary = Color(0xFF808080); // Medium gray
  static const Color textDisabled = Color(0xFF666666); // Dark gray
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);
  
  // Professional Action Colors (like reference app - vibrant turquoise)
  static const Color duolingoGreen = Color(0xFF00D9B8); // Vibrant turquoise (PRIMARY ACTION)
  static const Color duolingoBlue = Color(0xFF3B82F6); // Blue
  static const Color duolingoRed = Color(0xFFEF4444); // Red for errors
  static const Color duolingoPurple = Color(0xFF8B5CF6); // Purple
  static const Color duolingoOrange = Color(0xFFF59E0B); // Orange for warnings
  static const Color duolingoYellow = Color(0xFFFBBF24); // Yellow for highlights
  static const Color duolingoPink = Color(0xFFEC4899); // Pink
  
  // Professional Dark Navy Background Colors (like reference app)
  static const Color duolingoDark = Color(0xFF0A1929); // Deep navy blue background
  static const Color duolingoCard = Color(0xFF1A2F44); // Navy card background
  static const Color duolingoSurface = Color(0xFF243B53); // Surface color
  static const Color duolingoBorder = Color(0xFF334155); // Border color
  
  // Duolingo Text Colors for Dark Theme
  static const Color duolingoTextPrimary = Color(0xFFFFFFFF); // White text
  static const Color duolingoTextSecondary = Color(0xFFB3B3B3); // Light gray text
  static const Color duolingoTextTertiary = Color(0xFF808080); // Medium gray text
  static const Color duolingoTextDisabled = Color(0xFF666666); // Disabled text
  
  // Status Colors (Duolingo style for dark theme)
  static const Color success = Color(0xFF58CC02); // Duolingo green
  static const Color successLight = Color(0xFF7FCC27);
  static const Color successContainer = Color(0xFF2A2A2A);
  
  static const Color warning = Color(0xFFFFD93D); // Duolingo yellow
  static const Color warningLight = Color(0xFFFFE680);
  static const Color warningContainer = Color(0xFF2A2A2A);
  
  static const Color error = Color(0xFFFF4B4B); // Duolingo red
  static const Color errorLight = Color(0xFFFF7373);
  static const Color errorContainer = Color(0xFF2A2A2A);
  
  static const Color info = Color(0xFF1CB0F6); // Duolingo blue
  static const Color infoLight = Color(0xFF64C5FF);
  static const Color infoContainer = Color(0xFF2A2A2A);
  
  // Gradient colors for modern effects (Duolingo style)
  static const List<Color> primaryGradient = [
    Color(0xFF58CC02), // Duolingo green
    Color(0xFF1CB0F6), // Duolingo blue
  ];
  
  static const List<Color> secondaryGradient = [
    Color(0xFF1CB0F6), // Duolingo blue
    Color(0xFFCE82FF), // Duolingo purple
  ];
  
  static const List<Color> accentGradient = [
    Color(0xFFCE82FF), // Duolingo purple
    Color(0xFFFF6B9D), // Duolingo pink
  ];
  
  // Shadow colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);
  
  // Additional missing colors
  static const Color errorDark = Color(0xFFB71C1C);
  static const Color grey = Color(0xFF808080);
  static const Color lightGrey = Color(0xFF666666);
  
  // Additional colors for new components (DARK THEME)
  static const Color backgroundSecondary = Color(0xFF2A2A2A);
  static const Color border = Color(0xFF404040); // Dark border
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.textOnPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        onSecondary: AppColors.textOnSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.secondaryDark,
        tertiary: AppColors.accent,
        onTertiary: AppColors.textOnPrimary,
        tertiaryContainer: AppColors.accentContainer,
        onTertiaryContainer: AppColors.accentDark,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        surfaceContainerHighest: AppColors.surfaceContainer,
        onSurfaceVariant: AppColors.textSecondary,
        // background and onBackground are deprecated, using surface instead
        // background: AppColors.background,
        // onBackground: AppColors.textPrimary,
        error: AppColors.error,
        onError: AppColors.textOnPrimary,
        errorContainer: AppColors.errorContainer,
        onErrorContainer: AppColors.errorDark,
        outline: AppColors.grey300,
        outlineVariant: AppColors.grey200,
        shadow: AppColors.shadowLight,
        scrim: AppColors.shadowMedium,
      ),
      fontFamily: null,
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: AppColors.primary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        titleTextStyle: const TextStyle(
          fontFamily: null,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        toolbarTextStyle: const TextStyle(
          fontFamily: null,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey500,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: null,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: null,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.grey200, width: 1),
        ),
        color: AppColors.surface,
        shadowColor: AppColors.shadowLight,
        surfaceTintColor: AppColors.primary,
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          shadowColor: AppColors.shadowLight,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: null,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontFamily: null,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: null,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.grey300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.grey300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        labelStyle: const TextStyle(
          fontFamily: null,
          color: AppColors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(
          fontFamily: null,
          color: AppColors.textTertiary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        shape: CircleBorder(),
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: null,
          fontSize: 36,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
          letterSpacing: -1.0,
          height: 1.1,
        ),
        displayMedium: TextStyle(
          fontFamily: null,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.8,
          height: 1.2,
        ),
        displaySmall: TextStyle(
          fontFamily: null,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.6,
          height: 1.2,
        ),
        headlineLarge: TextStyle(
          fontFamily: null,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.4,
          height: 1.3,
        ),
        headlineMedium: TextStyle(
          fontFamily: null,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: -0.2,
          height: 1.3,
        ),
        headlineSmall: TextStyle(
          fontFamily: null,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: -0.1,
          height: 1.4,
        ),
        titleLarge: TextStyle(
          fontFamily: null,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: 0.0,
          height: 1.4,
        ),
        titleMedium: TextStyle(
          fontFamily: null,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: 0.1,
          height: 1.4,
        ),
        titleSmall: TextStyle(
          fontFamily: null,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
          letterSpacing: 0.2,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          fontFamily: null,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
          letterSpacing: 0.0,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontFamily: null,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
          letterSpacing: 0.1,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontFamily: null,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          letterSpacing: 0.2,
          height: 1.5,
        ),
        labelLarge: TextStyle(
          fontFamily: null,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: 0.1,
          height: 1.4,
        ),
        labelMedium: TextStyle(
          fontFamily: null,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
          letterSpacing: 0.2,
          height: 1.4,
        ),
        labelSmall: TextStyle(
          fontFamily: null,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: AppColors.textTertiary,
          letterSpacing: 0.3,
          height: 1.4,
        ),
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: AppColors.primaryLight,
        onPrimary: AppColors.black,
        primaryContainer: AppColors.primaryDark,
        onPrimaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        onSecondary: AppColors.black,
        secondaryContainer: AppColors.secondaryDark,
        onSecondaryContainer: AppColors.secondaryLight,
        tertiary: AppColors.accentLight,
        onTertiary: AppColors.black,
        tertiaryContainer: AppColors.accentDark,
        onTertiaryContainer: AppColors.accentLight,
        surface: AppColors.grey900,
        onSurface: AppColors.grey100,
        surfaceContainerHighest: AppColors.grey800,
        onSurfaceVariant: AppColors.grey300,
        // background and onBackground are deprecated, using surface instead
        // background: AppColors.black,
        // onBackground: AppColors.grey100,
        error: AppColors.errorLight,
        onError: AppColors.black,
        errorContainer: AppColors.errorDark,
        onErrorContainer: AppColors.errorLight,
        outline: AppColors.grey600,
        outlineVariant: AppColors.grey700,
        shadow: AppColors.shadowDark,
        scrim: AppColors.shadowMedium,
      ),
      fontFamily: null,
    );
  }
  
  // Text style getters for easy access
  static const TextStyle heading1 = TextStyle(
          fontFamily: null,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.8,
    height: 1.2,
  );
  
  static const TextStyle heading2 = TextStyle(
          fontFamily: null,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.6,
    height: 1.2,
  );
  
  static const TextStyle heading3 = TextStyle(
          fontFamily: null,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.4,
    height: 1.3,
  );
  
  static const TextStyle subtitle1 = TextStyle(
          fontFamily: null,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.0,
    height: 1.4,
  );
  
  static const TextStyle subtitle2 = TextStyle(
          fontFamily: null,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
    height: 1.4,
  );
  
  static const TextStyle bodyLarge = TextStyle(
          fontFamily: null,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.0,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
          fontFamily: null,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
    height: 1.5,
  );
  
  static const TextStyle bodySmall = TextStyle(
          fontFamily: null,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
    height: 1.5,
  );
  
  static const TextStyle titleMedium = TextStyle(
          fontFamily: null,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
    height: 1.4,
  );
}







