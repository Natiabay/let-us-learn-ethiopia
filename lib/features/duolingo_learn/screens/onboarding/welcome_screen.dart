import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

/// Welcome Screen - First screen in onboarding flow
/// Inspired by Duolingo's welcoming, colorful design
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // Dark background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top spacing
              const SizedBox(height: 40),

              // Main content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo/Icon
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFF58CC02), // Duolingo green
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF58CC02).withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        size: 70,
                        color: Colors.white,
                      ),
                    ).animate()
                      .scale(duration: 600.ms, curve: Curves.elasticOut)
                      .then(delay: 200.ms)
                      .shimmer(duration: 1000.ms),

                    const SizedBox(height: 40),

                    // Welcome text
                    const Text(
                      'Welcome to',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate().fadeIn(delay: 300.ms),

                    const SizedBox(height: 8),

                    const Text(
                      'Amharic Learning',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 16),

                    Text(
                      'Learn Amharic the fun way!\nStart your journey in Ethiopian language.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ).animate().fadeIn(delay: 500.ms),

                    const SizedBox(height: 40),

                    // Features list
                    _buildFeature(
                      icon: Icons.emoji_events_rounded,
                      title: 'Gamified Learning',
                      description: 'Earn XP, level up, and compete',
                      delay: 600,
                    ),
                    const SizedBox(height: 16),
                    _buildFeature(
                      icon: Icons.record_voice_over_rounded,
                      title: 'Native Pronunciation',
                      description: 'Learn with audio from native speakers',
                      delay: 700,
                    ),
                    const SizedBox(height: 16),
                    _buildFeature(
                      icon: Icons.photo_library_rounded,
                      title: 'Visual Learning',
                      description: 'Learn with real images and context',
                      delay: 800,
                    ),
                  ],
                ),
              ),

              // Bottom button
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to language selection
                        context.push('/duolingo/onboarding/language');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF58CC02),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'GET STARTED',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Skip onboarding
                      context.go('/duolingo/dashboard');
                    },
                    child: Text(
                      'I already know some Amharic',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                    ),
                  ).animate().fadeIn(delay: 1000.ms),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature({
    required IconData icon,
    required String title,
    required String description,
    required int delay,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF58CC02),
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.3, end: 0);
  }
}

