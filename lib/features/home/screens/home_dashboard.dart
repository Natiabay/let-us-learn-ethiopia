import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/auth/providers/auth_provider.dart';
import 'package:tourist_assistive_app/features/home/widgets/quick_action_card.dart';
import 'package:tourist_assistive_app/features/home/widgets/weather_widget.dart';
import 'package:tourist_assistive_app/features/home/widgets/featured_location_card.dart';
import 'package:tourist_assistive_app/features/home/widgets/language_progress_card.dart';
import 'package:tourist_assistive_app/features/home/widgets/welcome_section.dart';
import 'package:tourist_assistive_app/core/services/navigation_coordinator.dart';
import 'package:tourist_assistive_app/features/language/providers/duolingo_progress_provider.dart';
import 'package:tourist_assistive_app/features/home/screens/main_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

/// Professional Home Dashboard with Perfect Color Contrast
/// Navy Blue Background (#0A1929) with Vibrant Turquoise Accents (#00D9B8)
/// All text is highly readable with perfect contrast ratios
class HomeDashboard extends ConsumerWidget {
  const HomeDashboard({super.key});

  // Professional Color Palette (Matching Reference App)
  static const Color _navyBlue = Color(0xFF0A1929); // Deep navy background
  static const Color _navyCard = Color(0xFF1A2F44); // Navy card background
  static const Color _turquoise = Color(0xFF00D9B8); // Vibrant turquoise
  static const Color _yellow = Color(0xFFFFD43B); // Bright yellow
  static const Color _blue = Color(0xFF1CB0F6); // Bright blue
  static const Color _purple = Color(0xFFCE82FF); // Bright purple
  static const Color _red = Color(0xFFFF4B4B); // Bright red
  static const Color _textPrimary = Color(0xFFFFFFFF); // Pure white - perfect contrast
  static const Color _textSecondary = Color(0xFFE2E8F0); // Light gray - excellent contrast
  static const Color _textTertiary = Color(0xFF94A3B8); // Medium gray - good contrast

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final duolingoProgress = ref.watch(duolingoProgressProvider);

    return Scaffold(
      backgroundColor: _navyBlue, // Deep navy blue background
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100), // Space for bottom nav
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========== HEADER SECTION ==========
              _buildHeaderSection(context, user, duolingoProgress),
              
              const SizedBox(height: 24),
              
