import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/core/constants/app_dimensions.dart';

/// Professional list tile component for consistent list items
/// Provides various configurations for different use cases
class AppListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool enabled;
  final bool dense;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.enabled = true,
    this.dense = false,
    this.contentPadding,
    this.backgroundColor,
    this.borderRadius,
  });

  /// Avatar list tile constructor
  AppListTile.avatar({
    super.key,
    required this.title,
    this.subtitle,
    required String avatarText,
    Color? avatarColor,
    this.trailing,
    this.onTap,
    this.enabled = true,
    this.dense = false,
    this.contentPadding,
    this.backgroundColor,
    this.borderRadius,
  }) : leading = CircleAvatar(
         backgroundColor: avatarColor ?? AppColors.primary,
         child: Text(
           avatarText,
           style: const TextStyle(
             color: AppColors.textOnPrimary,
             fontWeight: FontWeight.w600,
           ),
         ),
       );

  /// Icon list tile constructor
  AppListTile.icon({
    super.key,
    required this.title,
    this.subtitle,
    required IconData icon,
    Color? iconColor,
    this.trailing,
    this.onTap,
    this.enabled = true,
    this.dense = false,
    this.contentPadding,
    this.backgroundColor,
    this.borderRadius,
  }) : leading = Icon(
         icon,
         color: iconColor ?? AppColors.primary,
         size: AppDimensions.iconMedium,
       );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget listTile = ListTile(
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: enabled ? AppColors.textPrimary : AppColors.textDisabled,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: enabled ? AppColors.textSecondary : AppColors.textDisabled,
              ),
            )
          : null,
      leading: leading,
      trailing: trailing,
      onTap: enabled ? onTap : null,
      dense: dense,
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing16,
            vertical: AppDimensions.spacing8,
          ),
      enabled: enabled,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      tileColor: backgroundColor,
    );

    if (backgroundColor != null || borderRadius != null) {
      return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        child: listTile,
      );
    }

    return listTile;
  }
}

/// Settings list tile with consistent styling
class AppSettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool enabled;

  const AppSettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
    this.trailing,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppListTile.icon(
      title: title,
      subtitle: subtitle,
      icon: icon,
      iconColor: enabled ? AppColors.primary : AppColors.textDisabled,
      trailing: trailing ??
          Icon(
            Icons.chevron_right_rounded,
            color: enabled ? AppColors.textSecondary : AppColors.textDisabled,
          ),
      onTap: onTap,
      enabled: enabled,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing20,
        vertical: AppDimensions.spacing12,
      ),
    );
  }
}

/// Menu list tile for navigation items
class AppMenuTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isSelected;
  final int? badge;

  const AppMenuTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
    this.isSelected = false,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing8,
        vertical: AppDimensions.spacing4,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryContainer : null,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: AppListTile.icon(
        title: title,
        subtitle: subtitle,
        icon: icon,
        iconColor: isSelected ? AppColors.primary : AppColors.textSecondary,
        trailing: badge != null && badge! > 0
            ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing8,
                  vertical: AppDimensions.spacing4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                ),
                child: Text(
                  badge.toString(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : null,
        onTap: onTap,
        backgroundColor: isSelected ? AppColors.primaryContainer : null,
      ),
    );
  }
}
