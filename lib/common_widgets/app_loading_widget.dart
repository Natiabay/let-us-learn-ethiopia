import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/core/constants/app_dimensions.dart';
import 'package:tourist_assistive_app/core/constants/app_strings.dart';

/// Professional loading widget with different states and animations
/// Provides consistent loading experience across the app
class AppLoadingWidget extends StatelessWidget {
  final String? message;
  final AppLoadingType type;
  final Color? color;
  final double? size;

  const AppLoadingWidget({
    super.key,
    this.message,
    this.type = AppLoadingType.circular,
    this.color,
    this.size,
  });

  /// Circular loading indicator
  const AppLoadingWidget.circular({
    super.key,
    this.message,
    this.color,
    this.size,
  }) : type = AppLoadingType.circular;

  /// Linear loading indicator
  const AppLoadingWidget.linear({
    super.key,
    this.message,
    this.color,
    this.size,
  }) : type = AppLoadingType.linear;

  /// Full screen loading overlay
  const AppLoadingWidget.overlay({
    super.key,
    this.message,
    this.color,
    this.size,
  }) : type = AppLoadingType.overlay;

  /// Small inline loading indicator
  const AppLoadingWidget.small({
    super.key,
    this.message,
    this.color,
    this.size = 16.0,
  }) : type = AppLoadingType.circular;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loadingColor = color ?? AppColors.primary;

    switch (type) {
      case AppLoadingType.circular:
        return _buildCircularLoading(theme, loadingColor);
      case AppLoadingType.linear:
        return _buildLinearLoading(theme, loadingColor);
      case AppLoadingType.overlay:
        return _buildOverlayLoading(theme, loadingColor);
    }
  }

  Widget _buildCircularLoading(ThemeData theme, Color loadingColor) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size ?? 40.0,
            height: size ?? 40.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
              strokeWidth: 3.0,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: AppDimensions.spacing16),
            Text(
              message!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.duolingoTextSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLinearLoading(ThemeData theme, Color loadingColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
          backgroundColor: AppColors.duolingoBorder,
        ),
        if (message != null) ...[
          const SizedBox(height: AppDimensions.spacing12),
          Text(
            message!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.duolingoTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  Widget _buildOverlayLoading(ThemeData theme, Color loadingColor) {
    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.spacing24),
          decoration: BoxDecoration(
            color: AppColors.duolingoCard,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: AppDimensions.shadowBlurRadius,
                offset: const Offset(0, AppDimensions.shadowOffsetY),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: size ?? 40.0,
                height: size ?? 40.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
                  strokeWidth: 3.0,
                ),
              ),
              const SizedBox(height: AppDimensions.spacing16),
              Text(
                message ?? AppStrings.loadingText,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.duolingoTextPrimary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Loading type enumeration for different loading states
enum AppLoadingType {
  circular,
  linear,
  overlay,
}

/// Shimmer loading effect for list items and cards
class AppShimmerWidget extends StatefulWidget {
  final Widget child;
  final bool isLoading;

  const AppShimmerWidget({
    super.key,
    required this.child,
    this.isLoading = true,
  });

  @override
  State<AppShimmerWidget> createState() => _AppShimmerWidgetState();
}

class _AppShimmerWidgetState extends State<AppShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    if (widget.isLoading) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(AppShimmerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _animationController.repeat();
      } else {
        _animationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                AppColors.duolingoBorder,
                AppColors.duolingoSurface,
                AppColors.duolingoBorder,
              ],
              stops: [
                (_animation.value - 1).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 1).clamp(0.0, 1.0),
              ],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}
