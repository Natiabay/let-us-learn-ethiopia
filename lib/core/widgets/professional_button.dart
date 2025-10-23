import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/professional_colors.dart';

/// Professional button matching reference app design
/// Vibrant turquoise button with perfect sizing and animations
class ProfessionalButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final ProfessionalButtonStyle style;
  final double? height;

  const ProfessionalButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.style = ProfessionalButtonStyle.primary,
    this.height,
  });

  @override
  State<ProfessionalButton> createState() => _ProfessionalButtonState();
}

class _ProfessionalButtonState extends State<ProfessionalButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  Color get _backgroundColor {
    if (widget.onPressed == null || widget.isLoading) {
      return widget.style.disabledColor;
    }
    if (_isPressed) {
      return widget.style.pressedColor;
    }
    return widget.style.backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    final buttonHeight = widget.height ?? ProfessionalDimensions.buttonHeightLG;

    Widget buttonChild = Container(
      height: buttonHeight,
      width: widget.isFullWidth ? double.infinity : null,
      padding: EdgeInsets.symmetric(
        horizontal: widget.isFullWidth 
            ? ProfessionalDimensions.spaceLG 
            : ProfessionalDimensions.spaceXL,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(ProfessionalDimensions.radiusMD),
        boxShadow: [
          if (widget.onPressed != null && !widget.isLoading)
            BoxShadow(
              color: widget.style.backgroundColor.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: widget.isLoading
          ? Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.style.textColor,
                  ),
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    color: widget.style.textColor,
                    size: ProfessionalDimensions.iconMD,
                  ),
                  const SizedBox(width: ProfessionalDimensions.spaceSM),
                ],
                Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.style.textColor,
                    fontSize: ProfessionalDimensions.fontMD,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
    );

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed != null && !widget.isLoading 
          ? widget.onPressed 
          : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: buttonChild,
      ),
    );
  }
}

enum ProfessionalButtonStyle {
  primary,
  secondary,
  outline,
  text,
}

extension ProfessionalButtonStyleExtension on ProfessionalButtonStyle {
  Color get backgroundColor {
    switch (this) {
      case ProfessionalButtonStyle.primary:
        return ProfessionalColors.primaryButton;
      case ProfessionalButtonStyle.secondary:
        return ProfessionalColors.backgroundCard;
      case ProfessionalButtonStyle.outline:
        return Colors.transparent;
      case ProfessionalButtonStyle.text:
        return Colors.transparent;
    }
  }

  Color get pressedColor {
    switch (this) {
      case ProfessionalButtonStyle.primary:
        return ProfessionalColors.primaryButtonPressed;
      case ProfessionalButtonStyle.secondary:
        return ProfessionalColors.backgroundSurface;
      case ProfessionalButtonStyle.outline:
        return ProfessionalColors.backgroundCard.withValues(alpha: 0.5);
      case ProfessionalButtonStyle.text:
        return ProfessionalColors.backgroundCard.withValues(alpha: 0.3);
    }
  }

  Color get disabledColor {
    return ProfessionalColors.backgroundCard;
  }

  Color get textColor {
    switch (this) {
      case ProfessionalButtonStyle.primary:
        return ProfessionalColors.textOnButton;
      case ProfessionalButtonStyle.secondary:
        return ProfessionalColors.textPrimary;
      case ProfessionalButtonStyle.outline:
        return ProfessionalColors.primaryButton;
      case ProfessionalButtonStyle.text:
        return ProfessionalColors.primaryButton;
    }
  }
}
