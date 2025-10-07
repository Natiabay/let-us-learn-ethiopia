import 'package:flutter/foundation.dart';

/// Platform-specific service utilities
class PlatformService {
  /// Check if running on web platform
  static bool get isWeb => kIsWeb;
  
  /// Check if running on mobile platform (Android/iOS)
  static bool get isMobile => !kIsWeb;
  
  /// Check if running on desktop platform
  static bool get isDesktop => !kIsWeb && (defaultTargetPlatform == TargetPlatform.windows || 
                                          defaultTargetPlatform == TargetPlatform.macOS || 
                                          defaultTargetPlatform == TargetPlatform.linux);
  
  /// Get platform-specific file path separator
  static String get pathSeparator => isWeb ? '/' : (kIsWeb ? '/' : '\\');
  
  /// Check if file operations are supported
  static bool get supportsFileOperations => !kIsWeb;
  
  /// Check if camera operations are supported
  static bool get supportsCamera => !kIsWeb;
  
  /// Check if microphone operations are supported
  static bool get supportsMicrophone => !kIsWeb;
  
  /// Check if location services are supported
  static bool get supportsLocation => !kIsWeb;
  
  /// Get platform-specific error message for unsupported operations
  static String getUnsupportedOperationMessage(String operation) {
    if (kIsWeb) {
      return '$operation is not supported on web platform. Please use the mobile app for full functionality.';
    }
    return '$operation is not available on this platform.';
  }
  
  /// Execute platform-specific code
  static T executePlatformSpecific<T>({
    required T Function() mobile,
    required T Function() web,
  }) {
    if (kIsWeb) {
      return web();
    } else {
      return mobile();
    }
  }
  
  /// Execute code only on mobile platforms
  static T? executeOnMobile<T>(T Function() callback) {
    if (kIsWeb) {
      return null;
    }
    return callback();
  }
  
  /// Execute code only on web platform
  static T? executeOnWeb<T>(T Function() callback) {
    if (kIsWeb) {
      return callback();
    }
    return null;
  }
}
