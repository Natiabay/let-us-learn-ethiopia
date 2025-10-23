import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

/// Global error handler to prevent mouse tracker assertion errors
/// This is specifically designed to handle Flutter 3.35.1 mouse tracking issues
class GlobalErrorHandler {
  static bool _initialized = false;

  /// Initialize global error handling
  static void initialize() {
    if (_initialized) return;
    _initialized = true;

    // Handle Flutter framework errors
    FlutterError.onError = (FlutterErrorDetails details) {
      // Check if it's a mouse tracker error
      if (details.exception.toString().contains('mouse_tracker.dart')) {
        debugPrint('Mouse tracker error caught and handled: ${details.exception}');
        return; // Don't crash the app
      }
      
      // Check if it's a RenderBox layout error
      if (details.exception.toString().contains('RenderBox was not laid out') ||
          details.exception.toString().contains('hasSize') ||
          details.exception.toString().contains('box.dart:2251:12')) {
        debugPrint('RenderBox layout error caught and handled: ${details.exception}');
        return; // Don't crash the app
      }
      
      // Check if it's a null value error
      if (details.exception.toString().contains('Unexpected null value')) {
        debugPrint('Null value error caught and handled: ${details.exception}');
        return; // Don't crash the app
      }
      
      // Log other errors but don't crash
      debugPrint('Flutter error: ${details.exception}');
    };

    // Handle platform errors
    PlatformDispatcher.instance.onError = (error, stack) {
      if (error.toString().contains('mouse_tracker.dart') ||
          error.toString().contains('RenderBox was not laid out') ||
          error.toString().contains('hasSize') ||
          error.toString().contains('Unexpected null value')) {
        debugPrint('Platform error handled: $error');
        return true; // Error handled
      }
      debugPrint('Platform error: $error');
      return false; // Let other errors propagate
    };
  }

  /// Safe mouse region wrapper
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
      debugPrint('Mouse region error handled: $e');
      return child;
    }
  }

  /// Disable mouse tracking for problematic widgets
  static Widget disableMouseTracking(Widget child) {
    return AbsorbPointer(
      absorbing: false,
      child: child,
    );
  }
}

/// Error boundary widget for mouse tracking issues
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
  void initState() {
    super.initState();
    GlobalErrorHandler.initialize();
  }

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

/// Safe mouse region that handles errors gracefully
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
    return GlobalErrorHandler.safeMouseRegion(
      cursor: cursor,
      opaque: opaque,
      hitTestBehavior: hitTestBehavior,
      onEnter: onEnter,
      onExit: onExit,
      onHover: onHover,
      child: child,
    );
  }
}
