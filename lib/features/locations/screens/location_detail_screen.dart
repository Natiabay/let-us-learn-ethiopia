import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/locations/providers/locations_provider.dart';
import 'package:tourist_assistive_app/core/data/comprehensive_ethiopia_database.dart';

class LocationDetailScreen extends ConsumerWidget {
  final String locationId;

  const LocationDetailScreen({
    super.key,
    required this.locationId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationsState = ref.watch(locationsProvider);
    final location = locationsState.locations.cast<dynamic>().firstWhere(
      (loc) => loc.id == locationId,
      orElse: () => null,
    );

    if (location == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Location Not Found'),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
        ),
        body: const Center(
          child: Text('Location not found'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                location.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.8),
                      AppColors.primary.withValues(alpha: 0.6),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getLocationIcon(location.category),
                    size: 100,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic Information
                  _buildInfoCard(
                    context,
                    '📍 Location Information',
                    [
                      _buildInfoRow('Name', location.name),
                      _buildInfoRow('Category', location.category),
                      _buildInfoRow('City', location.city),
                      _buildInfoRow('Description', location.description),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Features (if available)
                  if (location.features != null && location.features!.isNotEmpty)
                    _buildInfoCard(
                      context,
                      '✨ Features',
                      location.features!.map((feature) => 
                        _buildInfoRow('•', feature.toString())
                      ).toList(),
                    ),
                  
                  const SizedBox(height: 16),
                  
                  // Activities (if available)
                  if (location.activities != null && location.activities!.isNotEmpty)
                    _buildInfoCard(
                      context,
                      '🎯 Activities',
                      location.activities!.map((activity) => 
                        _buildInfoRow('•', activity.toString())
                      ).toList(),
                    ),
                  
                  const SizedBox(height: 16),
                  
                  // Tips (if available)
                  if (location.tips != null && location.tips!.isNotEmpty)
                    _buildInfoCard(
                      context,
                      '💡 Travel Tips',
                      location.tips!.map((tip) => 
                        _buildInfoRow('•', tip.toString())
                      ).toList(),
                    ),
                  
                  const SizedBox(height: 16),
                  
                  // Additional Information from Database
                  _buildAdditionalInfo(context),
                  
                  const SizedBox(height: 16),
                  
                  // Action Buttons
                  _buildActionButtons(context),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo(BuildContext context) {
    // Get additional information from the comprehensive database
    final cityInfo = ComprehensiveEthiopiaDatabase.cities[locationId];
    
    if (cityInfo == null) return const SizedBox.shrink();
    
    return _buildInfoCard(
      context,
      '🏙️ City Information',
      [
        if (cityInfo['population'] != null)
          _buildInfoRow('Population', cityInfo['population']),
        if (cityInfo['elevation'] != null)
          _buildInfoRow('Elevation', cityInfo['elevation']),
        if (cityInfo['climate'] != null)
          _buildInfoRow('Climate', cityInfo['climate']),
        if (cityInfo['bestTimeToVisit'] != null)
          _buildInfoRow('Best Time to Visit', cityInfo['bestTimeToVisit']),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Navigate to map
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening map...')),
              );
            },
            icon: const Icon(Icons.map),
            label: const Text('View on Map'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // Get directions
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Getting directions...')),
              );
            },
            icon: const Icon(Icons.directions),
            label: const Text('Directions'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  IconData _getLocationIcon(String category) {
    switch (category.toLowerCase()) {
      case 'historical':
        return Icons.history_edu_rounded;
      case 'natural':
        return Icons.nature_rounded;
      case 'cultural':
        return Icons.museum_rounded;
      case 'religious':
        return Icons.church_rounded;
      case 'adventure':
        return Icons.hiking_rounded;
      case 'food & drink':
        return Icons.restaurant_rounded;
      case 'shopping':
        return Icons.shopping_bag_rounded;
      default:
        return Icons.location_on_rounded;
    }
  }
}















