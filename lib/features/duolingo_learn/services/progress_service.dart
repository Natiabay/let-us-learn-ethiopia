import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/user_progress_model.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/models/onboarding_model.dart';

/// Progress Service - Handles saving and loading user progress
/// Uses SharedPreferences for persistence (can be upgraded to Hive for complex data)
class ProgressService {
  static final ProgressService _instance = ProgressService._internal();
  factory ProgressService() => _instance;
  ProgressService._internal();

  SharedPreferences? _prefs;
  bool _isInitialized = false;

  // Storage keys
  static const String _keyUserProgress = 'duolingo_user_progress';
  static const String _keyOnboardingData = 'duolingo_onboarding_data';
  static const String _keyLastSyncTime = 'duolingo_last_sync';

  /// Initialize the service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
      print('✅ Progress Service initialized');
    } catch (e) {
      print('❌ Failed to initialize Progress Service: $e');
    }
  }

  /// Save user progress
  Future<bool> saveProgress(UserProgress progress) async {
    if (!_isInitialized) await initialize();

    try {
      final jsonString = jsonEncode(progress.toJson());
      final result = await _prefs?.setString(_keyUserProgress, jsonString);
      
      if (result == true) {
        print('✅ User progress saved successfully');
        return true;
      }
      return false;
    } catch (e) {
      print('❌ Error saving user progress: $e');
      return false;
    }
  }

  /// Load user progress
  Future<UserProgress?> loadProgress(String userId) async {
    if (!_isInitialized) await initialize();

    try {
      final jsonString = _prefs?.getString(_keyUserProgress);
      
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        final progress = UserProgress.fromJson(json);
        print('✅ User progress loaded');
        return progress;
      }
      
      print('ℹ️ No saved progress found, creating new');
      return null;
    } catch (e) {
      print('❌ Error loading user progress: $e');
      return null;
    }
  }

  /// Save onboarding data
  Future<bool> saveOnboardingData(OnboardingData data) async {
    if (!_isInitialized) await initialize();

    try {
      final jsonString = jsonEncode(data.toJson());
      final result = await _prefs?.setString(_keyOnboardingData, jsonString);
      
      if (result == true) {
        print('✅ Onboarding data saved successfully');
        return true;
      }
      return false;
    } catch (e) {
      print('❌ Error saving onboarding data: $e');
      return false;
    }
  }

  /// Load onboarding data
  Future<OnboardingData?> loadOnboardingData() async {
    if (!_isInitialized) await initialize();

    try {
      final jsonString = _prefs?.getString(_keyOnboardingData);
      
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        final data = OnboardingData.fromJson(json);
        print('✅ Onboarding data loaded');
        return data;
      }
      
      print('ℹ️ No onboarding data found');
      return null;
    } catch (e) {
      print('❌ Error loading onboarding data: $e');
      return null;
    }
  }

  /// Check if onboarding is complete
  Future<bool> isOnboardingComplete() async {
    final data = await loadOnboardingData();
    return data?.isComplete ?? false;
  }

  /// Clear all progress (for testing or reset)
  Future<bool> clearAllProgress() async {
    if (!_isInitialized) await initialize();

    try {
      await _prefs?.remove(_keyUserProgress);
      await _prefs?.remove(_keyOnboardingData);
      await _prefs?.remove(_keyLastSyncTime);
      print('✅ All progress cleared');
      return true;
    } catch (e) {
      print('❌ Error clearing progress: $e');
      return false;
    }
  }

  /// Save last sync time
  Future<void> updateLastSyncTime() async {
    if (!_isInitialized) await initialize();

    try {
      await _prefs?.setString(_keyLastSyncTime, DateTime.now().toIso8601String());
    } catch (e) {
      print('❌ Error updating sync time: $e');
    }
  }

  /// Get last sync time
  Future<DateTime?> getLastSyncTime() async {
    if (!_isInitialized) await initialize();

    try {
      final timeString = _prefs?.getString(_keyLastSyncTime);
      if (timeString != null) {
        return DateTime.parse(timeString);
      }
    } catch (e) {
      print('❌ Error getting sync time: $e');
    }
    return null;
  }

  /// Export progress as JSON (for backup)
  Future<Map<String, dynamic>?> exportProgress() async {
    if (!_isInitialized) await initialize();

    try {
      final progressString = _prefs?.getString(_keyUserProgress);
      final onboardingString = _prefs?.getString(_keyOnboardingData);
      
      return {
        'progress': progressString != null ? jsonDecode(progressString) : null,
        'onboarding': onboardingString != null ? jsonDecode(onboardingString) : null,
        'exportedAt': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      print('❌ Error exporting progress: $e');
      return null;
    }
  }

  /// Import progress from JSON (for restore)
  Future<bool> importProgress(Map<String, dynamic> data) async {
    if (!_isInitialized) await initialize();

    try {
      if (data['progress'] != null) {
        await _prefs?.setString(_keyUserProgress, jsonEncode(data['progress']));
      }
      
      if (data['onboarding'] != null) {
        await _prefs?.setString(_keyOnboardingData, jsonEncode(data['onboarding']));
      }
      
      print('✅ Progress imported successfully');
      return true;
    } catch (e) {
      print('❌ Error importing progress: $e');
      return false;
    }
  }

  /// Check if user has any progress
  Future<bool> hasProgress() async {
    if (!_isInitialized) await initialize();
    return _prefs?.containsKey(_keyUserProgress) ?? false;
  }

  /// Get storage stats (for debugging)
  Future<Map<String, dynamic>> getStorageStats() async {
    if (!_isInitialized) await initialize();

    try {
      final progressString = _prefs?.getString(_keyUserProgress);
      final onboardingString = _prefs?.getString(_keyOnboardingData);
      
      return {
        'hasProgress': progressString != null,
        'hasOnboarding': onboardingString != null,
        'progressSize': progressString?.length ?? 0,
        'onboardingSize': onboardingString?.length ?? 0,
        'totalKeys': _prefs?.getKeys().length ?? 0,
      };
    } catch (e) {
      print('❌ Error getting storage stats: $e');
      return {};
    }
  }
}

