import 'package:flutter/material.dart';

/// Professional color scheme inspired by modern fintech apps
/// Dark navy theme with vibrant accent colors
class ProfessionalColors {
  ProfessionalColors._();

  // Background Colors - Dark Navy Theme (like reference app)
  static const Color backgroundDark = Color(0xFF0A1929); // Deep navy blue
  static const Color backgroundCard = Color(0xFF1A2F44); // Lighter navy for cards
  static const Color backgroundSurface = Color(0xFF243B53); // Surface elements
  static const Color backgroundModal = Color(0xFF0D1F2D); // Modals/overlays

  // Primary Action Colors - Turquoise/Cyan (like reference app)
  static const Color primaryButton = Color(0xFF00D9B8); // Vibrant turquoise
  static const Color primaryButtonHover = Color(0xFF00F5D4); // Lighter on hover
  static const Color primaryButtonPressed = Color(0xFF00BFA5); // Darker when pressed

  // Secondary Action Colors
  static const Color secondaryButton = Color(0xFF3B82F6); // Blue
  static const Color accentPurple = Color(0xFF8B5CF6); // Purple
  static const Color accentYellow = Color(0xFFFBBF24); // Yellow for highlights

  // Status Colors
  static const Color successGreen = Color(0xFF10B981); // Success states
  static const Color errorRed = Color(0xFFEF4444); // Error states  
  static const Color warningOrange = Color(0xFFF59E0B); // Warning states
  static const Color infoBlue = Color(0xFF3B82F6); // Info states

  // Text Colors - High Contrast for Readability
  static const Color textPrimary = Color(0xFFFFFFFF); // Pure white
  static const Color textSecondary = Color(0xFFE2E8F0); // Light gray
  static const Color textTertiary = Color(0xFF94A3B8); // Medium gray
  static const Color textDisabled = Color(0xFF64748B); // Dark gray
  static const Color textOnButton = Color(0xFF0A1929); // Dark text on bright buttons

  // Border & Divider Colors
  static const Color borderLight = Color(0xFF334155); // Subtle borders
  static const Color borderMedium = Color(0xFF475569); // Medium borders
  static const Color divider = Color(0xFF1E293B); // Dividers

  // Icon Colors
  static const Color iconPrimary = Color(0xFF00D9B8); // Turquoise icons
  static const Color iconSecondary = Color(0xFFE2E8F0); // Light gray icons
  static const Color iconDisabled = Color(0xFF64748B); // Disabled icons

  // Gradients
  static const List<Color> gradientPrimary = [
    Color(0xFF00D9B8), // Turquoise
    Color(0xFF3B82F6), // Blue
  ];

  static const List<Color> gradientSecondary = [
    Color(0xFF8B5CF6), // Purple
    Color(0xFF3B82F6), // Blue
  ];

  static const List<Color> gradientSuccess = [
    Color(0xFF10B981), // Green
    Color(0xFF00D9B8), // Turquoise
  ];

  // Shadow Colors
  static const Color shadowLight = Color(0x0F000000);
  static const Color shadowMedium = Color(0x1A000000);
  static const Color shadowDark = Color(0x33000000);

  // Overlay Colors
  static const Color overlayLight = Color(0x0AFFFFFF);
  static const Color overlayMedium = Color(0x1AFFFFFF);
  static const Color overlayDark = Color(0x33FFFFFF);
}

/// Professional dimensions and spacing
class ProfessionalDimensions {
  ProfessionalDimensions._();

  // Spacing
  static const double spaceXS = 4.0;
  static const double spaceSM = 8.0;
  static const double spaceMD = 16.0;
  static const double spaceLG = 24.0;
  static const double spaceXL = 32.0;
  static const double space2XL = 48.0;

  // Border Radius
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusFull = 9999.0;

  // Button Sizes (matching reference app)
  static const double buttonHeightSM = 40.0;
  static const double buttonHeightMD = 48.0;
  static const double buttonHeightLG = 56.0;
  static const double buttonHeightXL = 64.0;

  // Icon Sizes
  static const double iconSM = 16.0;
  static const double iconMD = 20.0;
  static const double iconLG = 24.0;
  static const double iconXL = 32.0;

  // Font Sizes
  static const double fontXS = 12.0;
  static const double fontSM = 14.0;
  static const double fontMD = 16.0;
  static const double fontLG = 18.0;
  static const double fontXL = 20.0;
  static const double font2XL = 24.0;
  static const double font3XL = 30.0;
  static const double font4XL = 36.0;
}

