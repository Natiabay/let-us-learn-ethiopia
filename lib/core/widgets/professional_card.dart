import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/professional_colors.dart';

/// Professional card matching reference app design
/// Navy blue cards with proper spacing and rounded corners
class ProfessionalCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool withShadow;

  const ProfessionalCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.withShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: margin ?? const EdgeInsets.symmetric(
        horizontal: ProfessionalDimensions.spaceMD,
        vertical: ProfessionalDimensions.spaceSM,
      ),
      padding: padding ?? const EdgeInsets.all(ProfessionalDimensions.spaceLG),
      decoration: BoxDecoration(
        color: ProfessionalColors.backgroundCard,
        borderRadius: BorderRadius.circular(ProfessionalDimensions.radiusLG),
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: ProfessionalColors.shadowMedium,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ProfessionalDimensions.radiusLG),
          child: card,
        ),
      );
    }

    return card;
  }
}

