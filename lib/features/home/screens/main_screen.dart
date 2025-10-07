import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/subscription/providers/subscription_provider.dart';
import 'package:tourist_assistive_app/features/home/screens/home_dashboard.dart';
import 'package:tourist_assistive_app/features/language/screens/language_learning_screen.dart';
import 'package:tourist_assistive_app/features/locations/screens/locations_screen.dart';
import 'package:tourist_assistive_app/features/chat/screens/modern_chat_screen.dart';
import 'package:tourist_assistive_app/features/profile/screens/profile_screen.dart';
import 'package:tourist_assistive_app/features/navigation/widgets/hamburger_menu.dart';
import 'package:url_launcher/url_launcher.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class MainScreen extends ConsumerStatefulWidget {
  final Widget child;
  
  const MainScreen({super.key, required this.child});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>
    with TickerProviderStateMixin {
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;
  bool _isFabExpanded = false;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.home_rounded,
      activeIcon: Icons.home_rounded,
      label: 'Home',
      route: '/home',
      color: AppColors.primary,
    ),
    NavigationItem(
      icon: Icons.school_outlined,
      activeIcon: Icons.school_rounded,
      label: 'Learn',
      route: '/language',
      color: AppColors.secondary,
    ),
    NavigationItem(
      icon: Icons.location_on_outlined,
      activeIcon: Icons.location_on_rounded,
      label: 'Places',
      route: '/locations',
      color: AppColors.accent,
    ),
    NavigationItem(
      icon: Icons.chat_bubble_outline_rounded,
      activeIcon: Icons.chat_bubble_rounded,
      label: 'Chat',
      route: '/chatbot',
      color: AppColors.info,
    ),
    NavigationItem(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'Profile',
      route: '/profile',
      color: AppColors.success,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fabController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final trialStatus = ref.watch(trialStatusProvider);
    
    final trialData = trialStatus.when(
      data: (data) => data,
      loading: () => {'isTrialActive': false},
      error: (_, __) => {'isTrialActive': false},
    );
    
    final isTrialActive = trialData['isTrialActive'] ?? false;

    final screens = [
      const HomeDashboard(),
      const LanguageLearningScreen(),
      const LocationsScreen(),
      const ModernChatScreen(), // ✅ NEW RAG-powered chat with 10,000+ line knowledge base
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: _buildModernAppBar(currentIndex, isTrialActive),
      drawer: const HamburgerMenu(),
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
      ),
      floatingActionButton: _getFloatingActionButtonForCurrentScreen(currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildModernBottomNav(context, currentIndex),
    );
  }

  PreferredSizeWidget _buildModernAppBar(int currentIndex, bool isTrialActive) {
    final item = _navigationItems[currentIndex];
    
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      surfaceTintColor: AppColors.primary,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.primaryGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          item.activeIcon,
          color: AppColors.textOnPrimary,
          size: 24,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getScreenTitle(currentIndex),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            'Welcome to Ethiopia 🇪🇹',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
      actions: [
        if (isTrialActive)
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.secondaryGradient,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'TRIAL',
              style: TextStyle(
                color: AppColors.textOnSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
        IconButton(
          onPressed: () => _showQuickActions(context),
          icon: const Icon(Icons.more_vert_rounded),
          tooltip: 'Quick Actions',
        ),
      ],
    );
  }

  Widget _buildModernFAB(BuildContext context) {
    return AnimatedBuilder(
      animation: _fabAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _fabAnimation.value,
          child: FloatingActionButton(
            heroTag: "main_fab_unique",
            onPressed: () => _toggleFabExpansion(),
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            elevation: 0,
            child: AnimatedRotation(
              turns: _isFabExpanded ? 0.125 : 0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _isFabExpanded ? Icons.close_rounded : Icons.add_rounded,
                size: 28,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernBottomNav(BuildContext context, int currentIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grey200, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _onNavItemTapped(index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey500,
          selectedLabelStyle: const TextStyle(
            fontFamily: null,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: null,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          items: _navigationItems.map((item) {
            final isActive = _navigationItems.indexOf(item) == currentIndex;
            return BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isActive 
                      ? item.color.withValues(alpha: 0.1) 
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isActive ? item.activeIcon : item.icon,
                  size: 24,
                ),
              ),
              label: item.label,
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getScreenTitle(int index) {
    switch (index) {
      case 0:
        return 'Explore Ethiopia';
      case 1:
        return 'Learn Amharic';
      case 2:
        return 'Tourist Attractions';
      case 3:
        return 'AI Assistant';
      case 4:
        return 'My Profile';
      default:
        return 'Tourist Assistant';
    }
  }

  void _onNavItemTapped(int index) {
    ref.read(bottomNavIndexProvider.notifier).state = index;
    final item = _navigationItems[index];
    context.go(item.route);
  }

  Widget? _getFloatingActionButtonForCurrentScreen(int currentIndex) {
    switch (currentIndex) {
      case 0: // Home screen
        return _buildModernFAB(context);
      case 1: // Language screen
        return null; // No FAB for language screen
      case 2: // Locations screen
        return null; // Locations screen has its own FAB
      case 3: // Chat screen
        return null; // Chat screen has its own FAB
      case 4: // Profile screen
        return null; // No FAB for profile screen
      default:
        return null;
    }
  }

  void _toggleFabExpansion() {
    setState(() {
      _isFabExpanded = !_isFabExpanded;
    });
    
    if (_isFabExpanded) {
      _fabController.forward();
      _showQuickActions(context);
    } else {
      _fabController.reverse();
    }
  }

  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildQuickActionCard(
                    context,
                    icon: Icons.translate_rounded,
                    title: 'Translation',
                    subtitle: 'Quick translate',
                    color: AppColors.primary,
                    onTap: () {
                      context.pop();
                      context.go('/chatbot?mode=translation');
                    },
                  ),
                  _buildQuickActionCard(
                    context,
                    icon: Icons.emergency_rounded,
                    title: 'Emergency',
                    subtitle: 'Get help',
                    color: AppColors.error,
                    onTap: () {
                      context.pop();
                      _showEmergencyContacts(context);
                    },
                  ),
                  _buildQuickActionCard(
                    context,
                    icon: Icons.my_location_rounded,
                    title: 'Current Location',
                    subtitle: 'Find your position',
                    color: AppColors.info,
                    onTap: () {
                      context.pop();
                      context.go('/locations?mode=current');
                    },
                  ),
                  _buildQuickActionCard(
                    context,
                    icon: Icons.restaurant_rounded,
                    title: 'Food & Drink',
                    subtitle: 'Find restaurants',
                    color: AppColors.secondary,
                    onTap: () {
                      context.pop();
                      context.go('/locations?category=food');
                    },
                  ),
                  _buildQuickActionCard(
                    context,
                    icon: Icons.history_edu_rounded,
                    title: 'Historical Sites',
                    subtitle: 'Explore heritage',
                    color: AppColors.accent,
                    onTap: () {
                      context.pop();
                      context.go('/locations?category=historical');
                    },
                  ),
                  _buildQuickActionCard(
                    context,
                    icon: Icons.settings_rounded,
                    title: 'Settings',
                    subtitle: 'App preferences',
                    color: AppColors.success,
                    onTap: () {
                      context.pop();
                      context.go('/profile');
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

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: AppColors.textOnPrimary,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).scale(
      begin: const Offset(0.8, 0.8),
      end: const Offset(1.0, 1.0),
      duration: 300.ms,
      curve: Curves.easeOut,
    );
  }

  void _showEmergencyContacts(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.emergency, color: AppColors.error),
            const SizedBox(width: 8),
            const Text('Emergency Contacts'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildEmergencyContact(
              'Police',
              '911',
              Icons.local_police,
              AppColors.error,
            ),
            _buildEmergencyContact(
              'Ambulance',
              '907',
              Icons.medical_services,
              AppColors.error,
            ),
            _buildEmergencyContact(
              'Fire Department',
              '939',
              Icons.local_fire_department,
              AppColors.error,
            ),
            _buildEmergencyContact(
              'Tourist Police',
              '+251-11-551-5844',
              Icons.support_agent,
              AppColors.info,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact(String title, String number, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title),
      subtitle: Text(number),
      trailing: IconButton(
        onPressed: () {
          _makePhoneCall(context, number);
        },
        icon: Icon(Icons.phone, color: color),
      ),
    );
  }

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
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error making phone call: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

}

class NavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
  final Color color;

  NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
    required this.color,
  });
}