              // ========== WEATHER WIDGET ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildWeatherSection(),
              ),
              
              const SizedBox(height: 24),
              
              // ========== QUICK ACTIONS ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildQuickActionsSection(context, ref),
              ),
              
              const SizedBox(height: 32),
              
              // ========== YOUR PROGRESS ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildProgressSection(),
              ),
              
              const SizedBox(height: 32),
              
              // ========== FEATURED DESTINATIONS ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildFeaturedSection(context, ref),
              ),
              
              const SizedBox(height: 32),
              
              // ========== TIP OF THE DAY ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildTipSection(),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ========== HEADER SECTION WITH PERFECT CONTRAST ==========
  Widget _buildHeaderSection(
    BuildContext context,
    dynamic user,
    dynamic duolingoProgress,
  ) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _navyCard, // Navy card background
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _turquoise.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: _turquoise.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // User Info Row
          Row(
            children: [
              // Avatar
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _turquoise, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: _turquoise.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 32,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : null,
                  backgroundColor: _navyBlue,
                  child: user?.photoURL == null
                      ? Text(
                          user?.displayName?.isNotEmpty == true
                              ? user!.displayName![0].toUpperCase()
                              : 'T',
                          style: const TextStyle(
                            color: _turquoise, // Bright turquoise
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        )
                      : null,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Welcome Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: TextStyle(
                        color: _textSecondary, // Light gray - excellent contrast
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.displayName ?? 'Tourist',
                      style: const TextStyle(
                        color: _textPrimary, // Pure white - perfect contrast
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Stats Row (Streak & XP) with Perfect Contrast
          Row(
            children: [
              // Streak Badge
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: duolingoProgress.isStreakActive
                          ? [_yellow, _yellow.withValues(alpha: 0.8)]
                          : [_navyBlue, _navyBlue.withValues(alpha: 0.8)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: duolingoProgress.isStreakActive
                          ? _yellow
                          : _textTertiary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: duolingoProgress.isStreakActive
                            ? _navyBlue // Dark icon on yellow background
                            : _textSecondary, // Light icon on dark background
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${duolingoProgress.streakDays}',
                            style: TextStyle(
                              color: duolingoProgress.isStreakActive
                                  ? _navyBlue // Dark text on yellow
                                  : _textPrimary, // White text on dark
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Day Streak',
                            style: TextStyle(
                              color: duolingoProgress.isStreakActive
                                  ? _navyBlue.withValues(alpha: 0.8)
                                  : _textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // XP Badge
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_blue, _blue.withValues(alpha: 0.8)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _blue,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: _textPrimary, // White icon - perfect contrast
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${duolingoProgress.totalXP}',
                            style: const TextStyle(
                              color: _textPrimary, // White - perfect contrast
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const Text(
                            'Total XP',
                            style: TextStyle(
                              color: _textPrimary, // White - perfect contrast
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.2, end: 0, duration: 600.ms, curve: Curves.easeOutCubic);
  }

  // ========== WEATHER SECTION ==========
  Widget _buildWeatherSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _blue.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: const WeatherWidget(),
    ).animate()
        .fadeIn(duration: 600.ms, delay: 100.ms)
        .slideX(begin: -0.2, end: 0, duration: 600.ms, delay: 100.ms);
  }

  // ========== QUICK ACTIONS SECTION WITH PERFECT CONTRAST ==========
  Widget _buildQuickActionsSection(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header with Perfect Contrast
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _textPrimary, // Pure white - perfect contrast
                letterSpacing: 0.5,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: _turquoise.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _turquoise.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: IconButton(
                onPressed: () => _showMoreActions(context, ref),
                icon: const Icon(
                  Icons.apps_rounded,
                  color: _turquoise, // Bright turquoise icon
                  size: 24,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Horizontal Scrollable Action Cards
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildActionCard(
                icon: Icons.translate_rounded,
                title: 'Learn Amharic',
                subtitle: 'Choose your language',
                color: _turquoise,
                onTap: () {
                  context.push('/language/selection');
                },
              ),
              _buildActionCard(
                icon: Icons.map_rounded,
                title: 'Explore Places',
                subtitle: 'Find attractions',
                color: _yellow,
                onTap: () {
                  ref.read(bottomNavIndexProvider.notifier).state = 2;
                },
              ),
              _buildActionCard(
                icon: Icons.chat_rounded,
                title: 'Ask Assistant',
                subtitle: 'Get help',
                color: _blue,
                onTap: () {
                  ref.read(bottomNavIndexProvider.notifier).state = 3;
                },
              ),
              _buildActionCard(
                icon: Icons.emergency_rounded,
                title: 'Emergency',
                subtitle: 'Quick help',
                color: _red,
                onTap: () {
                  final coordinator = ref.read(navigationCoordinatorProvider);
                  coordinator.navigateToEmergency(context);
                },
              ),
              _buildActionCard(
                icon: Icons.school_rounded,
                title: 'Advanced',
                subtitle: '500+ lessons',
                color: _purple,
                onTap: () {
                  context.push('/language/comprehensive');
                },
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    ).animate()
        .fadeIn(duration: 600.ms, delay: 200.ms)
        .slideX(begin: -0.2, end: 0, duration: 600.ms, delay: 200.ms);
  }

  // Individual Action Card with Perfect Contrast
  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: isLast ? 0 : 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _navyCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: color.withValues(alpha: 0.4),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon Container
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: color.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: color, // Bright colored icon
                    size: 28,
                  ),
                ),
                
                // Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: _textPrimary, // Pure white - perfect contrast
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: _textSecondary, // Light gray - excellent contrast
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========== PROGRESS SECTION ==========
  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Progress',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: _textPrimary, // Pure white - perfect contrast
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        const LanguageProgressCard(),
      ],
    ).animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .slideX(begin: -0.2, end: 0, duration: 600.ms, delay: 300.ms);
  }

  // ========== FEATURED DESTINATIONS SECTION ==========
  Widget _buildFeaturedSection(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Featured Destinations',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _textPrimary, // Pure white - perfect contrast
                letterSpacing: 0.5,
              ),
            ),
            TextButton(
              onPressed: () {
                ref.read(bottomNavIndexProvider.notifier).state = 2;
              },
              style: TextButton.styleFrom(
                foregroundColor: _turquoise,
                backgroundColor: _turquoise.withValues(alpha: 0.1),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'View All',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Locations Carousel
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: index == 4 ? 0 : 16),
                child: FeaturedLocationCard(
                  index: index,
                  onTap: () {
                    final coordinator = ref.read(navigationCoordinatorProvider);
                    coordinator.navigateToLocation(context, 'location_$index');
                  },
                ),
              );
            },
          ),
        ),
      ],
    ).animate()
        .fadeIn(duration: 600.ms, delay: 400.ms)
        .slideX(begin: -0.2, end: 0, duration: 600.ms, delay: 400.ms);
  }

  // ========== TIP OF THE DAY SECTION WITH PERFECT CONTRAST ==========
  Widget _buildTipSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _navyCard,
            _navyCard.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _yellow.withValues(alpha: 0.4),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: _yellow.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _yellow,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: _yellow.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.lightbulb_rounded,
                  color: _navyBlue, // Dark icon on yellow background
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Tip of the Day',
                style: TextStyle(
                  color: _textPrimary, // Pure white - perfect contrast
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Tip Content
          const Text(
            'When greeting someone in Amharic, say "ሰላም" (selam) which means "peace" and is used for hello. It\'s a universal greeting in Ethiopia!',
            style: TextStyle(
              color: _textSecondary, // Light gray - excellent contrast
              fontSize: 15,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ).animate()
        .fadeIn(duration: 600.ms, delay: 500.ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms, delay: 500.ms);
  }

  // ========== MORE ACTIONS BOTTOM SHEET ==========
  void _showMoreActions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: const BoxDecoration(
          color: _navyCard, // Navy card background
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle Bar
            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: _textTertiary.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            
            // Title
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'More Actions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary, // Pure white
                ),
              ),
            ),
            
            // Actions Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMoreActionCard(
                    icon: Icons.translate_rounded,
                    title: 'Translation',
                    subtitle: 'Quick translate',
                    color: _turquoise,
                    onTap: () {
                      context.pop();
                      ref.read(bottomNavIndexProvider.notifier).state = 3;
                    },
                  ),
                  _buildMoreActionCard(
                    icon: Icons.phone_rounded,
                    title: 'Call Support',
                    subtitle: 'Get help',
                    color: _blue,
                    onTap: () {
                      context.pop();
                      _showCallSupportDialog(context);
                    },
                  ),
                  _buildMoreActionCard(
                    icon: Icons.settings_rounded,
                    title: 'Settings',
                    subtitle: 'App preferences',
                    color: _purple,
                    onTap: () {
                      context.pop();
                      ref.read(bottomNavIndexProvider.notifier).state = 4;
                    },
                  ),
                  _buildMoreActionCard(
                    icon: Icons.info_rounded,
                    title: 'About',
                    subtitle: 'App info',
                    color: _yellow,
                    onTap: () {
                      context.pop();
                      _showAboutDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _navyBlue,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withValues(alpha: 0.4),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: _textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========== SUPPORT DIALOG ==========
  void _showCallSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _navyCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Row(
          children: [
            Icon(Icons.support_agent_rounded, color: _turquoise, size: 28),
            SizedBox(width: 12),
            Text(
              'Support Options',
              style: TextStyle(color: _textPrimary, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSupportOption(
              icon: Icons.phone_rounded,
              title: 'Call Support',
              subtitle: '+251-11-123-4567',
              color: _turquoise,
              onTap: () {
                Navigator.pop(context);
                _makePhoneCall(context, '+251-11-123-4567');
              },
            ),
            const SizedBox(height: 12),
            _buildSupportOption(
              icon: Icons.email_rounded,
              title: 'Email Support',
              subtitle: 'support@touristassistant.ethiopia',
              color: _blue,
              onTap: () {
                Navigator.pop(context);
                _sendEmail(context, 'support@touristassistant.ethiopia');
              },
            ),
            const SizedBox(height: 12),
            _buildSupportOption(
              icon: Icons.chat_rounded,
              title: 'Live Chat',
              subtitle: 'Available 24/7',
              color: _purple,
              onTap: () {
                Navigator.pop(context);
                context.go('/chatbot');
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: _turquoise,
              backgroundColor: _turquoise.withValues(alpha: 0.1),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Close', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _navyBlue,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: _textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: _textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: color, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ========== ABOUT DIALOG ==========
  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'ETHIO-TOUR',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_turquoise, _blue],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _turquoise.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(Icons.explore_rounded, color: _textPrimary, size: 36),
      ),
      children: const [
        Text(
          'Your comprehensive guide to exploring Ethiopia. Discover amazing places, learn Amharic, and get AI-powered assistance for your journey.',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        SizedBox(height: 16),
        Text('Features:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 8),
        Text('• AI-powered tourist assistant'),
        Text('• Amharic language learning'),
        Text('• Interactive maps and locations'),
        Text('• Voice translation services'),
        Text('• Emergency assistance'),
        SizedBox(height: 16),
        Text(
          'Made with ❤️ for tourists visiting Ethiopia',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
        ),
      ],
    );
  }

  // ========== PHONE CALL ==========
  Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Cannot make phone call to $phoneNumber'),
              backgroundColor: _red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error making phone call. Please try again.'),
            backgroundColor: _red,
          ),
        );
      }
    }
  }

  // ========== EMAIL ==========
  Future<void> _sendEmail(BuildContext context, String email) async {
    try {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
        query: 'subject=Tourist Assistant Support Request',
      );
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cannot open email client'),
              backgroundColor: _red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error opening email client. Please try again.'),
            backgroundColor: _red,
          ),
        );
      }
    }
  }
}

