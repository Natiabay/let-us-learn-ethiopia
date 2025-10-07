import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/subscription/providers/subscription_provider.dart';

class HamburgerMenu extends ConsumerWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trialStatus = ref.watch(trialStatusProvider);
    
    final trialData = trialStatus.when(
      data: (data) => data,
      loading: () => {'hasAccess': false, 'needsPayment': false},
      error: (_, __) => {'hasAccess': false, 'needsPayment': false},
    );
    
    final hasAccess = trialData['hasAccess'] ?? false;
    final needsPayment = trialData['needsPayment'] ?? false;
    return Drawer(
      backgroundColor: AppColors.surface,
      child: Column(
        children: [
          // Header
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  AppColors.primaryLight,
                  AppColors.accent,
                ],
              ),
            ),
            child: const SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.explore,
                      color: AppColors.white,
                      size: 40,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'ETHIO-TOUR',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Your Ethiopian Guide',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Always show payment dashboard in hamburger menu
                _buildMenuItem(
                  context,
                  icon: Icons.payment,
                  title: 'Payment Dashboard',
                  subtitle: hasAccess ? 'Manage subscription & payments' : 'Upgrade to premium',
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/payment');
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.feedback,
                  title: 'Send Feedback',
                  subtitle: 'Help us improve the app',
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/feedback');
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.contact_support,
                  title: 'Contact Us',
                  subtitle: 'Get help and support',
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/contact-us');
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.info_outline,
                  title: 'About Us',
                  subtitle: 'Learn about our mission',
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/about-us');
                  },
                ),
                const Divider(),
                _buildMenuItem(
                  context,
                  icon: Icons.settings,
                  title: 'Settings',
                  subtitle: 'App preferences',
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/settings');
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.help_outline,
                  title: 'Help & FAQ',
                  subtitle: 'Common questions',
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/help');
                  },
                ),
              ],
            ),
          ),
          
          // Footer
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Divider(),
                const SizedBox(height: 8),
                Text(
                  'Version 1.0.0',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Made with ❤️ for Ethiopia',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: AppTheme.titleMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTheme.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}


