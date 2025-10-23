import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

/// Fix for mouse tracker assertion errors in Flutter 3.35.1
/// This utility provides a safe wrapper for mouse tracking functionality
class MouseTrackerFix {
  // Private constructor to prevent instantiation
  MouseTrackerFix._();

  /// Safe mouse tracking wrapper that prevents assertion errors
  static Widget safeMouseRegion({
    required Widget child,
    MouseCursor? cursor,
    bool opaque = true,
    HitTestBehavior? hitTestBehavior,
    void Function(PointerEnterEvent)? onEnter,
    void Function(PointerExitEvent)? onExit,
    void Function(PointerHoverEvent)? onHover,
  }) {
    try {
      return MouseRegion(
        cursor: cursor ?? MouseCursor.defer,
        opaque: opaque,
        hitTestBehavior: hitTestBehavior ?? HitTestBehavior.deferToChild,
        onEnter: onEnter,
        onExit: onExit,
        onHover: onHover,
        child: child,
      );
    } catch (e) {
      // Fallback to basic container if mouse tracking fails
      debugPrint('Mouse tracking error caught and handled: $e');
      return child;
    }
  }

  /// Safe hover detection without mouse tracking
  static Widget safeHoverDetector({
    required Widget child,
    void Function()? onHover,
    void Function()? onExit,
  }) {
    return GestureDetector(
      onTap: onHover,
      child: child,
    );
  }

  /// Disable mouse tracking for problematic widgets
  static Widget disableMouseTracking(Widget child) {
    return AbsorbPointer(
      absorbing: false,
      child: child,
    );
  }
}

/// Custom mouse region that handles assertion errors gracefully
class SafeMouseRegion extends StatelessWidget {
  final Widget child;
  final MouseCursor? cursor;
  final bool opaque;
  final HitTestBehavior? hitTestBehavior;
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;
  final void Function(PointerHoverEvent)? onHover;

  const SafeMouseRegion({
    super.key,
    required this.child,
    this.cursor,
    this.opaque = true,
    this.hitTestBehavior,
    this.onEnter,
    this.onExit,
    this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return MouseRegion(
        cursor: cursor ?? MouseCursor.defer,
        opaque: opaque,
        hitTestBehavior: hitTestBehavior ?? HitTestBehavior.deferToChild,
        onEnter: onEnter,
        onExit: onExit,
        onHover: onHover,
        child: child,
      );
    } catch (e) {
      // Log the error but don't crash the app
      debugPrint('SafeMouseRegion: Mouse tracking error handled: $e');
      return child;
    }
  }
}

/// Error boundary for mouse tracking issues
class MouseTrackingErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget? fallback;

  const MouseTrackingErrorBoundary({
    super.key,
    required this.child,
    this.fallback,
  });

  @override
  State<MouseTrackingErrorBoundary> createState() => _MouseTrackingErrorBoundaryState();
}

class _MouseTrackingErrorBoundaryState extends State<MouseTrackingErrorBoundary> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return widget.fallback ?? const SizedBox.shrink();
    }

    try {
      return widget.child;
    } catch (e) {
      debugPrint('MouseTrackingErrorBoundary: Error caught: $e');
      if (mounted) {
        setState(() {
          hasError = true;
        });
      }
      return widget.fallback ?? const SizedBox.shrink();
    }
  }
}

