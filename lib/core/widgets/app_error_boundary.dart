import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';

class AppErrorBoundary extends StatefulWidget {
  final Widget child;

  const AppErrorBoundary({super.key, required this.child});

  @override
  State<AppErrorBoundary> createState() => _AppErrorBoundaryState();
}

class _AppErrorBoundaryState extends State<AppErrorBoundary> {
  bool hasError = false;
  String? errorMessage;
  StackTrace? stackTrace;

  @override
  void initState() {
    super.initState();

    // Catch Flutter errors
    FlutterError.onError = (FlutterErrorDetails details) {
      // Ignore mouse tracker errors and layout errors as they're common on web
      if (details.toString().contains('mouse_tracker') ||
          details.toString().contains('_debugDuringDeviceUpdate') ||
          details.toString().contains('Cannot hit test a render box that has never been laid out') ||
          details.toString().contains('NEEDS-LAYOUT NEEDS-PAINT') ||
          details.exceptionAsString().contains('!_debugDuringDeviceUpdate is not true') ||
          details.exceptionAsString().contains('mouse_tracker')) {
        print('⚠️  Mouse tracker/layout error (ignored): ${details.toString()}');
        return;
      }

      // Defer setState to avoid calling it during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            hasError = true;
            errorMessage = details.toString();
            stackTrace = details.stack;
          });
        }
      });

      // Log the error
      print('❌ Flutter Error: ${details.toString()}');
      print('Stack trace: ${details.stack}');
    };

    // Catch platform errors
    PlatformDispatcher.instance.onError = (error, stack) {
      // Ignore mouse tracker errors and layout errors
      if (error.toString().contains('mouse_tracker') ||
          error.toString().contains('_debugDuringDeviceUpdate') ||
          error.toString().contains('Cannot hit test a render box that has never been laid out') ||
          error.toString().contains('NEEDS-LAYOUT NEEDS-PAINT') ||
          error.toString().contains('!_debugDuringDeviceUpdate is not true')) {
        print('⚠️  Mouse tracker/layout error (ignored): ${error.toString()}');
        return true;
      }

      // Defer setState to avoid calling it during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            hasError = true;
            errorMessage = error.toString();
            stackTrace = stack;
          });
        }
      });

      print('❌ Platform Error: ${error.toString()}');
      print('Stack trace: $stack');

      return true;
    };
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return _buildErrorScreen();
    }

    return widget.child;
  }

  Widget _buildErrorScreen() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Error Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF4B4B).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.error_outline_rounded,
                    color: Color(0xFFFF4B4B),
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),

                // Error Title
                const Text(
                  'Something went wrong',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Error Message
                Text(
                  'We encountered an unexpected error. Please try again.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Retry Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        hasError = false;
                        errorMessage = null;
                        stackTrace = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF58CC02),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Restart Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      // Force restart the app
                      SystemNavigator.pop();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Restart App',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Debug Info (only in debug mode)
                if (kDebugMode) ...[
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Debug Information:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          errorMessage ?? 'No error message',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
