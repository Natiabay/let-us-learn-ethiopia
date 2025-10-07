import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Comprehensive error handling service for the Tourist Assistive App
class ErrorHandlingService {
  static final ErrorHandlingService _instance = ErrorHandlingService._internal();
  factory ErrorHandlingService() => _instance;
  ErrorHandlingService._internal();

  /// Handle API errors with user-friendly messages
  static String handleApiError(dynamic error) {
    if (error is String) {
      return _getUserFriendlyMessage(error);
    }

    final errorString = error.toString().toLowerCase();

    // Network errors
    if (errorString.contains('network') || errorString.contains('connection')) {
      return 'Please check your internet connection and try again.';
    }

    // API key errors
    if (errorString.contains('api key') || errorString.contains('unauthorized')) {
      return 'Service temporarily unavailable. Please try again later.';
    }

    // Rate limiting
    if (errorString.contains('rate limit') || errorString.contains('too many requests')) {
      return 'Too many requests. Please wait a moment and try again.';
    }

    // Server errors
    if (errorString.contains('500') || errorString.contains('server error')) {
      return 'Server is temporarily unavailable. Please try again later.';
    }

    // Timeout errors
    if (errorString.contains('timeout')) {
      return 'Request timed out. Please check your connection and try again.';
    }

    // Default error message
    return 'Something went wrong. Please try again.';
  }

  /// Get user-friendly error messages
  static String _getUserFriendlyMessage(String error) {
    final lowerError = error.toLowerCase();

    if (lowerError.contains('openai') || lowerError.contains('gpt')) {
      return 'AI assistant is temporarily unavailable. Please try again later.';
    }

    if (lowerError.contains('google') && lowerError.contains('maps')) {
      return 'Map service is temporarily unavailable. Please try again later.';
    }

    if (lowerError.contains('google') && lowerError.contains('translate')) {
      return 'Translation service is temporarily unavailable. Please try again later.';
    }

    if (lowerError.contains('firebase') || lowerError.contains('auth')) {
      return 'Authentication service is temporarily unavailable. Please try again later.';
    }

    if (lowerError.contains('location') || lowerError.contains('gps')) {
      return 'Location service is unavailable. Please check your GPS settings.';
    }

    if (lowerError.contains('microphone') || lowerError.contains('audio')) {
      return 'Audio service is unavailable. Please check your microphone permissions.';
    }

    if (lowerError.contains('camera')) {
      return 'Camera service is unavailable. Please check your camera permissions.';
    }

    return 'Service temporarily unavailable. Please try again later.';
  }

  /// Show error snackbar with retry option
  static void showErrorSnackBar(
    BuildContext context,
    String message, {
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
            if (onRetry != null)
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  onRetry();
                },
                child: const Text(
                  'RETRY',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Show success snackbar
  static void showSuccessSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Show warning snackbar
  static void showWarningSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning_outlined, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.orange,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Show error dialog with retry option
  static void showErrorDialog(
    BuildContext context,
    String title,
    String message, {
    VoidCallback? onRetry,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          if (onCancel != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onCancel();
              },
              child: const Text('Cancel'),
            ),
          if (onRetry != null)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRetry();
              },
              child: const Text('Retry'),
            ),
          if (onRetry == null && onCancel == null)
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
        ],
      ),
    );
  }

  /// Log error for debugging
  static void logError(String context, dynamic error, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('ERROR in $context: $error');
      if (stackTrace != null) {
        debugPrint('STACK TRACE: $stackTrace');
      }
    }
  }

  /// Handle network connectivity errors
  static String handleNetworkError(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('no internet') || errorString.contains('no connection')) {
      return 'No internet connection. Please check your network settings.';
    }

    if (errorString.contains('timeout')) {
      return 'Connection timed out. Please check your internet connection.';
    }

    if (errorString.contains('dns')) {
      return 'Cannot connect to server. Please check your internet connection.';
    }

    return 'Network error. Please check your internet connection and try again.';
  }

  /// Handle permission errors
  static String handlePermissionError(String permission) {
    switch (permission.toLowerCase()) {
      case 'location':
        return 'Location permission is required to show nearby attractions. Please enable it in settings.';
      case 'camera':
        return 'Camera permission is required to take photos. Please enable it in settings.';
      case 'microphone':
        return 'Microphone permission is required for voice features. Please enable it in settings.';
      case 'storage':
        return 'Storage permission is required to save files. Please enable it in settings.';
      default:
        return 'Permission is required for this feature. Please enable it in settings.';
    }
  }

  /// Handle API configuration errors
  static String handleApiConfigurationError(String service) {
    switch (service.toLowerCase()) {
      case 'openai':
        return 'AI assistant is not configured. Please contact support.';
      case 'google maps':
        return 'Map service is not configured. Please contact support.';
      case 'google translate':
        return 'Translation service is not configured. Please contact support.';
      case 'google cloud':
        return 'Voice service is not configured. Please contact support.';
      default:
        return 'Service is not configured. Please contact support.';
    }
  }

  /// Show configuration error dialog
  static void showConfigurationErrorDialog(BuildContext context, String service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.settings, color: Colors.orange),
            const SizedBox(width: 8),
            const Text('Configuration Required'),
          ],
        ),
        content: Text(handleApiConfigurationError(service)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Show permission error dialog with settings redirect
  static void showPermissionErrorDialog(
    BuildContext context,
    String permission, {
    VoidCallback? onOpenSettings,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.security, color: Colors.orange),
            const SizedBox(width: 8),
            const Text('Permission Required'),
          ],
        ),
        content: Text(handlePermissionError(permission)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          if (onOpenSettings != null)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onOpenSettings();
              },
              child: const Text('Open Settings'),
            ),
        ],
      ),
    );
  }
}

















































