import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/auth/providers/auth_provider.dart';
import 'package:tourist_assistive_app/features/profile/screens/edit_profile_screen.dart';
import 'package:tourist_assistive_app/features/profile/screens/favorite_locations_screen.dart';
import 'package:tourist_assistive_app/features/profile/screens/learning_progress_screen.dart';
import 'package:tourist_assistive_app/features/profile/screens/help_support_screen.dart';
import 'package:tourist_assistive_app/features/profile/screens/notifications_screen.dart';
import 'package:tourist_assistive_app/features/profile/screens/subscription_screen.dart';

/// Professional Profile Screen
/// Navy Blue Theme | Enhanced UI/UX | Comprehensive Features
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  // Professional color palette
  static const Color _navyBlue = Color(0xFF0A1929);
  static const Color _navyCard = Color(0xFF1A2F44);
  static const Color _turquoise = Color(0xFF00D9B8);
  static const Color _yellow = Color(0xFFFFD43B);
  static const Color _blue = Color(0xFF1CB0F6);
  static const Color _red = Color(0xFFFF4B4B);
  static const Color _textPrimary = Color(0xFFFFFFFF);
  static const Color _textSecondary = Color(0xFFB3B3B3);
  static const Color _textTertiary = Color(0xFF8B949E);

  // Modal methods to show screens while keeping bottom navigation
  void _showEditProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: _navyBlue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: const EditProfileScreen(),
      ),
    );
  }

  void _showFavoriteLocations(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: _navyBlue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: const FavoriteLocationsScreen(),
      ),
    );
  }

  void _showLearningProgress(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: _navyBlue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: const LearningProgressScreen(),
      ),
    );
  }

  void _showSubscription(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: _navyBlue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: const SubscriptionScreen(),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: _navyBlue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: const NotificationsScreen(),
      ),
    );
  }

  void _showHelpSupport(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: _navyBlue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: const HelpSupportScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: _navyBlue,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Professional App Bar
          _buildAppBar(context),
          
          // Profile Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Enhanced Profile Header
                  _buildProfileHeader(user),
                  
                  const SizedBox(height: 24),
                  
                  // Stats Cards
                  _buildStatsCards(),
                  
                  const SizedBox(height: 24),
                  
                  // Menu Items
                  _buildMenuItems(context, ref),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: _navyCard,
      foregroundColor: _textPrimary,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_navyCard, _navyBlue],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_rounded),
          onPressed: () => _showSettingsDialog(context),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(user) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _turquoise.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Enhanced Profile Avatar
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _turquoise.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : null,
              backgroundColor: _turquoise,
              child: user?.photoURL == null
                  ? Text(
                      user?.displayName?.isNotEmpty == true
                          ? user!.displayName![0].toUpperCase()
                          : 'T',
                      style: const TextStyle(
                        color: _navyBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    )
                  : null,
            ),
          ),
          
          const SizedBox(height: 20),
          
          Text(
            user?.displayName ?? 'Tourist Explorer',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 8),
          
          Text(
            user?.email ?? 'explorer@ethiopia.com',
            style: const TextStyle(
              fontSize: 16,
              color: _textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ).animate(delay: 200.ms).fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 16),
          
          // Premium Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_turquoise, _blue],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _turquoise.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star_rounded, color: _navyBlue, size: 16),
                const SizedBox(width: 8),
                const Text(
                  'Premium Explorer',
                  style: TextStyle(
                    color: _navyBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.explore_rounded,
            title: 'Places Visited',
            value: '12',
            color: _turquoise,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.school_rounded,
            title: 'Lessons Completed',
            value: '8',
            color: _yellow,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.favorite_rounded,
            title: 'Favorites',
            value: '5',
            color: _red,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: _textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.person_rounded,
          title: 'Edit Profile',
          subtitle: 'Update your information',
          color: _turquoise,
          onTap: () => _showEditProfile(context),
        ),
        _buildMenuItem(
          icon: Icons.favorite_rounded,
          title: 'Favorite Locations',
          subtitle: 'Your saved places',
          color: _red,
          onTap: () => _showFavoriteLocations(context),
        ),
        _buildMenuItem(
          icon: Icons.school_rounded,
          title: 'Learning Progress',
          subtitle: 'Track your Amharic journey',
          color: _yellow,
          onTap: () => _showLearningProgress(context),
        ),
        _buildMenuItem(
          icon: Icons.diamond_rounded,
          title: 'Subscription',
          subtitle: 'Manage your plan',
          color: _blue,
          onTap: () => _showSubscription(context),
        ),
        _buildMenuItem(
          icon: Icons.notifications_rounded,
          title: 'Notifications',
          subtitle: 'Manage your alerts',
          color: _textTertiary,
          onTap: () => _showNotifications(context),
        ),
        _buildMenuItem(
          icon: Icons.help_rounded,
          title: 'Help & Support',
          subtitle: 'Get assistance',
          color: _textTertiary,
          onTap: () => _showHelpSupport(context),
        ),
        _buildMenuItem(
          icon: Icons.info_rounded,
          title: 'About',
          subtitle: 'App information',
          color: _textTertiary,
          onTap: () => _showAboutDialog(context),
        ),
        const SizedBox(height: 20),
        _buildMenuItem(
          icon: Icons.logout_rounded,
          title: 'Sign Out',
          subtitle: 'Logout from your account',
          color: _red,
          onTap: () => ref.read(authProvider.notifier).signOut(),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
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
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: _textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: _textTertiary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.settings, color: AppColors.primary),
            const SizedBox(width: 8),
            const Text('Settings'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.language, color: AppColors.primary),
              title: const Text('Language'),
              subtitle: const Text('English'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                _showLanguageDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications, color: AppColors.primary),
              title: const Text('Notifications'),
              subtitle: const Text('Enabled'),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Handle notification toggle
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode, color: AppColors.primary),
              title: const Text('Dark Mode'),
              subtitle: const Text('System'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                _showThemeDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.storage, color: AppColors.primary),
              title: const Text('Storage'),
              subtitle: const Text('Clear cache'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                _clearCache(context);
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

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇺🇸'),
              title: const Text('English'),
              trailing: const Icon(Icons.check, color: AppColors.primary),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Text('🇪🇹'),
              title: const Text('Amharic'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: const Text('Light'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings_system_daydream),
              title: const Text('System'),
              trailing: const Icon(Icons.check, color: AppColors.primary),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _clearCache(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will clear all cached data. Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cache cleared successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Clear'),
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
          borderRadius: BorderRadius.circular(12),
          color: AppColors.primary,
        ),
        child: const Icon(
          Icons.explore,
          color: Colors.white,
          size: 32,
        ),
      ),
      children: [
        const Text(
          'Your comprehensive travel companion for Ethiopia. Discover amazing places, learn Amharic, and navigate with confidence.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        const Text(
          'Features:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text('• Interactive maps and location guides'),
        const Text('• Multi-language Amharic learning'),
        const Text('• AI-powered travel assistant'),
        const Text('• Offline navigation support'),
        const Text('• Cultural insights and tips'),
      ],
    );
  }
}