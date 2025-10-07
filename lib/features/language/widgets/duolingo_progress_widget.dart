import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

class DuolingoProgressWidget extends StatelessWidget {
  final int currentXP;
  final int targetXP;
  final int level;

  const DuolingoProgressWidget({
    super.key,
    required this.currentXP,
    required this.targetXP,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentXP / targetXP;
    final xpNeeded = targetXP - currentXP;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.textOnPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Circular Progress
          CircularPercentIndicator(
            radius: 30,
            lineWidth: 6,
            percent: progress.clamp(0.0, 1.0),
            center: Text(
              '$level',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            progressColor: AppColors.textOnPrimary,
            backgroundColor: AppColors.textOnPrimary.withValues(alpha: 0.2),
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(width: 16),
          
          // Progress Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Level $level',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$currentXP / $targetXP XP',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 4),
                if (xpNeeded > 0)
                  Text(
                    '$xpNeeded XP to next level',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textOnPrimary.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
          ),
          
          // Level Badge
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.textOnPrimary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.emoji_events_rounded,
              color: AppColors.textOnPrimary,
              size: 24,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }
}

