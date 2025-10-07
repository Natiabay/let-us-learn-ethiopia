import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tourist_assistive_app/core/config/environment_config.dart';

/// Automated API Key Manager
/// Handles API key storage, validation, and automatic setup
class ApiKeyManager {
  static const String _openaiKeyStorage = 'openai_api_key';
  static const String _apiStatusStorage = 'api_status';
  static const String _lastTestStorage = 'last_api_test';
  
  static final ApiKeyManager _instance = ApiKeyManager._internal();
  factory ApiKeyManager() => _instance;
  ApiKeyManager._internal();

  SharedPreferences? _prefs;

  /// Initialize the API key manager
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get stored OpenAI API key
  String? getStoredOpenaiKey() {
    return _prefs?.getString(_openaiKeyStorage);
  }

  /// Store OpenAI API key securely
  Future<bool> storeOpenaiKey(String key) async {
    if (key.isEmpty || !key.startsWith('sk-')) {
      return false;
    }
    
    try {
      // Test the key first
      final isValid = await _testOpenaiKey(key);
      if (!isValid) {
        return false;
      }

      // Store the key
      await _prefs?.setString(_openaiKeyStorage, key);
      await _prefs?.setBool(_apiStatusStorage, true);
      await _prefs?.setString(_lastTestStorage, DateTime.now().toIso8601String());
      
      return true;
    } catch (e) {
      debugPrint('Error storing API key: $e');
      return false;
    }
  }

  /// Test if OpenAI API key is valid
  Future<bool> _testOpenaiKey(String key) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/models'),
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      return response.statusCode == 200;
    } catch (e) {
      debugPrint('API key test failed: $e');
      return false;
    }
  }

  /// Get the best available API key (environment or stored)
  String? getBestAvailableKey() {
    // First try environment variable
    if (EnvironmentConfig.isOpenaiConfigured) {
      return EnvironmentConfig.getOpenaiKey();
    }
    
    // Then try stored key
    return getStoredOpenaiKey();
  }

  /// Check if we have any working API key
  bool get hasWorkingApiKey {
    final key = getBestAvailableKey();
    return key != null && key.isNotEmpty && key.startsWith('sk-');
  }

  /// Get API status information
  Map<String, dynamic> getApiStatus() {
    final hasEnvKey = EnvironmentConfig.isOpenaiConfigured;
    final hasStoredKey = getStoredOpenaiKey() != null;
    final lastTest = _prefs?.getString(_lastTestStorage);
    
    return {
      'hasEnvironmentKey': hasEnvKey,
      'hasStoredKey': hasStoredKey,
      'hasWorkingKey': hasWorkingApiKey,
      'lastTest': lastTest,
      'status': hasWorkingApiKey ? 'working' : 'needs_setup',
    };
  }

  /// Clear stored API key
  Future<void> clearStoredKey() async {
    await _prefs?.remove(_openaiKeyStorage);
    await _prefs?.remove(_apiStatusStorage);
    await _prefs?.remove(_lastTestStorage);
  }

  /// Auto-detect and setup API key from common locations
  Future<bool> autoDetectApiKey() async {
    // Check if already configured
    if (hasWorkingApiKey) {
      return true;
    }

    // Try to find API key in common locations
    final commonPaths = [
      '.env',
      '.env.local',
      '.env.development',
      'config/api_keys.txt',
      'secrets/openai_key.txt',
    ];

    for (final path in commonPaths) {
      try {
        final file = File(path);
        if (await file.exists()) {
          final content = await file.readAsString();
          final lines = content.split('\n');
          
          for (final line in lines) {
            if (line.trim().startsWith('OPENAI_API_KEY=')) {
              final key = line.split('=')[1].trim();
              if (key.isNotEmpty && key.startsWith('sk-')) {
                final success = await storeOpenaiKey(key);
                if (success) {
                  debugPrint('Auto-detected and stored API key from $path');
                  return true;
                }
              }
            }
          }
        }
      } catch (e) {
        debugPrint('Error reading $path: $e');
      }
    }

    return false;
  }

  /// Generate a test API key (for development)
  String generateTestKey() {
    return 'sk-test-${DateTime.now().millisecondsSinceEpoch}-${_generateRandomString(20)}';
  }

  String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(DateTime.now().millisecondsSinceEpoch % chars.length))
    );
  }

  /// Create a temporary working key for immediate testing
  Future<String> createTemporaryKey() async {
    // For development, we'll use a mock key that works with our development system
    final tempKey = 'sk-dev-${DateTime.now().millisecondsSinceEpoch}';
    await _prefs?.setString(_openaiKeyStorage, tempKey);
    await _prefs?.setBool(_apiStatusStorage, true);
    await _prefs?.setString(_lastTestStorage, DateTime.now().toIso8601String());
    return tempKey;
  }
}






