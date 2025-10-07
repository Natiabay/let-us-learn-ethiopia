import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

class StreakWidget extends StatelessWidget {
  final int streakDays;
  final DateTime? lastStudyDate;

  const StreakWidget({
    super.key,
    required this.streakDays,
    this.lastStudyDate,
  });

  @override
  Widget build(BuildContext context) {
    final isActiveToday = _isStudiedToday();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withValues(alpha: 0.1),
            AppColors.secondary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          // Fire Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isActiveToday ? AppColors.accent : AppColors.grey,
              borderRadius: BorderRadius.circular(25),
              boxShadow: isActiveToday ? [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ] : null,
            ),
            child: Icon(
              Icons.local_fire_department,
              color: AppColors.white,
              size: 28,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Streak Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$streakDays',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'day streak',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _getStreakMessage(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isActiveToday ? AppColors.success : AppColors.warning,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isActiveToday ? 'Active' : 'Study now!',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isStudiedToday() {
    if (lastStudyDate == null) return false;
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final studyDate = DateTime(
      lastStudyDate!.year,
      lastStudyDate!.month,
      lastStudyDate!.day,
    );
    
    return today.isAtSameMomentAs(studyDate);
  }

  String _getStreakMessage() {
    if (streakDays == 0) {
      return 'Start your learning streak today!';
    } else if (streakDays == 1) {
      return 'Great start! Keep it going tomorrow.';
    } else if (streakDays < 7) {
      return 'You\'re building a great habit!';
    } else if (streakDays < 30) {
      return 'Amazing consistency! Keep it up!';
    } else {
      return 'You\'re a learning champion! 🎉';
    }
  }
}




















