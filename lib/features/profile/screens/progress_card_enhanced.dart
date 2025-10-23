import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Enhanced color palette for better contrast and professional appearance
class ProgressCardColors {
  static const primaryBlue = Color(0xFF1E40AF);
  static const secondaryBlue = Color(0xFF3B82F6);
  static const accentGreen = Color(0xFF10B981);
  static const accentOrange = Color(0xFFF59E0B);
  static const accentPurple = Color(0xFF8B5CF6);
  static const pureWhite = Color(0xFFFFFFFF);
  static const lightGray = Color(0xFFF8FAFC);
  static const mediumGray = Color(0xFF64748B);
  static const darkGray = Color(0xFF334155);
  static const cardBackground = Color(0xFFFFFFFF);
  static const progressBarBackground = Color(0xFFE2E8F0);
  static const progressBarFill = Color(0xFF10B981);
}

class EnhancedProgressCard extends StatelessWidget {
  const EnhancedProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ProgressCardColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: ProgressCardColors.lightGray,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with level and XP
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ProgressCardColors.primaryBlue,
                      ProgressCardColors.secondaryBlue,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: ProgressCardColors.pureWhite,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Level 1',
                      style: TextStyle(
                        color: ProgressCardColors.darkGray,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Level Progress',
                      style: TextStyle(
                        color: ProgressCardColors.mediumGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: ProgressCardColors.accentGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ProgressCardColors.accentGreen.withValues(alpha: 0.3),
                  ),
                ),
                child: const Text(
                  '0 XP',
                  style: TextStyle(
                    color: ProgressCardColors.accentGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Progress to Level 2',
                    style: TextStyle(
                      color: ProgressCardColors.darkGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '0/100',
                    style: TextStyle(
                      color: ProgressCardColors.mediumGray,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: ProgressCardColors.progressBarBackground,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.0, // 0% progress
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          ProgressCardColors.accentGreen,
                          ProgressCardColors.accentGreen,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Stats Row
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.local_fire_department_rounded,
                  label: 'Day Streak',
                  value: '0',
                  color: ProgressCardColors.accentOrange,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: ProgressCardColors.lightGray,
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.check_circle_rounded,
                  label: 'Completed',
                  value: '0',
                  color: ProgressCardColors.accentGreen,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: ProgressCardColors.lightGray,
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.trending_up_rounded,
                  label: 'Current Level',
                  value: '1',
                  color: ProgressCardColors.primaryBlue,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Continue Learning Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Navigate to learning screen
              },
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Continue Learning'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ProgressCardColors.primaryBlue,
                foregroundColor: ProgressCardColors.pureWhite,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: ProgressCardColors.darkGray,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: ProgressCardColors.mediumGray,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
