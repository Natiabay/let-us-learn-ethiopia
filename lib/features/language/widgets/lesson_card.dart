import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/language/models/lesson.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final bool isUnlocked;
  final VoidCallback onTap;

  const LessonCard({
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUnlocked ? AppColors.white : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUnlocked 
                ? (lesson.isCompleted ? AppColors.success : AppColors.primary)
                : AppColors.grey.withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: isUnlocked ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Row(
          children: [
            // Lesson Icon/Status
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: _getIconBackgroundColor(),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: _getIconBorderColor(),
                  width: 2,
                ),
              ),
              child: Icon(
                _getIconData(),
                color: _getIconColor(),
                size: 28,
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Lesson Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    lesson.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isUnlocked ? AppColors.textPrimary : AppColors.textDisabled,
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Description
                  Text(
                    lesson.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isUnlocked ? AppColors.textSecondary : AppColors.textDisabled,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Lesson Stats
                  Row(
                    children: [
                      // Difficulty
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor().withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _getDifficultyColor().withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.signal_cellular_alt,
                              size: 12,
                              color: _getDifficultyColor(),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _getDifficultyText(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: _getDifficultyColor(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: 8),
                      
                      // XP Reward
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.secondary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: 12,
                              color: AppColors.secondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${lesson.xpReward} XP',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Exercise Count
                      Text(
                        '${lesson.exercises.length} exercises',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isUnlocked ? AppColors.textSecondary : AppColors.textDisabled,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Arrow/Lock Icon
            Icon(
              isUnlocked ? Icons.arrow_forward_ios : Icons.lock,
              color: isUnlocked ? AppColors.primary : AppColors.textDisabled,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData() {
    if (!isUnlocked) return Icons.lock;
    if (lesson.isCompleted) return Icons.check_circle;
    
    switch (lesson.type) {
      case LessonType.vocabulary:
        return Icons.book;
      case LessonType.grammar:
        return Icons.school;
      case LessonType.listening:
        return Icons.headphones;
      case LessonType.speaking:
        return Icons.mic;
      case LessonType.reading:
        return Icons.menu_book;
      case LessonType.writing:
        return Icons.edit;
      case LessonType.culture:
        return Icons.public;
    }
  }

  Color _getIconColor() {
    if (!isUnlocked) return AppColors.textDisabled;
    if (lesson.isCompleted) return AppColors.white;
    return AppColors.primary;
  }

  Color _getIconBackgroundColor() {
    if (!isUnlocked) return AppColors.lightGrey;
    if (lesson.isCompleted) return AppColors.success;
    return AppColors.primary.withValues(alpha: 0.1);
  }

  Color _getIconBorderColor() {
    if (!isUnlocked) return AppColors.grey.withValues(alpha: 0.3);
    if (lesson.isCompleted) return AppColors.success;
    return AppColors.primary.withValues(alpha: 0.3);
  }

  Color _getDifficultyColor() {
    switch (lesson.difficulty) {
      case 1:
        return AppColors.success;
      case 2:
        return AppColors.warning;
      case 3:
        return AppColors.accent;
      default:
        return AppColors.error;
    }
  }

  String _getDifficultyText() {
    switch (lesson.difficulty) {
      case 1:
        return 'Easy';
      case 2:
        return 'Medium';
      case 3:
        return 'Hard';
      default:
        return 'Expert';
    }
  }
}




















