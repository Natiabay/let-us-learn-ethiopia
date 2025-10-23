import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/constants/app_colors.dart';

/// Professional Duolingo-style button with animations
class DuolingoButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final DuolingoButtonType type;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double? height;

  const DuolingoButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = DuolingoButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
  });

  @override
  State<DuolingoButton> createState() => _DuolingoButtonState();
}

class _DuolingoButtonState extends State<DuolingoButton> {
  bool _isPressed = false;

  Color _getBackgroundColor() {
    switch (widget.type) {
      case DuolingoButtonType.primary:
        return AppColors.duolingoGreen;
      case DuolingoButtonType.secondary:
        return AppColors.duolingoBlue;
      case DuolingoButtonType.danger:
        return AppColors.duolingoRed;
      case DuolingoButtonType.success:
        return AppColors.duolingoYellow;
      case DuolingoButtonType.accent:
        return AppColors.duolingoPurple;
      case DuolingoButtonType.outline:
        return Colors.transparent;
    }
  }

  Color _getBorderColor() {
    switch (widget.type) {
      case DuolingoButtonType.outline:
        return AppColors.duolingoGreen;
      default:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    switch (widget.type) {
      case DuolingoButtonType.outline:
        return AppColors.duolingoGreen;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null || widget.isLoading;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: widget.width,
          height: widget.height ?? 56,
          decoration: BoxDecoration(
            color: isDisabled
                ? _getBackgroundColor().withValues(alpha: 0.5)
                : _getBackgroundColor(),
            borderRadius: BorderRadius.circular(16),
            border: widget.type == DuolingoButtonType.outline
                ? Border.all(color: _getBorderColor(), width: 2)
                : null,
            boxShadow: !isDisabled
                ? [
                    BoxShadow(
                      color: _getBackgroundColor().withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isDisabled ? null : widget.onPressed,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: widget.isLoading
                    ? Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.icon != null) ...[
                            Icon(
                              widget.icon,
                              color: _getTextColor(),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            widget.text,
                            style: TextStyle(
                              color: _getTextColor(),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0);
  }
}

enum DuolingoButtonType {
  primary, // Green
  secondary, // Blue
  danger, // Red
  success, // Yellow
  accent, // Purple
  outline, // Transparent with green border
}

