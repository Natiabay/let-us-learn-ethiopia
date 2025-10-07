import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/features/locations/models/location_model.dart';
import 'package:tourist_assistive_app/features/locations/data/ethiopian_locations.dart';
import 'package:tourist_assistive_app/features/locations/data/global_locations.dart';

class LocationsState {
  final List<LocationModel> locations;
  final List<LocationModel> filteredLocations;
  final bool isLoading;
  final String? error;
  final String searchQuery;
  final String selectedCategory;
  final String selectedRegion;
  final String selectedCountry;
  final bool showEthiopianOnly;

  const LocationsState({
    this.locations = const [],
    this.filteredLocations = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
    this.selectedCategory = 'All',
    this.selectedRegion = 'All',
    this.selectedCountry = 'All',
    this.showEthiopianOnly = false,
  });

  LocationsState copyWith({
    List<LocationModel>? locations,
    List<LocationModel>? filteredLocations,
    bool? isLoading,
    String? error,
    String? searchQuery,
    String? selectedCategory,
    String? selectedRegion,
    String? selectedCountry,
    bool? showEthiopianOnly,
  }) {
    return LocationsState(
      locations: locations ?? this.locations,
      filteredLocations: filteredLocations ?? this.filteredLocations,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      showEthiopianOnly: showEthiopianOnly ?? this.showEthiopianOnly,
    );
  }
}

class LocationsNotifier extends StateNotifier<LocationsState> {
  LocationsNotifier() : super(const LocationsState()) {
    loadLocations();
  }

  Future<void> loadLocations() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Load global locations with Ethiopian emphasis
      final globalLocations = GlobalLocations.all;
      print('🌍 Loading ${globalLocations.length} global locations...');
      
      if (globalLocations.isEmpty) {
        print('⚠️ No global locations found');
        state = state.copyWith(
          isLoading: false,
          error: 'No locations available',
        );
        return;
      }
      
      // Convert global locations to LocationModel
      final locations = globalLocations.map((location) => LocationModel(
        id: location.id,
        name: location.name,
        description: location.description,
        category: location.category,
        city: location.city,
        latitude: location.latitude,
        longitude: location.longitude,
        rating: location.rating,
        imageUrl: location.imageUrl,
        isFavorite: location.isFavorite,
        openingHours: location.openingHours,
        entryFee: location.entryFee,
        features: location.features,
        // Add global-specific fields
        country: location.country,
        region: location.region,
        isEthiopian: location.isEthiopian,
        priority: location.priority,
        tags: location.tags,
      )).toList();
      
      print('🌍 Successfully loaded ${locations.length} global locations');
      print('🇪🇹 Ethiopian locations: ${locations.where((l) => l.isEthiopian == true).length}');
      print('🌍 Other locations: ${locations.where((l) => l.isEthiopian != true).length}');
      
      state = state.copyWith(
        locations: locations,
        filteredLocations: locations,
        isLoading: false,
      );
    } catch (e) {
      print('❌ Error loading global locations: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void searchLocations(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void filterByCategory(String category) {
    state = state.copyWith(selectedCategory: category);
    _applyFilters();
  }

  void filterByRegion(String region) {
    state = state.copyWith(selectedRegion: region);
    _applyFilters();
  }

  void filterByCountry(String country) {
    state = state.copyWith(selectedCountry: country);
    _applyFilters();
  }

  void toggleEthiopianOnly() {
    state = state.copyWith(showEthiopianOnly: !state.showEthiopianOnly);
    _applyFilters();
  }

  void _applyFilters() {
    final filtered = state.locations.where((location) {
      // Search filter
      final matchesSearch = state.searchQuery.isEmpty ||
          location.name.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          location.description.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          location.city.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (location.country?.toLowerCase().contains(state.searchQuery.toLowerCase()) ?? false);
      
      // Category filter
      final matchesCategory = state.selectedCategory == 'All' || 
                             location.category == state.selectedCategory;
      
      // Region filter
      final matchesRegion = state.selectedRegion == 'All' || 
                           location.region == state.selectedRegion;
      
      // Country filter
      final matchesCountry = state.selectedCountry == 'All' || 
                            location.country == state.selectedCountry;
      
      // Ethiopian only filter
      final matchesEthiopianOnly = !state.showEthiopianOnly || (location.isEthiopian == true);
      
      return matchesSearch && matchesCategory && matchesRegion && matchesCountry && matchesEthiopianOnly;
    }).toList();
    
    // Sort by priority (Ethiopian first, then by rating)
    filtered.sort((a, b) {
      if ((a.isEthiopian == true) && (b.isEthiopian != true)) return -1;
      if ((a.isEthiopian != true) && (b.isEthiopian == true)) return 1;
      return b.rating.compareTo(a.rating);
    });
    
    state = state.copyWith(filteredLocations: filtered);
  }

  void toggleFavorite(String locationId) {
    final updatedLocations = state.locations.map((location) {
      if (location.id == locationId) {
        return location.copyWith(isFavorite: !location.isFavorite);
      }
      return location;
    }).toList();
    
    final updatedFiltered = state.filteredLocations.map((location) {
      if (location.id == locationId) {
        return location.copyWith(isFavorite: !location.isFavorite);
      }
      return location;
    }).toList();
    
    state = state.copyWith(
      locations: updatedLocations,
      filteredLocations: updatedFiltered,
    );
  }

}

final locationsProvider = StateNotifierProvider<LocationsNotifier, LocationsState>((ref) {
  return LocationsNotifier();
});