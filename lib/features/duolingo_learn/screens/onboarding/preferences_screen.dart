import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/providers/onboarding_provider.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/providers/progress_provider.dart';

/// Preferences Screen - Final onboarding step with user preferences
class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({super.key});

  @override
  ConsumerState<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    final onboarding = ref.watch(onboardingProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
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
                'Customize your\nexperience',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ).animate().fadeIn().slideY(begin: -0.3, end: 0),
              
              const SizedBox(height: 8),
              
              Text(
                'Set your learning preferences',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 16,
                ),
              ).animate().fadeIn(delay: 100.ms),

              const SizedBox(height: 32),

              // Preferences list
              Expanded(
                child: ListView(
                  children: [
                    // Daily Goal
                    _buildSection(
                      title: 'Daily Goal',
                      subtitle: 'How much XP per day?',
                      delay: 200,
                      child: Column(
                        children: [
                          _buildGoalOption(
                            context: context,
                            title: 'Casual',
                            subtitle: '20 XP/day (5 minutes)',
                            xp: 20,
                            selected: onboarding.dailyGoalXP == 20,
                          ),
                          const SizedBox(height: 12),
                          _buildGoalOption(
                            context: context,
                            title: 'Regular',
                            subtitle: '50 XP/day (10 minutes)',
                            xp: 50,
                            selected: onboarding.dailyGoalXP == 50,
                          ),
                          const SizedBox(height: 12),
                          _buildGoalOption(
                            context: context,
                            title: 'Serious',
                            subtitle: '100 XP/day (15 minutes)',
                            xp: 100,
                            selected: onboarding.dailyGoalXP == 100,
                          ),
                          const SizedBox(height: 12),
                          _buildGoalOption(
                            context: context,
                            title: 'Intense',
                            subtitle: '200 XP/day (30 minutes)',
                            xp: 200,
                            selected: onboarding.dailyGoalXP == 200,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Transliteration
                    _buildSection(
                      title: 'Transliteration',
                      subtitle: 'Show pronunciation guide',
                      delay: 300,
                      child: _buildToggle(
                        title: 'Always show transliteration',
                        subtitle: 'Display "selam/ሰላም" format',
                        value: onboarding.showTransliteration,
                        onChanged: (value) {
                          ref.read(onboardingProvider.notifier)
                              .toggleTransliteration(value);
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Subtitles
                    _buildSection(
                      title: 'Audio Subtitles',
                      subtitle: 'Show text during audio playback',
                      delay: 400,
                      child: _buildToggle(
                        title: 'Enable subtitles',
                        subtitle: 'Display text when audio plays',
                        value: onboarding.enableSubtitles,
                        onChanged: (value) {
                          ref.read(onboardingProvider.notifier)
                              .toggleSubtitles(value);
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Notifications
                    _buildSection(
                      title: 'Reminders',
                      subtitle: 'Stay motivated with practice reminders',
                      delay: 500,
                      child: _buildToggle(
                        title: 'Enable notifications',
                        subtitle: 'Get daily reminders to practice',
                        value: onboarding.notificationsEnabled,
                        onChanged: (value) {
                          ref.read(onboardingProvider.notifier)
                              .toggleNotifications(value);
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Voice preference
                    _buildSection(
                      title: 'Voice Preference',
                      subtitle: 'Choose your preferred narrator',
                      delay: 600,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildVoiceOption(
                              context: context,
                              title: 'Female',
                              icon: Icons.woman_rounded,
                              selected: onboarding.preferredVoice == 'female',
                              onTap: () {
                                ref.read(onboardingProvider.notifier)
                                    .setPreferredVoice('female');
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildVoiceOption(
                              context: context,
                              title: 'Male',
                              icon: Icons.man_rounded,
                              selected: onboarding.preferredVoice == 'male',
                              onTap: () {
                                ref.read(onboardingProvider.notifier)
                                    .setPreferredVoice('male');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Finish button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    // Complete onboarding
                    await ref.read(onboardingProvider.notifier).completeOnboarding();
                    
                    // Set daily goal in progress
                    await ref.read(progressProvider.notifier)
                        .setDailyGoal(onboarding.dailyGoalXP);
                    
                    // Navigate to dashboard
                    if (context.mounted) {
                      context.go('/duolingo/dashboard');
                    }
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
                    'START LEARNING',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 700.ms),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required int delay,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    ).animate().fadeIn(delay: delay.ms).slideX(begin: -0.3, end: 0);
  }

  Widget _buildGoalOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required int xp,
    required bool selected,
  }) {
    return InkWell(
      onTap: () {
        ref.read(onboardingProvider.notifier).setDailyGoalXP(xp);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF58CC02).withValues(alpha: 0.2)
              : const Color(0xFF2A2A2A),
          border: Border.all(
            color: selected ? const Color(0xFF58CC02) : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: selected ? const Color(0xFF58CC02) : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF58CC02),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggle({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
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
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF58CC02),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceOption({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF58CC02).withValues(alpha: 0.2)
              : const Color(0xFF2A2A2A),
          border: Border.all(
            color: selected ? const Color(0xFF58CC02) : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: selected ? const Color(0xFF58CC02) : Colors.white,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: selected ? const Color(0xFF58CC02) : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

