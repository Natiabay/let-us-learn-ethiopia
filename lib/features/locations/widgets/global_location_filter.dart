import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/locations/data/global_locations.dart';

/// Global Location Filter Widget
/// Provides filtering options for worldwide tourist destinations
/// with special emphasis on Ethiopian locations
class GlobalLocationFilter extends StatefulWidget {
  final String selectedRegion;
  final String selectedCountry;
  final String selectedCategory;
  final Function(String region, String country, String category) onFilterChanged;
  final bool showEthiopianEmphasis;

  const GlobalLocationFilter({
    super.key,
    required this.selectedRegion,
    required this.selectedCountry,
    required this.selectedCategory,
    required this.onFilterChanged,
    this.showEthiopianEmphasis = true,
  });

  @override
  State<GlobalLocationFilter> createState() => _GlobalLocationFilterState();
}

class _GlobalLocationFilterState extends State<GlobalLocationFilter> {
  late String _selectedRegion;
  late String _selectedCountry;
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedRegion = widget.selectedRegion;
    _selectedCountry = widget.selectedCountry;
    _selectedCategory = widget.selectedCategory;
  }

  @override
  void didUpdateWidget(GlobalLocationFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedRegion != widget.selectedRegion ||
        oldWidget.selectedCountry != widget.selectedCountry ||
        oldWidget.selectedCategory != widget.selectedCategory) {
      setState(() {
        _selectedRegion = widget.selectedRegion;
        _selectedCountry = widget.selectedCountry;
        _selectedCategory = widget.selectedCategory;
      });
    }
  }

  List<String> get _regions {
    final regions = GlobalLocations.all.map((loc) => loc.region).toSet().toList();
    regions.sort();
    return ['All', ...regions];
  }

  List<String> get _countries {
    List<String> countries = GlobalLocations.all.map((loc) => loc.country).toSet().toList();
    countries.sort();
    
    // Put Ethiopia first if showing emphasis
    if (widget.showEthiopianEmphasis && countries.contains('Ethiopia')) {
      countries.remove('Ethiopia');
      countries.insert(0, 'Ethiopia');
    }
    
    return ['All', ...countries];
  }

  List<String> get _categories {
    final categories = GlobalLocations.all.map((loc) => loc.category).toSet().toList();
    categories.sort();
    return ['All', ...categories];
  }

  void _onRegionChanged(String? region) {
    if (region != null) {
      setState(() {
        _selectedRegion = region;
        _selectedCountry = 'All'; // Reset country when region changes
      });
      widget.onFilterChanged(_selectedRegion, _selectedCountry, _selectedCategory);
    }
  }

  void _onCountryChanged(String? country) {
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
      widget.onFilterChanged(_selectedRegion, _selectedCountry, _selectedCategory);
    }
  }

  void _onCategoryChanged(String? category) {
    if (category != null) {
      setState(() {
        _selectedCategory = category;
      });
      widget.onFilterChanged(_selectedRegion, _selectedCountry, _selectedCategory);
    }
  }

  void _resetFilters() {
    setState(() {
      _selectedRegion = 'All';
      _selectedCountry = 'All';
      _selectedCategory = 'All';
    });
    widget.onFilterChanged(_selectedRegion, _selectedCountry, _selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Ethiopian emphasis
          Row(
            children: [
              Icon(
                Icons.public,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Global Destinations',
                style: AppTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              if (widget.showEthiopianEmphasis) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.flag, color: Colors.red, size: 12),
                      SizedBox(width: 4),
                      Text(
                        '🇪🇹 Ethiopian Focus',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              TextButton.icon(
                onPressed: _resetFilters,
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Reset'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  textStyle: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Filter Controls
          Row(
            children: [
              // Region Filter
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Region',
                      style: AppTheme.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      value: _selectedRegion,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                      ),
                      items: _regions.map((region) => DropdownMenuItem(
                        value: region,
                        child: Text(
                          region,
                          style: AppTheme.bodySmall,
                        ),
                      )).toList(),
                      onChanged: _onRegionChanged,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              
              // Country Filter
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Country',
                      style: AppTheme.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      value: _selectedCountry,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                      ),
                      items: _countries.map((country) => DropdownMenuItem(
                        value: country,
                        child: Row(
                          children: [
                            if (country == 'Ethiopia' && widget.showEthiopianEmphasis)
                              const Text('🇪🇹 ', style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Text(
                                country,
                                style: AppTheme.bodySmall.copyWith(
                                  fontWeight: country == 'Ethiopia' && widget.showEthiopianEmphasis
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: country == 'Ethiopia' && widget.showEthiopianEmphasis
                                      ? Colors.red
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                      onChanged: _onCountryChanged,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              
              // Category Filter
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category',
                      style: AppTheme.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                      ),
                      items: _categories.map((category) => DropdownMenuItem(
                        value: category,
                        child: Row(
                          children: [
                            Icon(
                              _getCategoryIcon(category),
                              size: 16,
                              color: _getCategoryColor(category),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              category,
                              style: AppTheme.bodySmall,
                            ),
                          ],
                        ),
                      )).toList(),
                      onChanged: _onCategoryChanged,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Quick Filter Chips
          const SizedBox(height: 16),
          Text(
            'Quick Filters',
            style: AppTheme.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildQuickFilterChip('🇪🇹 Ethiopian Sites', () {
                _onRegionChanged('Africa');
                _onCountryChanged('Ethiopia');
              }),
              _buildQuickFilterChip('🌍 UNESCO Sites', () {
                // Filter for high-rated sites (likely UNESCO)
                _onCategoryChanged('Historical');
              }),
              _buildQuickFilterChip('🏔️ Nature', () {
                _onCategoryChanged('Nature');
              }),
              _buildQuickFilterChip('🏛️ Historical', () {
                _onCategoryChanged('Historical');
              }),
              _buildQuickFilterChip('🎭 Cultural', () {
                _onCategoryChanged('Cultural');
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilterChip(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: AppTheme.bodySmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Historical':
        return Icons.museum_rounded;
      case 'Nature':
        return Icons.landscape_rounded;
      case 'Adventure':
        return Icons.hiking_rounded;
      case 'Cultural':
        return Icons.theater_comedy_rounded;
      case 'Religious':
        return Icons.church_rounded;
      case 'Food':
        return Icons.restaurant_rounded;
      case 'Shopping':
        return Icons.shopping_bag_rounded;
      case 'Art':
        return Icons.palette_rounded;
      default:
        return Icons.place_rounded;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Historical':
        return AppColors.primary;
      case 'Nature':
        return AppColors.success;
      case 'Adventure':
        return AppColors.warning;
      case 'Cultural':
        return AppColors.info;
      case 'Religious':
        return AppColors.secondary;
      case 'Food':
        return AppColors.error;
      case 'Shopping':
        return AppColors.accent;
      case 'Art':
        return AppColors.primaryLight;
      default:
        return AppColors.grey;
    }
  }
}




























