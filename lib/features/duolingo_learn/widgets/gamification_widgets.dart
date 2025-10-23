import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Reusable Gamification Widgets for Duolingo-style Learning

/// XP Gain Animation - Shows floating XP when earned
class XPGainAnimation extends StatelessWidget {
  final int xp;
  final VoidCallback? onComplete;

  const XPGainAnimation({
    super.key,
    required this.xp,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD43B),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD43B).withValues(alpha: 0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star_rounded,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              '+$xp XP',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      )
          .animate(onComplete: (_) => onComplete?.call())
          .scale(duration: 300.ms, curve: Curves.elasticOut)
          .then(delay: 1000.ms)
          .fadeOut(duration: 300.ms)
          .slideY(begin: 0, end: -0.5),
    );
  }
}

/// Level Up Celebration - Shows when user levels up
class LevelUpCelebration extends StatelessWidget {
  final int newLevel;
  final VoidCallback? onComplete;

  const LevelUpCelebration({
    super.key,
    required this.newLevel,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.8),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.emoji_events_rounded,
              color: Color(0xFFFFD43B),
              size: 100,
            ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
            const SizedBox(height: 24),
            const Text(
              'LEVEL UP!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.5, end: 0),
            const SizedBox(height: 16),
            Text(
              'You reached Level $newLevel',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ).animate(delay: 500.ms).fadeIn(),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: onComplete,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF58CC02),
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'CONTINUE',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ).animate(delay: 700.ms).fadeIn().slideY(begin: 0.3, end: 0),
          ],
        ),
      ),
    );
  }
}

/// Streak Flame Icon with Animation
class StreakFlame extends StatelessWidget {
  final int days;
  final bool isActive;

  const StreakFlame({
    super.key,
    required this.days,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFFFF9600).withValues(alpha: 0.2)
            : Colors.grey.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive
              ? const Color(0xFFFF9600)
              : Colors.grey,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            color: isActive ? const Color(0xFFFF9600) : Colors.grey,
            size: 32,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$days',
                style: TextStyle(
                  color: isActive ? const Color(0xFFFF9600) : Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'day${days != 1 ? "s" : ""}',
                style: TextStyle(
                  color: isActive ? const Color(0xFFFF9600) : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate(target: isActive ? 1 : 0).shimmer(duration: 2000.ms);
  }
}

/// Hearts Display with Animation
class HeartsDisplay extends StatelessWidget {
  final int current;
  final int max;

  const HeartsDisplay({
    super.key,
    required this.current,
    this.max = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(max, (index) {
        final isFilled = index < current;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Icon(
            isFilled ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: isFilled ? const Color(0xFFFF4B4B) : Colors.grey,
            size: 24,
          ),
        ).animate(delay: (index * 100).ms).scale();
      }),
    );
  }
}

/// Progress Ring - Circular progress indicator
class ProgressRing extends StatelessWidget {
  final double progress;
  final double size;
  final Color color;
  final Widget? child;

  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 120,
    this.color = const Color(0xFF58CC02),
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Background circle
          CircularProgressIndicator(
            value: 1.0,
            strokeWidth: 8,
            valueColor: AlwaysStoppedAnimation<Color>(
              color.withValues(alpha: 0.2),
            ),
          ),
          // Progress circle
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 8,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
          // Center content
          if (child != null)
            Center(child: child),
        ],
      ),
    );
  }
}

/// Achievement Badge
class AchievementBadge extends StatelessWidget {
  final String name;
  final String description;
  final String icon;
  final int xpReward;
  final bool isUnlocked;
  final VoidCallback? onTap;

  const AchievementBadge({
    super.key,
    required this.name,
    required this.description,
    required this.icon,
    this.xpReward = 0,
    this.isUnlocked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUnlocked
              ? const Color(0xFF58CC02).withValues(alpha: 0.2)
              : const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUnlocked
                ? const Color(0xFF58CC02)
                : Colors.grey.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              icon,
              style: TextStyle(
                fontSize: 48,
                color: isUnlocked ? null : Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                color: isUnlocked ? Colors.white : Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: isUnlocked ? Colors.white60 : Colors.grey.withValues(alpha: 0.7),
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (xpReward > 0) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD43B).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFD43B),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+$xpReward XP',
                      style: const TextStyle(
                        color: Color(0xFFFFD43B),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    ).animate(target: isUnlocked ? 1 : 0).scale().shimmer();
  }
}

/// Lesson Complete Summary
class LessonCompleteSummary extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int xpEarned;
  final bool isPerfect;
  final VoidCallback onContinue;

  const LessonCompleteSummary({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.xpEarned,
    required this.isPerfect,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final accuracy = (correctAnswers / totalQuestions * 100).round();

    return Container(
      color: isPerfect
          ? const Color(0xFF58CC02)
          : const Color(0xFF1A1A1A),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isPerfect
                    ? Icons.emoji_events_rounded
                    : Icons.check_circle_rounded,
                color: Colors.white,
                size: 100,
              ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
              
              const SizedBox(height: 24),
              
              Text(
                isPerfect ? 'PERFECT!' : 'LESSON COMPLETE!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 40),
              
              // Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat(
                    icon: Icons.check_circle_rounded,
                    label: 'Correct',
                    value: '$correctAnswers/$totalQuestions',
                    delay: 400,
                  ),
                  _buildStat(
                    icon: Icons.trending_up_rounded,
                    label: 'Accuracy',
                    value: '$accuracy%',
                    delay: 500,
                  ),
                  _buildStat(
                    icon: Icons.star_rounded,
                    label: 'XP Earned',
                    value: '+$xpEarned',
                    delay: 600,
                  ),
                ],
              ),
              
              const SizedBox(height: 60),
              
              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: isPerfect
                        ? const Color(0xFF58CC02)
                        : const Color(0xFF1A1A1A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ).animate(delay: 700.ms).fadeIn().slideY(begin: 0.3, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat({
    required IconData icon,
    required String label,
    required String value,
    required int delay,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    ).animate(delay: delay.ms).fadeIn().scale();
  }
}

