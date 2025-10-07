import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/language/models/achievement_model.dart';

class DuolingoAchievementWidget extends StatelessWidget {
  final Achievement achievement;

  const DuolingoAchievementWidget({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: achievement.isUnlocked 
            ? AppColors.surface 
            : AppColors.grey100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: achievement.isUnlocked 
              ? _getAchievementColor(achievement.type).withValues(alpha: 0.3)
              : AppColors.grey300,
          width: 2,
        ),
        boxShadow: achievement.isUnlocked ? [
          BoxShadow(
            color: _getAchievementColor(achievement.type).withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ] : null,
      ),
      child: Column(
        children: [
          // Achievement Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: achievement.isUnlocked 
                  ? _getAchievementColor(achievement.type)
                  : AppColors.grey400,
              borderRadius: BorderRadius.circular(25),
              boxShadow: achievement.isUnlocked ? [
                BoxShadow(
                  color: _getAchievementColor(achievement.type).withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ] : null,
            ),
            child: Icon(
              _getAchievementIcon(achievement.type),
              color: AppColors.textOnPrimary,
              size: 24,
            ),
          ).animate(onPlay: (controller) {
            if (achievement.isUnlocked) {
              controller.repeat();
            }
          }).shimmer(
            duration: 2000.ms,
            color: achievement.isUnlocked 
                ? _getAchievementColor(achievement.type).withValues(alpha: 0.3)
                : Colors.transparent,
          ),
          
          const SizedBox(height: 8),
          
          // Achievement Title
          Text(
            achievement.title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: achievement.isUnlocked 
                  ? AppColors.textPrimary 
                  : AppColors.grey600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 4),
          
          // XP Reward
          if (achievement.isUnlocked)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 12,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${achievement.xpReward}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }

  Color _getAchievementColor(AchievementType type) {
    switch (type) {
      case AchievementType.streak:
        return AppColors.accent;
      case AchievementType.lessons:
        return AppColors.primary;
      case AchievementType.words:
        return AppColors.info;
      case AchievementType.xp:
        return AppColors.secondary;
      case AchievementType.perfect:
        return AppColors.success;
      case AchievementType.speed:
        return AppColors.warning;
      case AchievementType.category:
        return AppColors.accent;
      case AchievementType.special:
        return AppColors.primary;
    }
  }

  IconData _getAchievementIcon(AchievementType type) {
    switch (type) {
      case AchievementType.streak:
        return Icons.local_fire_department_rounded;
      case AchievementType.lessons:
        return Icons.school_rounded;
      case AchievementType.words:
        return Icons.book_rounded;
      case AchievementType.xp:
        return Icons.star_rounded;
      case AchievementType.perfect:
        return Icons.check_circle_rounded;
      case AchievementType.speed:
        return Icons.speed_rounded;
      case AchievementType.category:
        return Icons.category_rounded;
      case AchievementType.special:
        return Icons.emoji_events_rounded;
    }
  }
}

