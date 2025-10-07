import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/auth/providers/auth_provider.dart';
import 'package:tourist_assistive_app/features/home/widgets/quick_action_card.dart';
import 'package:tourist_assistive_app/features/home/widgets/weather_widget.dart';
import 'package:tourist_assistive_app/features/home/widgets/featured_location_card.dart';
import 'package:tourist_assistive_app/features/home/widgets/language_progress_card.dart';
import 'package:tourist_assistive_app/features/home/widgets/welcome_section.dart';
import 'package:tourist_assistive_app/features/home/screens/main_screen.dart';
import 'package:tourist_assistive_app/core/services/navigation_coordinator.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDashboard extends ConsumerWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gradient Header Section
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                    Color(0xFF58CC02),
                    Color(0xFF1CB0F6),
                    Color(0xFFCE82FF),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Section with Navigation
                    const WelcomeSection(),
                    const SizedBox(height: 20),
                    // Welcome Header with Enhanced Design
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: user?.photoURL != null
                                ? NetworkImage(user!.photoURL!)
                                : null,
                            backgroundColor: Colors.white,
                            child: user?.photoURL == null
                                ? Text(
                                    user?.displayName?.isNotEmpty == true
                                        ? user!.displayName![0].toUpperCase()
                                        : 'T',
                                    style: const TextStyle(
                                      color: Color(0xFF58CC02),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back!',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                user?.displayName ?? 'Tourist',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Enhanced Streak and XP indicators
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.local_fire_department,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                '7',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Weather Widget with Enhanced Design
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1CB0F6), Color(0xFF58CC02)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1CB0F6).withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const WeatherWidget(),
                  ),
                  const SizedBox(height: 24),
                  
                  // Quick Actions with Enhanced Design
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF58CC02).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _showMoreActions(context, ref);
                          },
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Color(0xFF58CC02),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    width: 160,
                    child: QuickActionCard(
                      icon: Icons.translate_rounded,
                      title: 'Learn Amharic',
                      subtitle: 'Continue lesson',
                      color: AppColors.primary,
                      onTap: () {
                        ref.read(bottomNavIndexProvider.notifier).state = 1;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 160,
                    child: QuickActionCard(
                      icon: Icons.map_rounded,
                      title: 'Explore Places',
                      subtitle: 'Find attractions',
                      color: AppColors.secondary,
                      onTap: () {
                        ref.read(bottomNavIndexProvider.notifier).state = 2;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 160,
                    child: QuickActionCard(
                      icon: Icons.chat_rounded,
                      title: 'Ask Assistant',
                      subtitle: 'Get help',
                      color: AppColors.accent,
                      onTap: () {
                        ref.read(bottomNavIndexProvider.notifier).state = 3;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 160,
                    child: QuickActionCard(
                      icon: Icons.emergency_rounded,
                      title: 'Emergency',
                      subtitle: 'Quick help',
                      color: AppColors.error,
                      onTap: () {
                        final coordinator = ref.read(navigationCoordinatorProvider);
                        coordinator.navigateToEmergency(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            
            const SizedBox(height: 24),
            
            // Language Progress
            Text(
              'Your Progress',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const LanguageProgressCard(),
            
            const SizedBox(height: 24),
            
            // Featured Locations
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured Destinations',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(bottomNavIndexProvider.notifier).state = 2;
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 5, // Show more locations
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == 4 ? 0 : 16,
                    ),
                    child: FeaturedLocationCard(
                      index: index,
                      onTap: () {
                        // Navigate to location detail
                        final coordinator = ref.read(navigationCoordinatorProvider);
                        coordinator.navigateToLocation(context, 'location_$index');
                      },
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Tips Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primaryLight.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.lightbulb_outline_rounded,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Tip of the Day',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'When greeting someone in Amharic, say "ሰላም" (selam) which means "peace" and is used for hello. It\'s a universal greeting in Ethiopia!',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
            ],
          ),
        ),
      ),
    );
  }


  void _showMoreActions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.textSecondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'More Actions',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  QuickActionCard(
                    icon: Icons.translate_rounded,
                    title: 'Translation',
                    subtitle: 'Quick translate',
                    color: AppColors.primary,
                    onTap: () {
                      context.pop();
                      ref.read(bottomNavIndexProvider.notifier).state = 3;
                    },
                  ),
                  QuickActionCard(
                    icon: Icons.phone_rounded,
                    title: 'Call Support',
                    subtitle: 'Get help',
                    color: AppColors.secondary,
                      onTap: () {
                        context.pop();
                        _showCallSupportDialog(context);
                      },
                  ),
                  QuickActionCard(
                    icon: Icons.settings_rounded,
                    title: 'Settings',
                    subtitle: 'App preferences',
                    color: AppColors.accent,
                    onTap: () {
                      context.pop();
                      ref.read(bottomNavIndexProvider.notifier).state = 4;
                    },
                  ),
                  QuickActionCard(
                    icon: Icons.info_rounded,
                    title: 'About',
                    subtitle: 'App information',
                    color: AppColors.success,
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

  void _showCallSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.support_agent, color: AppColors.primary),
            const SizedBox(width: 8),
            const Text('Support Options'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone, color: AppColors.primary),
              title: const Text('Call Support'),
              subtitle: const Text('+251-11-123-4567'),
              onTap: () {
                Navigator.pop(context);
                _makePhoneCall('+251-11-123-4567');
              },
            ),
            ListTile(
              leading: const Icon(Icons.email, color: AppColors.primary),
              title: const Text('Email Support'),
              subtitle: const Text('support@touristassistant.ethiopia'),
              onTap: () {
                Navigator.pop(context);
                _sendEmail('support@touristassistant.ethiopia');
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: AppColors.primary),
              title: const Text('Live Chat'),
              subtitle: const Text('Available 24/7'),
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
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Tourist Assistant Ethiopia',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.primaryGradient,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.explore,
          color: Colors.white,
          size: 32,
        ),
      ),
      children: [
        const Text(
          'Your comprehensive guide to exploring Ethiopia. Discover amazing places, learn Amharic, and get AI-powered assistance for your journey.',
        ),
        const SizedBox(height: 16),
        const Text(
          'Features:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Text('• AI-powered tourist assistant'),
        const Text('• Amharic language learning'),
        const Text('• Interactive maps and locations'),
        const Text('• Voice translation services'),
        const Text('• Emergency assistance'),
        const SizedBox(height: 16),
        const Text(
          'Made with ❤️ for tourists visiting Ethiopia',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _sendEmail(String email) async {
    try {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
        query: 'subject=Tourist Assistant Support Request',
      );
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      }
    } catch (e) {
      // Handle error silently
    }
  }
}