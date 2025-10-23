import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

/// Reusable card widget with consistent styling across the app
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? elevation;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final Border? border;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.elevation,
    this.borderRadius,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? AppColors.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        border: border ?? Border.all(
          color: AppColors.grey200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: elevation != null ? elevation! * 0.05 : 0.05),
            blurRadius: elevation ?? 10,
            offset: Offset(0, (elevation ?? 10) / 4),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: cardContent,
      );
    }

    return cardContent;
  }
}




