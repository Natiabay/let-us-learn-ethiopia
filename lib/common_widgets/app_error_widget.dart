import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/core/constants/app_dimensions.dart';
import 'package:tourist_assistive_app/core/constants/app_strings.dart';
import 'package:tourist_assistive_app/common_widgets/app_button.dart';

/// Professional error widget with retry functionality
/// Provides consistent error handling UI across the app
class AppErrorWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onRetry;
  final IconData? icon;
  final AppErrorType type;

  const AppErrorWidget({
    super.key,
    this.title,
    this.message,
    this.onRetry,
    this.icon,
    this.type = AppErrorType.general,
  });

  /// Network error constructor
  const AppErrorWidget.network({
    super.key,
    this.title = 'Connection Error',
    this.message = AppStrings.networkError,
    this.onRetry,
  }) : type = AppErrorType.network,
       icon = Icons.wifi_off_rounded;

  /// Not found error constructor
  const AppErrorWidget.notFound({
    super.key,
    this.title = 'Not Found',
    this.message = 'The content you\'re looking for doesn\'t exist.',
    this.onRetry,
  }) : type = AppErrorType.notFound,
       icon = Icons.search_off_rounded;

  /// Permission error constructor
  const AppErrorWidget.permission({
    super.key,
    this.title = 'Permission Required',
    this.message = AppStrings.permissionError,
    this.onRetry,
  }) : type = AppErrorType.permission,
       icon = Icons.lock_outline_rounded;

  /// Empty state constructor
  const AppErrorWidget.empty({
    super.key,
    this.title = 'Nothing Here',
    this.message = 'No content available at the moment.',
    this.onRetry,
  }) : type = AppErrorType.empty,
       icon = Icons.inbox_outlined;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorIcon = _getErrorIcon();
    final errorColor = _getErrorColor();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: errorColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                errorIcon,
                size: AppDimensions.iconXLarge,
                color: errorColor,
              ),
            ),
            
            const SizedBox(height: AppDimensions.spacing24),
            
            // Error Title
            if (title != null)
              Text(
                title!,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.duolingoTextPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            
            if (title != null && message != null)
              const SizedBox(height: AppDimensions.spacing12),
            
            // Error Message
            if (message != null)
              Text(
                message!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.duolingoTextSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            
            // Retry Button
            if (onRetry != null) ...[
              const SizedBox(height: AppDimensions.spacing32),
              AppButton.primary(
                text: AppStrings.retryText,
                onPressed: onRetry,
                icon: Icons.refresh_rounded,
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getErrorIcon() {
    if (icon != null) return icon!;
    
    switch (type) {
      case AppErrorType.network:
        return Icons.wifi_off_rounded;
      case AppErrorType.notFound:
        return Icons.search_off_rounded;
      case AppErrorType.permission:
        return Icons.lock_outline_rounded;
      case AppErrorType.empty:
        return Icons.inbox_outlined;
      case AppErrorType.general:
        return Icons.error_outline_rounded;
    }
  }

  Color _getErrorColor() {
    switch (type) {
      case AppErrorType.network:
        return AppColors.secondary;
      case AppErrorType.notFound:
        return AppColors.textSecondary;
      case AppErrorType.permission:
        return AppColors.accent;
      case AppErrorType.empty:
        return AppColors.textTertiary;
      case AppErrorType.general:
        return AppColors.accent;
    }
  }
}

/// Error type enumeration for different error states
enum AppErrorType {
  general,
  network,
  notFound,
  permission,
  empty,
}

/// Inline error message widget for forms and inputs
class AppInlineError extends StatelessWidget {
  final String message;
  final IconData? icon;

  const AppInlineError({
    super.key,
    required this.message,
    this.icon = Icons.error_outline_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.spacing8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: AppDimensions.iconSmall,
              color: AppColors.duolingoRed,
            ),
            const SizedBox(width: AppDimensions.spacing8),
          ],
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.duolingoRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Success message widget for positive feedback
class AppSuccessWidget extends StatelessWidget {
  final String message;
  final IconData? icon;
  final VoidCallback? onDismiss;

  const AppSuccessWidget({
    super.key,
    required this.message,
    this.icon = Icons.check_circle_outline_rounded,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing16),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: AppDimensions.iconMedium,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppDimensions.spacing12),
          ],
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onDismiss != null) ...[
            const SizedBox(width: AppDimensions.spacing8),
            IconButton(
              onPressed: onDismiss,
              icon: const Icon(Icons.close_rounded),
              iconSize: AppDimensions.iconSmall,
              color: AppColors.primary,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ],
      ),
    );
  }
}
