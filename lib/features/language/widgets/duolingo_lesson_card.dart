import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/language/models/lesson_model.dart';

class DuolingoLessonCard extends StatelessWidget {
  final Lesson lesson;
  final bool isUnlocked;
  final VoidCallback onTap;

  const DuolingoLessonCard({
    super.key,
    required this.lesson,
    required this.isUnlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUnlocked ? onTap : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isUnlocked ? AppColors.surface : AppColors.grey100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isUnlocked 
                ? _getCategoryColor(lesson.category).withValues(alpha: 0.3)
                : AppColors.grey300,
            width: 2,
          ),
          boxShadow: isUnlocked ? [
            BoxShadow(
              color: _getCategoryColor(lesson.category).withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ] : null,
        ),
        child: Row(
          children: [
            // Lesson Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isUnlocked 
                    ? _getCategoryColor(lesson.category)
                    : AppColors.grey400,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isUnlocked ? [
                  BoxShadow(
                    color: _getCategoryColor(lesson.category).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ] : null,
              ),
              child: Icon(
                _getCategoryIcon(lesson.category),
                color: AppColors.textOnPrimary,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            
            // Lesson Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          lesson.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isUnlocked ? AppColors.textPrimary : AppColors.grey600,
                          ),
                        ),
                      ),
                      if (lesson.isCompleted)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: AppColors.textOnPrimary,
                            size: 16,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lesson.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isUnlocked ? AppColors.textSecondary : AppColors.grey500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Progress and Stats
                  Row(
                    children: [
                      // Difficulty Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(lesson.difficulty).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          lesson.difficulty,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: _getDifficultyColor(lesson.difficulty),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      
                      // Time
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 16,
                            color: isUnlocked ? AppColors.textSecondary : AppColors.grey500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${lesson.estimatedTime} min',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isUnlocked ? AppColors.textSecondary : AppColors.grey500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      
                      // XP Reward
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: isUnlocked ? AppColors.secondary : AppColors.grey500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${lesson.xpReward} XP',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isUnlocked ? AppColors.secondary : AppColors.grey500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  // Progress Bar
                  if (lesson.progress > 0) ...[
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: lesson.progress,
                      backgroundColor: AppColors.grey200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getCategoryColor(lesson.category),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ],
              ),
            ),
            
            // Arrow or Lock
            const SizedBox(width: 16),
            if (isUnlocked)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getCategoryColor(lesson.category).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: _getCategoryColor(lesson.category),
                  size: 20,
                ),
              )
            else
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.lock_rounded,
                  color: AppColors.grey600,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.3, end: 0);
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'basics':
        return AppColors.primary;
      case 'culture':
        return AppColors.secondary;
      case 'travel':
        return AppColors.accent;
      case 'food':
        return AppColors.success;
      case 'numbers':
        return AppColors.info;
      default:
        return AppColors.primary;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'basics':
        return Icons.waving_hand_rounded;
      case 'culture':
        return Icons.museum_rounded;
      case 'travel':
        return Icons.flight_rounded;
      case 'food':
        return Icons.restaurant_rounded;
      case 'numbers':
        return Icons.numbers_rounded;
      default:
        return Icons.school_rounded;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return AppColors.success;
      case 'intermediate':
        return AppColors.warning;
      case 'advanced':
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }
}

