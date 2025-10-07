import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OfflineService {
  static const String _locationsKey = 'cached_locations';
  static const String _lessonsKey = 'cached_lessons';
  static const String _progressKey = 'cached_progress';
  static const String _lastSyncKey = 'last_sync_time';

  // Cache management
  Future<void> cacheData(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data));
    await prefs.setString(_lastSyncKey, DateTime.now().toIso8601String());
  }

  Future<T?> getCachedData<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedString = prefs.getString(key);
    if (cachedString != null) {
      return jsonDecode(cachedString) as T;
    }
    return null;
  }

  Future<bool> isDataCached(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<DateTime?> getLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSyncString = prefs.getString(_lastSyncKey);
    if (lastSyncString != null) {
      return DateTime.parse(lastSyncString);
    }
    return null;
  }

  Future<bool> shouldSync() async {
    final lastSync = await getLastSyncTime();
    if (lastSync == null) return true;
    
    // Sync if more than 1 hour has passed
    return DateTime.now().difference(lastSync).inHours > 1;
  }

  // Specific cache methods
  Future<void> cacheLocations(List<Map<String, dynamic>> locations) async {
    await cacheData(_locationsKey, locations);
  }

  Future<List<Map<String, dynamic>>?> getCachedLocations() async {
    final data = await getCachedData<List<dynamic>>(_locationsKey);
    return data?.cast<Map<String, dynamic>>();
  }

  Future<void> cacheLessons(List<Map<String, dynamic>> lessons) async {
    await cacheData(_lessonsKey, lessons);
  }

  Future<List<Map<String, dynamic>>?> getCachedLessons() async {
    final data = await getCachedData<List<dynamic>>(_lessonsKey);
    return data?.cast<Map<String, dynamic>>();
  }

  Future<void> cacheProgress(Map<String, dynamic> progress) async {
    await cacheData(_progressKey, progress);
  }

  Future<Map<String, dynamic>?> getCachedProgress() async {
    return await getCachedData<Map<String, dynamic>>(_progressKey);
  }

  // Clear cache
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_locationsKey);
    await prefs.remove(_lessonsKey);
    await prefs.remove(_progressKey);
    await prefs.remove(_lastSyncKey);
  }

  Future<void> clearSpecificCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Download essential content for offline use
  Future<void> downloadEssentialContent() async {
    // This would typically download and cache essential content
    // For now, we'll cache the current data
    try {
      // Cache would be populated from actual API calls
      await Future.delayed(const Duration(seconds: 2)); // Simulate download
    } catch (e) {
      throw Exception('Failed to download essential content: $e');
    }
  }

  // Check if essential content is available offline
  Future<bool> isEssentialContentAvailable() async {
    final hasLocations = await isDataCached(_locationsKey);
    final hasLessons = await isDataCached(_lessonsKey);
    return hasLocations && hasLessons;
  }
}




















