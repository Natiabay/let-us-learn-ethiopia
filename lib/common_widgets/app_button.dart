import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/core/constants/app_dimensions.dart';

/// Professional reusable button component following Material Design 3
/// Supports different button types and states for consistent UI
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.backgroundColor,
    this.textColor,
  });

  /// Primary button constructor
  const AppButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.backgroundColor,
    this.textColor,
  }) : type = AppButtonType.primary;

  /// Secondary button constructor
  const AppButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.backgroundColor,
    this.textColor,
  }) : type = AppButtonType.secondary;

  /// Outlined button constructor
  const AppButton.outlined({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.backgroundColor,
    this.textColor,
  }) : type = AppButtonType.outlined;

  /// Text button constructor
  const AppButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.backgroundColor,
    this.textColor,
  }) : type = AppButtonType.text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null && !isLoading;

    // Get button dimensions based on size
    final height = _getButtonHeight();
    final padding = _getButtonPadding();
    final textStyle = _getTextStyle(theme);

    // Build button content
    Widget buttonChild = _buildButtonContent(textStyle);

    // Wrap with SizedBox if full width
    if (isFullWidth) {
      buttonChild = SizedBox(
        width: double.infinity,
        height: height,
        child: buttonChild,
      );
    }

    // Return appropriate button type
    switch (type) {
      case AppButtonType.primary:
        return ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.duolingoGreen,
            foregroundColor: textColor ?? AppColors.duolingoTextPrimary,
            minimumSize: Size(0, height),
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
            ),
            elevation: 2,
            disabledBackgroundColor: AppColors.duolingoSurface,
            disabledForegroundColor: AppColors.duolingoTextDisabled,
          ),
          child: buttonChild,
        );

      case AppButtonType.secondary:
        return ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.duolingoBlue,
            foregroundColor: textColor ?? AppColors.duolingoTextPrimary,
            minimumSize: Size(0, height),
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
            ),
            elevation: 2,
            disabledBackgroundColor: AppColors.duolingoSurface,
            disabledForegroundColor: AppColors.duolingoTextDisabled,
          ),
          child: buttonChild,
        );

      case AppButtonType.outlined:
        return OutlinedButton(
          onPressed: isEnabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor ?? AppColors.duolingoGreen,
            minimumSize: Size(0, height),
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
            ),
            side: BorderSide(
              color: backgroundColor ?? AppColors.duolingoGreen,
              width: 1.5,
            ),
            disabledForegroundColor: AppColors.duolingoTextDisabled,
          ),
          child: buttonChild,
        );

      case AppButtonType.text:
        return TextButton(
          onPressed: isEnabled ? onPressed : null,
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? AppColors.duolingoGreen,
            minimumSize: Size(0, height),
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
            ),
            disabledForegroundColor: AppColors.duolingoTextDisabled,
          ),
          child: buttonChild,
        );
    }
  }

  Widget _buildButtonContent(TextStyle textStyle) {
    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor:               AlwaysStoppedAnimation<Color>(
                textColor ?? AppColors.duolingoTextPrimary,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spacing8),
          Text('Loading...', style: textStyle),
        ],
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _getIconSize()),
          const SizedBox(width: AppDimensions.spacing8),
          Text(text, style: textStyle),
        ],
      );
    }

    return Text(text, style: textStyle);
  }

  double _getButtonHeight() {
    switch (size) {
      case AppButtonSize.small:
        return AppDimensions.buttonHeightSmall;
      case AppButtonSize.medium:
        return AppDimensions.buttonHeight;
      case AppButtonSize.large:
        return AppDimensions.buttonHeightLarge;
    }
  }

  EdgeInsetsGeometry _getButtonPadding() {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing12,
          vertical: AppDimensions.spacing8,
        );
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing16,
          vertical: AppDimensions.spacing12,
        );
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing20,
          vertical: AppDimensions.spacing16,
        );
    }
  }

  TextStyle _getTextStyle(ThemeData theme) {
    switch (size) {
      case AppButtonSize.small:
        return theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ) ?? const TextStyle(fontWeight: FontWeight.w600);
      case AppButtonSize.medium:
        return theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ) ?? const TextStyle(fontWeight: FontWeight.w600);
      case AppButtonSize.large:
        return theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ) ?? const TextStyle(fontWeight: FontWeight.w600);
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return AppDimensions.iconSmall;
      case AppButtonSize.medium:
        return AppDimensions.iconMedium;
      case AppButtonSize.large:
        return AppDimensions.iconMedium;
    }
  }
}

/// Button type enumeration for different button styles
enum AppButtonType {
  primary,
  secondary,
  outlined,
  text,
}

/// Button size enumeration for consistent sizing
enum AppButtonSize {
  small,
  medium,
  large,
}
