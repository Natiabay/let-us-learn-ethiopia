import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

class DuolingoStreakWidget extends StatelessWidget {
  final int streakDays;
  final DateTime? lastStudyDate;

  const DuolingoStreakWidget({
    super.key,
    required this.streakDays,
    this.lastStudyDate,
  });

  @override
  Widget build(BuildContext context) {
    final isStreakActive = _isStreakActive();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isStreakActive 
              ? AppColors.accentGradient
              : [AppColors.grey400, AppColors.grey500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: isStreakActive ? [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ] : null,
      ),
      child: Column(
        children: [
          // Fire Icon with Animation
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.textOnPrimary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              Icons.local_fire_department_rounded,
              color: AppColors.textOnPrimary,
              size: 28,
            ),
          ).animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 2000.ms, color: AppColors.textOnPrimary.withValues(alpha: 0.3)),
          
          const SizedBox(height: 12),
          
          // Streak Number
          Text(
            '$streakDays',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          
          // Streak Label
          Text(
            streakDays == 1 ? 'Day Streak' : 'Day Streak',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textOnPrimary.withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Streak Status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.textOnPrimary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isStreakActive ? 'Keep it up!' : 'Start your streak',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0));
  }

  bool _isStreakActive() {
    if (lastStudyDate == null) return false;
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastStudy = DateTime(lastStudyDate!.year, lastStudyDate!.month, lastStudyDate!.day);
    
    return today.difference(lastStudy).inDays <= 1;
  }
}

