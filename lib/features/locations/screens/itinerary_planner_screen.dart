import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/features/locations/models/itinerary_model.dart';
import 'package:tourist_assistive_app/features/locations/data/ethiopian_locations.dart';

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

class ItineraryPlannerScreen extends StatefulWidget {
  const ItineraryPlannerScreen({super.key});

  @override
  State<ItineraryPlannerScreen> createState() => _ItineraryPlannerScreenState();
}

class _ItineraryPlannerScreenState extends State<ItineraryPlannerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<dynamic> _selectedLocations = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          'Plan Your Journey',
          style: TextStyle(
            color: LocationsColors.pureWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: LocationsColors.turquoise,
          labelColor: LocationsColors.turquoise,
          unselectedLabelColor: LocationsColors.mediumGray,
          tabs: const [
            Tab(text: 'Tour Packages'),
            Tab(text: 'Custom Plan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTourPackages(),
          _buildCustomPlanner(),
        ],
      ),
    );
  }

  Widget _buildTourPackages() {
    final packages = EthiopianTourPackages.all;

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: packages.length,
      itemBuilder: (context, index) {
        final package = packages[index];
        return _buildPackageCard(package, index);
      },
    );
  }

  Widget _buildPackageCard(TourPackage package, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: LocationsColors.navyCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: LocationsColors.turquoise.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  LocationsColors.turquoise.withValues(alpha: 0.3),
                  LocationsColors.brightBlue.withValues(alpha: 0.3),
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: LocationsColors.turquoise,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.card_travel_rounded,
                    color: LocationsColors.deepNavy,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.name,
                        style: const TextStyle(
                          color: LocationsColors.pureWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor(package.difficulty).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _getDifficultyColor(package.difficulty),
                              ),
                            ),
                            child: Text(
                              package.difficulty,
                              style: TextStyle(
                                color: _getDifficultyColor(package.difficulty),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.access_time_rounded,
                            color: LocationsColors.lightGray,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${package.durationDays} Days',
                            style: const TextStyle(
                              color: LocationsColors.lightGray,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package.description,
                  style: const TextStyle(
                    color: LocationsColors.lightGray,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Highlights',
                  style: TextStyle(
                    color: LocationsColors.pureWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...package.highlights.map((highlight) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: LocationsColors.brightGreen,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            highlight,
                            style: const TextStyle(
                              color: LocationsColors.lightGray,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoSection(
                        'Included',
                        package.included,
                        LocationsColors.brightGreen,
                        Icons.check_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInfoSection(
                        'Not Included',
                        package.excluded,
                        LocationsColors.brightRed,
                        Icons.close_rounded,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showPackageDetails(package),
                    icon: const Icon(Icons.info_outline_rounded),
                    label: const Text('View Full Itinerary'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LocationsColors.turquoise,
                      foregroundColor: LocationsColors.deepNavy,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (100 * index).ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildInfoSection(
    String title,
    List<String> items,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...items.take(3).map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '• $item',
                style: TextStyle(
                  color: color.withValues(alpha: 0.8),
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCustomPlanner() {
    final locations = EthiopianLocations.all;

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                LocationsColors.navyCard,
                LocationsColors.deepNavy,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: LocationsColors.brightYellow.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.edit_calendar_rounded,
                      color: LocationsColors.brightYellow,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Build Your Itinerary',
                          style: TextStyle(
                            color: LocationsColors.pureWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Select places you want to visit',
                          style: TextStyle(
                            color: LocationsColors.lightGray,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_selectedLocations.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: LocationsColors.turquoise.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: LocationsColors.turquoise.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        color: LocationsColors.turquoise,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${_selectedLocations.length} locations selected',
                          style: const TextStyle(
                            color: LocationsColors.turquoise,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _generateItinerary,
                        child: const Text(
                          'Generate',
                          style: TextStyle(
                            color: LocationsColors.brightYellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ).animate().fadeIn(duration: 400.ms),
        // Locations List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              final isSelected = _selectedLocations.contains(location);

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: LocationsColors.navyCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? LocationsColors.turquoise
                        : LocationsColors.turquoise.withValues(alpha: 0.2),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      location.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: LocationsColors.turquoise.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.place_rounded,
                            color: LocationsColors.turquoise,
                          ),
                        );
                      },
                    ),
                  ),
                  title: Text(
                    location.name,
                    style: const TextStyle(
                      color: LocationsColors.pureWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(location.category).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          location.category,
                          style: TextStyle(
                            color: _getCategoryColor(location.category),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          _selectedLocations.add(location);
                        } else {
                          _selectedLocations.remove(location);
                        }
                      });
                    },
                    activeColor: LocationsColors.turquoise,
                    checkColor: LocationsColors.deepNavy,
                  ),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedLocations.remove(location);
                      } else {
                        _selectedLocations.add(location);
                      }
                    });
                  },
                ),
              ).animate().fadeIn(delay: (50 * index).ms);
            },
          ),
        ),
      ],
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return LocationsColors.brightGreen;
      case 'moderate':
        return LocationsColors.brightYellow;
      case 'challenging':
        return LocationsColors.brightRed;
      default:
        return LocationsColors.brightBlue;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'historical':
        return LocationsColors.brightYellow;
      case 'nature':
        return LocationsColors.brightGreen;
      case 'cultural':
        return LocationsColors.turquoise;
      case 'religious':
        return LocationsColors.brightBlue;
      case 'adventure':
        return LocationsColors.brightRed;
      default:
        return LocationsColors.turquoise;
    }
  }

  void _showPackageDetails(TourPackage package) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
            color: LocationsColors.deepNavy,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: LocationsColors.mediumGray,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: LocationsColors.turquoise.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.article_rounded,
                        color: LocationsColors.turquoise,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            package.name,
                            style: const TextStyle(
                              color: LocationsColors.pureWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Complete Itinerary',
                            style: const TextStyle(
                              color: LocationsColors.lightGray,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      color: LocationsColors.mediumGray,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'This is a sample itinerary. Full day-by-day details would be displayed here with activities, meals, accommodations, and more.',
                        style: TextStyle(
                          color: LocationsColors.lightGray,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _bookPackage(package);
                          },
                          icon: const Icon(Icons.check_circle_rounded),
                          label: const Text('Book This Package'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LocationsColors.turquoise,
                            foregroundColor: LocationsColors.deepNavy,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _generateItinerary() {
    if (_selectedLocations.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: LocationsColors.navyCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.auto_awesome_rounded,
                color: LocationsColors.turquoise,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Itinerary Generated!',
                  style: TextStyle(
                    color: LocationsColors.pureWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            'Your custom ${_selectedLocations.length}-stop itinerary has been created! '
            'You can now view detailed day-by-day plans and booking options.',
            style: const TextStyle(
              color: LocationsColors.lightGray,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'View Details',
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

  void _bookPackage(TourPackage package) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking ${package.name}...'),
        backgroundColor: LocationsColors.navyCard,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}


