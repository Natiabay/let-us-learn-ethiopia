import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/onboarding_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/providers/onboarding_provider.dart';

/// Proficiency Level Screen - Choose current Amharic level
class ProficiencyScreen extends ConsumerWidget {
  const ProficiencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLevel = ref.watch(onboardingProvider).proficiencyLevel;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.push('/duolingo/onboarding/goals');
            },
            child: const Text(
              'SKIP',
              style: TextStyle(
                color: Color(0xFF58CC02),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'How much Amharic\ndo you know?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ).animate().fadeIn().slideY(begin: -0.3, end: 0),
              
              const SizedBox(height: 8),
              
              Text(
                'This helps us personalize your learning path',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 16,
                ),
              ).animate().fadeIn(delay: 100.ms),

              const SizedBox(height: 48),

              // Proficiency levels
              Expanded(
                child: ListView.builder(
                  itemCount: ProficiencyLevel.all.length,
                  itemBuilder: (context, index) {
                    final level = ProficiencyLevel.all[index];
                    final isSelected = selectedLevel == level.id;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildLevelCard(
                        context: context,
                        ref: ref,
                        level: level,
                        isSelected: isSelected,
                        delay: index * 100,
                      ),
                    );
                  },
                ),
              ),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: selectedLevel.isNotEmpty
                      ? () {
                          context.push('/duolingo/onboarding/goals');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF58CC02),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 400.ms),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard({
    required BuildContext context,
    required WidgetRef ref,
    required ProficiencyLevel level,
    required bool isSelected,
    required int delay,
  }) {
    // Icon based on level
    IconData icon;
    Color iconColor;
    
    switch (level.id) {
      case 'beginner':
        icon = Icons.emoji_people_rounded;
        iconColor = const Color(0xFF58CC02);
        break;
      case 'intermediate':
        icon = Icons.school_rounded;
        iconColor = const Color(0xFF1CB0F6);
        break;
      case 'advanced':
        icon = Icons.emoji_events_rounded;
        iconColor = const Color(0xFFFFD43B);
        break;
      default:
        icon = Icons.help_outline_rounded;
        iconColor = Colors.grey;
    }

    return InkWell(
      onTap: () {
        ref.read(onboardingProvider.notifier).setProficiencyLevel(level.id);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF58CC02).withValues(alpha: 0.2)
              : const Color(0xFF2A2A2A),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF58CC02)
                : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level.name,
                    style: TextStyle(
                      color: isSelected ? const Color(0xFF58CC02) : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    level.description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF58CC02),
                size: 28,
              ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: -0.3, end: 0);
  }
}

