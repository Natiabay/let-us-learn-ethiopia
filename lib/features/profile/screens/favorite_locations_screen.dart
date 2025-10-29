import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteLocationsScreen extends ConsumerStatefulWidget {
  const FavoriteLocationsScreen({super.key});

  @override
  ConsumerState<FavoriteLocationsScreen> createState() => _FavoriteLocationsScreenState();
}

class _FavoriteLocationsScreenState extends ConsumerState<FavoriteLocationsScreen> {
  // Professional navy blue theme colors
  static const Color _navyBlue = Color(0xFF0A1929);
  static const Color _navyCard = Color(0xFF1A2F44);
  static const Color _turquoise = Color(0xFF00D9B8);
  static const Color _yellow = Color(0xFFFFD43B);
  static const Color _blue = Color(0xFF1CB0F6);
  static const Color _red = Color(0xFFFF4B4B);
  static const Color _textPrimary = Color(0xFFFFFFFF);
  static const Color _textSecondary = Color(0xFFB3B3B3);
  static const Color _textTertiary = Color(0xFF8B949E);

  // Sample favorite locations data
  final List<Map<String, dynamic>> _favoriteLocations = [
    {
      'id': 'lalibela',
      'name': 'Rock-Hewn Churches of Lalibela',
      'category': 'Historical',
      'image': 'assets/images/Lalibela.png',
      'rating': 4.9,
      'city': 'Lalibela',
      'isFavorite': true,
    },
    {
      'id': 'axum',
      'name': 'Axum Obelisks',
      'category': 'Historical',
      'image': 'assets/images/Axum.png',
      'rating': 4.8,
      'city': 'Axum',
      'isFavorite': true,
    },
    {
      'id': 'danakil',
      'name': 'Danakil Depression',
      'category': 'Natural',
      'image': 'assets/images/Danakil.png',
      'rating': 4.7,
      'city': 'Afar Region',
      'isFavorite': true,
    },
    {
      'id': 'bale',
      'name': 'Bale Mountains National Park',
      'category': 'Natural',
      'image': 'assets/images/Bale.png',
      'rating': 4.8,
      'city': 'Bale',
      'isFavorite': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navyBlue,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _navyCard,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: _textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Favorite Locations',
        style: TextStyle(
          color: _textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: _textPrimary),
          onPressed: () => _showSearchDialog(),
        ),
        IconButton(
          icon: const Icon(Icons.sort, color: _textPrimary),
          onPressed: () => _showSortDialog(),
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (_favoriteLocations.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        _buildStatsSection(),
        Expanded(
          child: _buildLocationsList(),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _turquoise.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: _turquoise.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              icon: Icons.favorite,
              label: 'Favorites',
              value: '${_favoriteLocations.length}',
              color: _red,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: _textTertiary,
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.star,
              label: 'Avg Rating',
              value: '4.8',
              color: _yellow,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: _textTertiary,
          ),
          Expanded(
            child: _buildStatItem(
              icon: Icons.location_on,
              label: 'Cities',
              value: '4',
              color: _blue,
            ),
          ),
        ],
      ),
    );
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
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: _textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: _textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _favoriteLocations.length,
      itemBuilder: (context, index) {
        final location = _favoriteLocations[index];
        return _buildLocationCard(location, index);
      },
    );
  }

  Widget _buildLocationCard(Map<String, dynamic> location, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _turquoise.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: _turquoise.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _navigateToLocation(location),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLocationImage(location),
            _buildLocationInfo(location),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationImage(Map<String, dynamic> location) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_turquoise.withValues(alpha: 0.3), _blue.withValues(alpha: 0.3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Image.asset(
              location['image'],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_turquoise.withValues(alpha: 0.3), _blue.withValues(alpha: 0.3)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.landscape,
                    size: 60,
                    color: _textPrimary,
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: _buildCategoryBadge(location['category']),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: _buildRatingBadge(location['rating']),
        ),
        Positioned(
          bottom: 12,
          right: 12,
          child: _buildFavoriteButton(location),
        ),
      ],
    );
  }

  Widget _buildCategoryBadge(String category) {
    Color color;
    switch (category.toLowerCase()) {
      case 'historical':
        color = _yellow;
        break;
      case 'natural':
        color = _blue;
        break;
      case 'cultural':
        color = _red;
        break;
      default:
        color = _turquoise;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: _textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildRatingBadge(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _navyCard.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _navyBlue.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: _yellow, size: 16),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(Map<String, dynamic> location) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: _navyCard.withValues(alpha: 0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _navyBlue.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          location['isFavorite'] ? Icons.favorite : Icons.favorite_border,
          color: location['isFavorite'] ? _red : _textSecondary,
          size: 20,
        ),
        onPressed: () => _toggleFavorite(location),
      ),
    );
  }

  Widget _buildLocationInfo(Map<String, dynamic> location) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            location['name'],
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, color: _textSecondary, size: 16),
              const SizedBox(width: 4),
              Text(
                location['city'],
                style: const TextStyle(
                  color: _textSecondary,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              _buildActionButtons(location),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> location) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.share, color: _turquoise, size: 20),
          onPressed: () => _shareLocation(location),
        ),
        IconButton(
          icon: const Icon(Icons.directions, color: _blue, size: 20),
          onPressed: () => _getDirections(location),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: _turquoise.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_border,
              size: 60,
              color: _turquoise,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Favorite Locations',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Start exploring and add locations\nto your favorites!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _textSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.explore),
            label: const Text('Explore Locations'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _turquoise,
              foregroundColor: _navyBlue,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToLocation(Map<String, dynamic> location) {
    // Navigate to location detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${location['name']}...'),
        backgroundColor: _turquoise,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _toggleFavorite(Map<String, dynamic> location) {
    setState(() {
      location['isFavorite'] = !location['isFavorite'];
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          location['isFavorite'] 
            ? 'Added to favorites' 
            : 'Removed from favorites'
        ),
        backgroundColor: location['isFavorite'] ? _red : _textTertiary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _shareLocation(Map<String, dynamic> location) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${location['name']}...'),
        backgroundColor: _turquoise,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _getDirections(Map<String, dynamic> location) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Getting directions to ${location['name']}...'),
        backgroundColor: _blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _navyCard,
        title: const Text('Search Favorites', style: TextStyle(color: _textPrimary)),
        content: const TextField(
          style: TextStyle(color: _textPrimary),
          decoration: InputDecoration(
            hintText: 'Search by name or category...',
            hintStyle: TextStyle(color: _textSecondary),
            prefixIcon: Icon(Icons.search, color: _turquoise),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Search', style: TextStyle(color: _turquoise)),
          ),
        ],
      ),
    );
  }

  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _navyCard,
        title: const Text('Sort Favorites', style: TextStyle(color: _textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSortOption('Name (A-Z)', true),
            _buildSortOption('Name (Z-A)', false),
            _buildSortOption('Rating (High to Low)', false),
            _buildSortOption('Recently Added', false),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Sort', style: TextStyle(color: _turquoise)),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption(String option, bool isSelected) {
    return ListTile(
      title: Text(option, style: const TextStyle(color: _textPrimary)),
      trailing: isSelected ? const Icon(Icons.check, color: _turquoise) : null,
      onTap: () => Navigator.pop(context),
    );
  }
}
