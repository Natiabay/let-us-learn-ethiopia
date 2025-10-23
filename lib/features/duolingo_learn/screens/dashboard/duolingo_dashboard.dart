import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/providers/progress_provider.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/providers/onboarding_provider.dart';

/// Duolingo Dashboard - Main learning hub
/// Shows progress, skill tree, and gamification elements
class DuolingoDashboard extends ConsumerStatefulWidget {
  const DuolingoDashboard({super.key});

  @override
  ConsumerState<DuolingoDashboard> createState() => _DuolingoDashboardState();
}

class _DuolingoDashboardState extends ConsumerState<DuolingoDashboard> {
  @override
  void initState() {
    super.initState();
    _checkOnboarding();
    _checkHeartRegeneration();
  }

  Future<void> _checkOnboarding() async {
    // Check if onboarding is complete
    final isComplete = ref.read(isOnboardingCompleteProvider);
    if (!isComplete && mounted) {
      // Navigate to onboarding
      context.go('/duolingo/onboarding/welcome');
    }
  }

  Future<void> _checkHeartRegeneration() async {
    // Check and regenerate hearts if needed
    await ref.read(progressProvider.notifier).checkHeartRegeneration();
    
    // Reset daily goal if new day
    await ref.read(progressProvider.notifier).resetDailyGoal();
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(progressProvider);

    if (progress == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF58CC02),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top Bar (Sticky)
            SliverAppBar(
              backgroundColor: const Color(0xFF1A1A1A),
              pinned: true,
              elevation: 0,
              expandedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildTopBar(context, progress),
              ),
            ),

            // Daily Goal Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildDailyGoalCard(progress),
              ).animate().fadeIn().slideY(begin: -0.2, end: 0),
            ),

            // Stats Row
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildStatsRow(progress),
              ).animate().fadeIn(delay: 100.ms),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // Section Header: Continue Learning
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.play_circle_filled_rounded,
                      color: Color(0xFF58CC02),
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Continue Learning',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Skill Tree / Learning Path
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    // TODO: Replace with actual lesson data
                    return _buildLessonCard(
                      context: context,
                      title: 'Lesson ${index + 1}',
                      description: 'Learn basic Amharic greetings',
                      isLocked: index > 2,
                      isCompleted: index == 0,
                      progress: index == 1 ? 0.6 : 0.0,
                      delay: (index + 3) * 100,
                    );
                  },
                  childCount: 10, // TODO: Replace with actual lesson count
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildTopBar(BuildContext context, dynamic progress) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile/Level
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF58CC02),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF58CC02).withValues(alpha: 0.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '${progress.level}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Level',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${progress.level}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Stats
          Row(
            children: [
              // Streak
              _buildStatBadge(
                icon: Icons.local_fire_department_rounded,
                value: '${progress.currentStreak}',
                color: const Color(0xFFFF9600),
              ),
              const SizedBox(width: 12),
              // Hearts
              _buildStatBadge(
                icon: Icons.favorite_rounded,
                value: '${progress.hearts}',
                color: const Color(0xFFFF4B4B),
              ),
              const SizedBox(width: 12),
              // Settings
              IconButton(
                icon: const Icon(Icons.settings_rounded, color: Colors.white70),
                onPressed: () {
                  // TODO: Navigate to settings
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadge({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyGoalCard(dynamic progress) {
    final dailyGoal = progress.dailyGoal;
    final progressPercent = dailyGoal.progress;
    final isCompleted = dailyGoal.isCompleted;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isCompleted
              ? [const Color(0xFF58CC02), const Color(0xFF46A302)]
              : [const Color(0xFF2A2A2A), const Color(0xFF1F1F1F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: isCompleted
            ? [
                BoxShadow(
                  color: const Color(0xFF58CC02).withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isCompleted
                        ? Icons.check_circle_rounded
                        : Icons.emoji_events_rounded,
                    color: isCompleted ? Colors.white : const Color(0xFFFFD43B),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isCompleted ? 'Daily Goal Complete!' : 'Daily Goal',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                '${dailyGoal.currentXP}/${dailyGoal.targetXP} XP',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progressPercent,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                isCompleted ? Colors.white : const Color(0xFF58CC02),
              ),
            ),
          ),
          if (!isCompleted) ...[
            const SizedBox(height: 12),
            Text(
              '${dailyGoal.targetXP - dailyGoal.currentXP} XP to go!',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsRow(dynamic progress) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.star_rounded,
            label: 'Total XP',
            value: '${progress.xp}',
            color: const Color(0xFFFFD43B),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.check_circle_rounded,
            label: 'Lessons',
            value: '${progress.totalLessonsCompleted}',
            color: const Color(0xFF58CC02),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.workspace_premium_rounded,
            label: 'Perfect',
            value: '${progress.perfectLessons}',
            color: const Color(0xFF1CB0F6),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard({
    required BuildContext context,
    required String title,
    required String description,
    required bool isLocked,
    required bool isCompleted,
    required double progress,
    required int delay,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: isLocked
            ? null
            : () {
                // TODO: Navigate to lesson
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Lesson coming in Phase 2!')),
                );
              },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isLocked
                ? const Color(0xFF1F1F1F)
                : const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isCompleted
                  ? const Color(0xFF58CC02)
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isLocked
                      ? Colors.grey.withValues(alpha: 0.2)
                      : (isCompleted
                          ? const Color(0xFF58CC02).withValues(alpha: 0.2)
                          : const Color(0xFF1CB0F6).withValues(alpha: 0.2)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isLocked
                      ? Icons.lock_rounded
                      : (isCompleted
                          ? Icons.check_circle_rounded
                          : Icons.school_rounded),
                  color: isLocked
                      ? Colors.grey
                      : (isCompleted
                          ? const Color(0xFF58CC02)
                          : const Color(0xFF1CB0F6)),
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isLocked ? Colors.grey : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: isLocked ? Colors.grey.withValues(alpha: 0.7) : Colors.white60,
                        fontSize: 13,
                      ),
                    ),
                    if (progress > 0 && !isCompleted) ...[
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 4,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF58CC02),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Arrow
              if (!isLocked)
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white30,
                  size: 16,
                ),
            ],
          ),
        ),
      ).animate().fadeIn(delay: delay.ms).slideX(begin: -0.2, end: 0),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Learn',
                isActive: true,
                onTap: () {},
              ),
              _buildNavItem(
                icon: Icons.text_fields_rounded,
                label: 'Fidel',
                isActive: false,
                onTap: () {
                  // TODO: Navigate to Fidel learning
                },
              ),
              _buildNavItem(
                icon: Icons.leaderboard_rounded,
                label: 'Progress',
                isActive: false,
                onTap: () {
                  // TODO: Navigate to progress/leaderboard
                },
              ),
              _buildNavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                isActive: false,
                onTap: () {
                  // TODO: Navigate to profile
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF58CC02) : Colors.white60,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? const Color(0xFF58CC02) : Colors.white60,
                fontSize: 11,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

