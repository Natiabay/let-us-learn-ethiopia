import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

/// Proficiency Level Screen for Language Learning Setup
/// Allows users to select their current proficiency level
class ProficiencyScreen extends StatefulWidget {
  const ProficiencyScreen({super.key});

  @override
  State<ProficiencyScreen> createState() => _ProficiencyScreenState();
}

class _ProficiencyScreenState extends State<ProficiencyScreen> {
  String? _selectedLevel;

  final List<Map<String, dynamic>> _levels = [
    {
      'id': 'beginner',
      'name': 'Beginner',
      'description': 'I\'m just starting out',
      'icon': Icons.rocket_launch_rounded,
      'color': const Color(0xFF58CC02),
    },
    {
      'id': 'elementary',
      'name': 'Elementary',
      'description': 'I know a few words',
      'icon': Icons.school_rounded,
      'color': const Color(0xFF1CB0F6),
    },
    {
      'id': 'intermediate',
      'name': 'Intermediate',
      'description': 'I can have basic conversations',
      'icon': Icons.trending_up_rounded,
      'color': const Color(0xFFFF9600),
    },
    {
      'id': 'advanced',
      'name': 'Advanced',
      'description': 'I\'m quite fluent',
      'icon': Icons.star_rounded,
      'color': const Color(0xFF9C27B0),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Your Level',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'What\'s your current level?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ).animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .slideX(begin: -0.3, end: 0, delay: 200.ms),

              const SizedBox(height: 8),

              Text(
                'This helps us personalize your learning experience',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 16,
                ),
              ).animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideX(begin: -0.3, end: 0, delay: 400.ms),

              const SizedBox(height: 32),

              // Level Options
              Expanded(
                child: ListView.builder(
                  itemCount: _levels.length,
                  itemBuilder: (context, index) {
                    final level = _levels[index];
                    final isSelected = _selectedLevel == level['id'];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildLevelCard(
                        level: level,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            _selectedLevel = level['id'];
                          });
                        },
                        delay: (index + 1) * 100,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedLevel != null
                      ? () {
                          // Navigate to learning goals screen
                          context.push('/language/setup/goals');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedLevel != null
                        ? const Color(0xFF58CC02)
                        : Colors.grey.withValues(alpha: 0.3),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ).animate()
                .fadeIn(delay: 1000.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, delay: 1000.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard({
    required Map<String, dynamic> level,
    required bool isSelected,
    required VoidCallback onTap,
    required int delay,
  }) {
    final color = level['color'] as Color;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.1)
              : const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? color.withValues(alpha: 0.2)
                    : color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                level['icon'],
                color: isSelected ? color : color.withValues(alpha: 0.6),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Level Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level['name'],
                    style: TextStyle(
                      color: isSelected ? color : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    level['description'],
                    style: TextStyle(
                      color: isSelected
                          ? color.withValues(alpha: 0.8)
                          : Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Selection Indicator
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: color,
                size: 24,
              ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(delay: delay.ms, duration: 600.ms)
      .slideX(begin: -0.3, end: 0, delay: delay.ms);
  }
}
