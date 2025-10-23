import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/onboarding_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/providers/onboarding_provider.dart';

/// Learning Goals Screen - Choose why you want to learn Amharic
class LearningGoalsScreen extends ConsumerWidget {
  const LearningGoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGoals = ref.watch(onboardingProvider).learningGoals;

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
              context.push('/duolingo/onboarding/preferences');
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
                'Why are you\nlearning Amharic?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ).animate().fadeIn().slideY(begin: -0.3, end: 0),
              
              const SizedBox(height: 8),
              
              Text(
                'Select all that apply',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 16,
                ),
              ).animate().fadeIn(delay: 100.ms),

              const SizedBox(height: 32),

              // Goals grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: LearningGoal.all.length,
                  itemBuilder: (context, index) {
                    final goal = LearningGoal.all[index];
                    final isSelected = selectedGoals.contains(goal.id);

                    return _buildGoalCard(
                      context: context,
                      ref: ref,
                      goal: goal,
                      isSelected: isSelected,
                      delay: index * 50,
                    );
                  },
                ),
              ),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: selectedGoals.isNotEmpty
                      ? () {
                          context.push('/duolingo/onboarding/preferences');
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

  Widget _buildGoalCard({
    required BuildContext context,
    required WidgetRef ref,
    required LearningGoal goal,
    required bool isSelected,
    required int delay,
  }) {
    return InkWell(
      onTap: () {
        if (isSelected) {
          ref.read(onboardingProvider.notifier).removeLearningGoal(goal.id);
        } else {
          ref.read(onboardingProvider.notifier).addLearningGoal(goal.id);
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Emoji/Icon
            Text(
              goal.icon,
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 12),
            // Goal name
            Text(
              goal.name,
              style: TextStyle(
                color: isSelected ? const Color(0xFF58CC02) : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Check icon
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF58CC02),
                size: 20,
              ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }
}

