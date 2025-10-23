import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Animated background widget with floating particles for visual enhancement
class AnimatedBackground extends StatelessWidget {
  final Widget child;
  final Color? primaryColor;
  final Color? secondaryColor;
  final bool showParticles;

  const AnimatedBackground({
    super.key,
    required this.child,
    this.primaryColor,
    this.secondaryColor,
    this.showParticles = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryColor ?? const Color(0xFF00D9B8),
                secondaryColor ?? const Color(0xFF1CB0F6),
              ],
            ),
          ),
        ),
        
        // Animated particles
        if (showParticles) ...[
          Positioned(
            top: 100,
            left: 50,
            child: _FloatingParticle(
              size: 60,
              color: Colors.white.withValues(alpha: 0.1),
              delay: 0.ms,
            ),
          ),
          Positioned(
            top: 200,
            right: 80,
            child: _FloatingParticle(
              size: 80,
              color: Colors.white.withValues(alpha: 0.08),
              delay: 500.ms,
            ),
          ),
          Positioned(
            bottom: 150,
            left: 100,
            child: _FloatingParticle(
              size: 100,
              color: Colors.white.withValues(alpha: 0.06),
              delay: 1000.ms,
            ),
          ),
          Positioned(
            bottom: 80,
            right: 50,
            child: _FloatingParticle(
              size: 70,
              color: Colors.white.withValues(alpha: 0.09),
              delay: 1500.ms,
            ),
          ),
        ],
        
        // Content
        child,
      ],
    );
  }
}

class _FloatingParticle extends StatelessWidget {
  final double size;
  final Color color;
  final Duration delay;

  const _FloatingParticle({
    required this.size,
    required this.color,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .moveY(
          begin: 0,
          end: -30,
          duration: 3000.ms,
          delay: delay,
          curve: Curves.easeInOut,
        )
        .then()
        .moveY(
          begin: -30,
          end: 0,
          duration: 3000.ms,
          curve: Curves.easeInOut,
        );
  }
}




