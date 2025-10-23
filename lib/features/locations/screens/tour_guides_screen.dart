import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/locations/screens/imaginative_tour_screen.dart';

class LocationsColors {
  static const deepNavy = Color(0xFF0A1929);
  static const navyCard = Color(0xFF1A2F44);
  static const turquoise = Color(0xFF00D9B8);
  static const brightYellow = Color(0xFFFFD43B);
  static const brightBlue = Color(0xFF1CB0F6);
  static const brightGreen = Color(0xFF4CAF50);
  static const brightRed = Color(0xFFFF4B4B);
  static const pureWhite = Color(0xFFFFFFFF);
  static const lightGray = Color(0xFFE2E8F0);
  static const mediumGray = Color(0xFF94A3B8);
}

class TourGuidesScreen extends StatefulWidget {
  const TourGuidesScreen({super.key});

  @override
  State<TourGuidesScreen> createState() => _TourGuidesScreenState();
}

class _TourGuidesScreenState extends State<TourGuidesScreen> {
  String _selectedTourType = 'All';
  final List<String> _tourTypes = [
    'All',
    'Historical Sites',
    'Nature & Wildlife',
    'Adventure Tours',
    'Cultural Tours',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LocationsColors.deepNavy,
      appBar: AppBar(
        backgroundColor: LocationsColors.navyCard,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Imaginative Tours of Ethiopia',
          style: TextStyle(
            color: LocationsColors.pureWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: _showTourInfo,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          _buildTourTypeFilters(),
          Expanded(
            child: _buildTourOptions(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            LocationsColors.navyCard,
            LocationsColors.deepNavy,
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: LocationsColors.turquoise.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.tour_rounded,
              color: LocationsColors.turquoise,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Virtual Tour Experience',
                  style: TextStyle(
                    color: LocationsColors.pureWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Explore Ethiopia through imagination with photos and stories',
                  style: TextStyle(
                    color: LocationsColors.lightGray,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildTourTypeFilters() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _tourTypes.length,
        itemBuilder: (context, index) {
          final tourType = _tourTypes[index];
          final isSelected = tourType == _selectedTourType;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(tourType),
              labelStyle: TextStyle(
                color: isSelected
                    ? LocationsColors.deepNavy
                    : LocationsColors.lightGray,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              backgroundColor: LocationsColors.navyCard,
              selectedColor: LocationsColors.turquoise,
              checkmarkColor: LocationsColors.deepNavy,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? LocationsColors.turquoise
                      : LocationsColors.mediumGray,
                ),
              ),
              onSelected: (selected) {
                setState(() {
                  _selectedTourType = tourType;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildTourOptions() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildTourCard(
          title: 'Complete Ethiopia Tour',
          description: 'Experience all major historical and natural sites of Ethiopia through an immersive virtual journey',
          icon: Icons.explore_rounded,
          color: LocationsColors.turquoise,
          onTap: () => _startImaginativeTour(),
        ),
        const SizedBox(height: 16),
        _buildTourCard(
          title: 'Historical Sites Tour',
          description: 'Discover Lalibela, Axum, and other UNESCO World Heritage sites with detailed historical context',
          icon: Icons.account_balance_rounded,
          color: LocationsColors.brightYellow,
          onTap: () => _startHistoricalTour(),
        ),
        const SizedBox(height: 16),
        _buildTourCard(
          title: 'Nature & Wildlife Tour',
          description: 'Explore Bale Mountains, Danakil Depression, and Ethiopia\'s incredible natural wonders',
          icon: Icons.landscape_rounded,
          color: LocationsColors.brightGreen,
          onTap: () => _startNatureTour(),
        ),
        const SizedBox(height: 16),
        _buildTourCard(
          title: 'Cultural Heritage Tour',
          description: 'Immerse yourself in Ethiopian culture, traditions, and the vibrant city of Harar',
          icon: Icons.theater_comedy_rounded,
          color: LocationsColors.brightBlue,
          onTap: () => _startCulturalTour(),
        ),
        const SizedBox(height: 16),
        _buildTourCard(
          title: 'Adventure & Extreme Tour',
          description: 'Experience the most extreme and adventurous locations Ethiopia has to offer',
          icon: Icons.terrain_rounded,
          color: LocationsColors.brightRed,
          onTap: () => _startAdventureTour(),
        ),
        const SizedBox(height: 20),
        _buildInfoCard(),
      ],
    );
  }

  Widget _buildTourCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: LocationsColors.navyCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: LocationsColors.pureWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      color: LocationsColors.lightGray,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: LocationsColors.turquoise,
              size: 20,
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.3, end: 0);
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: LocationsColors.turquoise.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: LocationsColors.turquoise.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_rounded,
                color: LocationsColors.turquoise,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'About Imaginative Tours',
                style: TextStyle(
                  color: LocationsColors.turquoise,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'These virtual tours use real photos from Ethiopian historical sites and provide detailed information to help you imagine being there. Perfect for planning your actual visit or experiencing Ethiopia from anywhere in the world.',
            style: TextStyle(
              color: LocationsColors.lightGray,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  void _startImaginativeTour() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ImaginativeTourScreen(),
      ),
    );
  }

  void _startHistoricalTour() {
    // TODO: Implement historical-specific tour
    _startImaginativeTour();
  }

  void _startNatureTour() {
    // TODO: Implement nature-specific tour
    _startImaginativeTour();
  }

  void _startCulturalTour() {
    // TODO: Implement cultural-specific tour
    _startImaginativeTour();
  }

  void _startAdventureTour() {
    // TODO: Implement adventure-specific tour
    _startImaginativeTour();
  }

  void _showTourInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: LocationsColors.navyCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.tour_rounded,
                color: LocationsColors.turquoise,
              ),
              SizedBox(width: 12),
              Text(
                'Imaginative Tours',
                style: TextStyle(
                  color: LocationsColors.pureWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'Imaginative tours use real photos and detailed information to help you visualize and experience Ethiopian locations virtually. This is perfect for:\n\n'
            '• Planning your actual visit\n'
            '• Learning about Ethiopian history\n'
            '• Experiencing Ethiopia from anywhere\n'
            '• Getting inspired to travel\n\n'
            'Each tour includes real photos, historical context, and immersive descriptions to help you imagine being there.',
            style: TextStyle(
              color: LocationsColors.lightGray,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Got it',
                style: TextStyle(
                  color: LocationsColors.turquoise,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
