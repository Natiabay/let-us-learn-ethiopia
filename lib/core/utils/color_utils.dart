import 'package:flutter/material.dart';

/// Utility class for color operations with platform compatibility
class ColorUtils {
  /// Create a color with opacity, using the new withValues method when available
  static Color withOpacity(Color color, double opacity) {
    // Use the new withValues method to avoid precision loss
    return color.withValues(alpha: opacity);
  }
  
  /// Create a color with alpha value
  static Color withAlpha(Color color, int alpha) {
    return color.withValues(alpha: alpha / 255.0);
  }
  
  /// Blend two colors
  static Color blend(Color color1, Color color2, double ratio) {
    return Color.lerp(color1, color2, ratio) ?? color1;
  }
  
  /// Get a lighter shade of a color
  static Color lighten(Color color, double amount) {
    return Color.lerp(color, Colors.white, amount) ?? color;
  }
  
  /// Get a darker shade of a color
  static Color darken(Color color, double amount) {
    return Color.lerp(color, Colors.black, amount) ?? color;
  }
  
  /// Check if a color is light or dark
  static bool isLight(Color color) {
    return color.computeLuminance() > 0.5;
  }
  
  /// Get contrasting text color (black or white)
  static Color getContrastingTextColor(Color backgroundColor) {
    return isLight(backgroundColor) ? Colors.black : Colors.white;
  }
}



















































