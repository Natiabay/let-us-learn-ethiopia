import 'package:flutter/material.dart';

/// Centralized error handling utility for consistent error display and logging
class ErrorHandler {
  /// Show a snackbar with error message
  static void showErrorSnackBar(BuildContext context, String message, {Duration? duration}) {
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: duration ?? const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// Show a snackbar with success message
  static void showSuccessSnackBar(BuildContext context, String message, {Duration? duration}) {
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show a snackbar with info message
  static void showInfoSnackBar(BuildContext context, String message, {Duration? duration}) {
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show an error dialog
  static void showErrorDialog(
    BuildContext context,
    String title,
    String message, {
    VoidCallback? onDismiss,
  }) {
    if (!context.mounted) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(width: 8),
            Expanded(child: Text(title)),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDismiss?.call();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Handle generic errors with logging and user notification
  static void handleGenericError(
    BuildContext context,
    Object error, {
    String? customMessage,
    bool showDialog = false,
  }) {
    final message = customMessage ?? 'An unexpected error occurred: ${error.toString()}';
    
    // Log the error (in production, this would go to a logging service)
    debugPrint('ERROR: $message');
    debugPrint('Stack trace: ${StackTrace.current}');
    
    if (!context.mounted) return;
    
    if (showDialog) {
      showErrorDialog(context, 'Error', message);
    } else {
      showErrorSnackBar(context, message);
    }
  }

  /// Handle network errors
  static void handleNetworkError(BuildContext context, {String? customMessage}) {
    final message = customMessage ?? 'Network error. Please check your internet connection.';
    showErrorSnackBar(context, message);
  }

  /// Handle authentication errors
  static void handleAuthError(BuildContext context, String error, {String? customMessage}) {
    final message = customMessage ?? 'Authentication error: $error';
    showErrorSnackBar(context, message);
  }

  /// Handle Firebase errors with user-friendly messages
  static void handleFirebaseError(BuildContext context, String errorCode, {String? customMessage}) {
    String message;
    
    switch (errorCode) {
      case 'user-not-found':
        message = 'No user found with this email.';
        break;
      case 'wrong-password':
        message = 'Incorrect password.';
        break;
      case 'email-already-in-use':
        message = 'This email is already registered.';
        break;
      case 'weak-password':
        message = 'Password is too weak. Please use a stronger password.';
        break;
      case 'invalid-email':
        message = 'Invalid email address.';
        break;
      case 'network-request-failed':
        message = 'Network error. Please check your connection.';
        break;
      case 'too-many-requests':
        message = 'Too many requests. Please try again later.';
        break;
      default:
        message = customMessage ?? 'An error occurred: $errorCode';
    }
    
    showErrorSnackBar(context, message);
  }
}




