import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

class DuolingoShopSheet extends StatefulWidget {
  const DuolingoShopSheet({super.key});

  @override
  State<DuolingoShopSheet> createState() => _DuolingoShopSheetState();
}

class _DuolingoShopSheetState extends State<DuolingoShopSheet> {
  int selectedTabIndex = 0;
  int userGems = 1500; // User's current gems

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.store_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Shop',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                // Gems Display
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.diamond_rounded,
                        color: AppColors.secondary,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$userGems',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          
          // Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton('Power-ups', 0),
                ),
                Expanded(
                  child: _buildTabButton('Streak Freeze', 1),
                ),
                Expanded(
                  child: _buildTabButton('Hearts', 2),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Content
          Expanded(
            child: IndexedStack(
              index: selectedTabIndex,
              children: [
                _buildPowerUpsTab(),
                _buildStreakFreezeTab(),
                _buildHeartsTab(),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTabIndex == index;
    
    return GestureDetector(
      onTap: () => setState(() => selectedTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildPowerUpsTab() {
    final powerUps = [
      {
        'name': '2x XP Boost',
        'description': 'Double XP for 15 minutes',
        'price': 200,
        'icon': Icons.flash_on_rounded,
        'color': AppColors.warning,
      },
      {
        'name': 'Perfect Lesson',
        'description': 'Complete any lesson perfectly',
        'price': 100,
        'icon': Icons.star_rounded,
        'color': AppColors.secondary,
      },
      {
        'name': 'Time Freeze',
        'description': 'Pause timer for 5 minutes',
        'price': 150,
        'icon': Icons.pause_circle_rounded,
        'color': AppColors.info,
      },
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        Text(
          'Power-ups',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        ...powerUps.map((powerUp) => _buildShopItem(
          name: powerUp['name'] as String,
          description: powerUp['description'] as String,
          price: powerUp['price'] as int,
          icon: powerUp['icon'] as IconData,
          color: powerUp['color'] as Color,
        )),
      ],
    );
  }

  Widget _buildStreakFreezeTab() {
    final streakFreezes = [
      {
        'name': '1 Day Streak Freeze',
        'description': 'Protect your streak for 1 day',
        'price': 200,
        'icon': Icons.ac_unit_rounded,
        'color': AppColors.info,
      },
      {
        'name': '3 Day Streak Freeze',
        'description': 'Protect your streak for 3 days',
        'price': 500,
        'icon': Icons.ac_unit_rounded,
        'color': AppColors.primary,
      },
      {
        'name': '7 Day Streak Freeze',
        'description': 'Protect your streak for 7 days',
        'price': 1000,
        'icon': Icons.ac_unit_rounded,
        'color': AppColors.accent,
      },
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        Text(
          'Streak Freeze',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        ...streakFreezes.map((freeze) => _buildShopItem(
          name: freeze['name'] as String,
          description: freeze['description'] as String,
          price: freeze['price'] as int,
          icon: freeze['icon'] as IconData,
          color: freeze['color'] as Color,
        )),
      ],
    );
  }

  Widget _buildHeartsTab() {
    final heartPacks = [
      {
        'name': '5 Hearts',
        'description': 'Get 5 hearts to continue learning',
        'price': 100,
        'icon': Icons.favorite_rounded,
        'color': AppColors.error,
      },
      {
        'name': '10 Hearts',
        'description': 'Get 10 hearts to continue learning',
        'price': 180,
        'icon': Icons.favorite_rounded,
        'color': AppColors.error,
      },
      {
        'name': 'Unlimited Hearts',
        'description': 'Unlimited hearts for 1 day',
        'price': 300,
        'icon': Icons.favorite_rounded,
        'color': AppColors.error,
      },
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        Text(
          'Hearts',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        ...heartPacks.map((heart) => _buildShopItem(
          name: heart['name'] as String,
          description: heart['description'] as String,
          price: heart['price'] as int,
          icon: heart['icon'] as IconData,
          color: heart['color'] as Color,
        )),
      ],
    );
  }

  Widget _buildShopItem({
    required String name,
    required String description,
    required int price,
    required IconData icon,
    required Color color,
  }) {
    final canAfford = userGems >= price;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey200, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Price and Buy Button
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.diamond_rounded,
                    color: AppColors.secondary,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$price',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: canAfford ? () => _buyItem(name, price) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: canAfford ? color : AppColors.grey400,
                  foregroundColor: AppColors.textOnPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  canAfford ? 'Buy' : 'Not enough gems',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.3, end: 0);
  }

  void _buyItem(String itemName, int price) {
    if (userGems >= price) {
      setState(() {
        userGems -= price;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$itemName purchased successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }
}

