import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

/// Learning Goals Screen for Language Learning Setup
/// Allows users to select their learning goals and motivation
class LearningGoalsScreen extends StatefulWidget {
  const LearningGoalsScreen({super.key});

  @override
  State<LearningGoalsScreen> createState() => _LearningGoalsScreenState();
}

class _LearningGoalsScreenState extends State<LearningGoalsScreen> {
  final List<String> _selectedGoals = [];

  final List<Map<String, dynamic>> _goals = [
    {
      'id': 'travel',
      'title': 'Travel',
      'description': 'I want to travel and communicate with locals',
      'icon': Icons.flight_rounded,
      'color': const Color(0xFF1CB0F6),
    },
    {
      'id': 'work',
      'title': 'Work',
      'description': 'I need it for my job or career',
      'icon': Icons.work_rounded,
      'color': const Color(0xFF58CC02),
    },
    {
      'id': 'education',
      'title': 'Education',
      'description': 'I\'m studying or want to study',
      'icon': Icons.school_rounded,
      'color': const Color(0xFFFF9600),
    },
    {
      'id': 'family',
      'title': 'Family',
      'description': 'I want to connect with family members',
      'icon': Icons.family_restroom_rounded,
      'color': const Color(0xFF9C27B0),
    },
    {
      'id': 'culture',
      'title': 'Culture',
      'description': 'I\'m interested in the culture',
      'icon': Icons.public_rounded,
      'color': const Color(0xFFE91E63),
    },
    {
      'id': 'challenge',
      'title': 'Challenge',
      'description': 'I love learning new languages',
      'icon': Icons.psychology_rounded,
      'color': const Color(0xFF607D8B),
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
          'Your Goals',
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
                'Why are you learning?',
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
                'Select all that apply (you can change this later)',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 16,
                ),
              ).animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideX(begin: -0.3, end: 0, delay: 400.ms),

              const SizedBox(height: 32),

              // Goals Grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _goals.length,
                  itemBuilder: (context, index) {
                    final goal = _goals[index];
                    final isSelected = _selectedGoals.contains(goal['id']);

                    return _buildGoalCard(
                      goal: goal,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedGoals.remove(goal['id']);
                          } else {
                            _selectedGoals.add(goal['id']);
                          }
                        });
                      },
                      delay: (index + 1) * 100,
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
                  onPressed: _selectedGoals.isNotEmpty
                      ? () {
                          // Navigate to preferences screen
                          context.push('/language/setup/preferences');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedGoals.isNotEmpty
                        ? const Color(0xFF58CC02)
                        : Colors.grey.withValues(alpha: 0.3),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _selectedGoals.isEmpty
                        ? 'Select at least one goal'
                        : 'Continue',
                    style: const TextStyle(
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

  Widget _buildGoalCard({
    required Map<String, dynamic> goal,
    required bool isSelected,
    required VoidCallback onTap,
    required int delay,
  }) {
    final color = goal['color'] as Color;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? color.withValues(alpha: 0.2)
                    : color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                goal['icon'],
                color: isSelected ? color : color.withValues(alpha: 0.6),
                size: 20,
              ),
            ),
            const SizedBox(height: 12),

            // Title
            Text(
              goal['title'],
              style: TextStyle(
                color: isSelected ? color : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),

            // Description
            Text(
              goal['description'],
              style: TextStyle(
                color: isSelected
                    ? color.withValues(alpha: 0.8)
                    : Colors.white70,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            // Selection Indicator
            if (isSelected)
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.check_circle_rounded,
                  color: color,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(delay: delay.ms, duration: 600.ms)
      .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0), delay: delay.ms);
  }
}
