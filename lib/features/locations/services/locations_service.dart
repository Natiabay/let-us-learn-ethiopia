import 'package:tourist_assistive_app/features/locations/models/location.dart';
import 'package:tourist_assistive_app/features/locations/data/ethiopian_locations.dart';

class LocationsService {
  Future<List<Location>> getLocations() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    return EthiopianLocations.all;
  }

  Future<List<Location>> getLocationsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return EthiopianLocations.getByCategory(category);
  }

  Future<List<Location>> getFeaturedLocations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return EthiopianLocations.getFeatured();
  }

  Future<List<Location>> searchLocations(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (query.isEmpty) return EthiopianLocations.all;
    
    final lowercaseQuery = query.toLowerCase();
    return EthiopianLocations.all.where((location) {
      return location.name.toLowerCase().contains(lowercaseQuery) ||
             location.description.toLowerCase().contains(lowercaseQuery) ||
             location.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery)) ||
             location.category.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  Future<Location?> getLocationById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    try {
      return EthiopianLocations.all.firstWhere((location) => location.id == id);
    } catch (e) {
      return null;
    }
  }
}
