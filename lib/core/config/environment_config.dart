import 'package:flutter/foundation.dart';

/// Environment configuration for API keys and sensitive data
/// This class manages environment variables and provides secure access to API keys
class EnvironmentConfig {
  static const String _openaiApiKey = String.fromEnvironment(
    'OPENAI_API_KEY',
    defaultValue: '',
  );
  
  static const String _googleCloudApiKey = String.fromEnvironment(
    'GOOGLE_CLOUD_API_KEY',
    defaultValue: '',
  );
  
  static const String _googleMapsApiKey = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
    defaultValue: '',
  );
  
  static const String _telebirrApiKey = String.fromEnvironment(
    'TELEBIRR_API_KEY',
    defaultValue: '',
  );
  
  static const String _santimpayApiKey = String.fromEnvironment(
    'SANTIMPAY_API_KEY',
    defaultValue: '',
  );
  
  static const String _googleTranslateApiKey = String.fromEnvironment(
    'GOOGLE_TRANSLATE_API_KEY',
    defaultValue: '',
  );

  // Getters for API keys
  static String get openaiApiKey => _openaiApiKey;
  static String get googleCloudApiKey => _googleCloudApiKey;
  static String get googleMapsApiKey => _googleMapsApiKey;
  static String get telebirrApiKey => _telebirrApiKey;
  static String get santimpayApiKey => _santimpayApiKey;
  static String get googleTranslateApiKey => _googleTranslateApiKey;

  // Validation methods
  static bool get isOpenaiConfigured => _openaiApiKey.isNotEmpty;
  static bool get isGoogleCloudConfigured => _googleCloudApiKey.isNotEmpty;
  static bool get isGoogleMapsConfigured => _googleMapsApiKey.isNotEmpty;
  static bool get isTelebirrConfigured => _telebirrApiKey.isNotEmpty;
  static bool get isSantimpayConfigured => _santimpayApiKey.isNotEmpty;
  static bool get isGoogleTranslateConfigured => _googleTranslateApiKey.isNotEmpty;

  // Check if all required APIs are configured
  static bool get isFullyConfigured => 
      isOpenaiConfigured && 
      isGoogleCloudConfigured && 
      isGoogleMapsConfigured;

  // Get configuration status for debugging
  static Map<String, bool> get configurationStatus => {
    'OpenAI': isOpenaiConfigured,
    'Google Cloud': isGoogleCloudConfigured,
    'Google Maps': isGoogleMapsConfigured,
    'Telebirr': isTelebirrConfigured,
    'SantimPay': isSantimpayConfigured,
    'Google Translate': isGoogleTranslateConfigured,
  };

  // Development fallback keys (only for development)
  static String get _developmentOpenaiKey => 
      kDebugMode ? 'sk-dev-development-mode' : '';
  static String get _developmentGoogleCloudKey => 
      kDebugMode ? 'dev-google-cloud-development' : '';
  static String get _developmentGoogleMapsKey => 
      kDebugMode ? 'dev-google-maps-development' : '';
  static String get _developmentTelebirrKey => 
      kDebugMode ? 'dev-telebirr-development' : '';
  static String get _developmentSantimpayKey => 
      kDebugMode ? 'dev-santimpay-development' : '';
  static String get _developmentGoogleTranslateKey => 
      kDebugMode ? 'dev-google-translate-development' : '';

  // Get API key with fallback for development
  static String getOpenaiKey() {
    if (isOpenaiConfigured) return _openaiApiKey;
    if (kDebugMode) return _developmentOpenaiKey;
    throw Exception('OpenAI API key not configured. Please set OPENAI_API_KEY environment variable.');
  }

  static String getGoogleCloudKey() {
    if (isGoogleCloudConfigured) return _googleCloudApiKey;
    if (kDebugMode) return _developmentGoogleCloudKey;
    throw Exception('Google Cloud API key not configured. Please set GOOGLE_CLOUD_API_KEY environment variable.');
  }

  static String getGoogleMapsKey() {
    if (isGoogleMapsConfigured) return _googleMapsApiKey;
    if (kDebugMode) return _developmentGoogleMapsKey;
    throw Exception('Google Maps API key not configured. Please set GOOGLE_MAPS_API_KEY environment variable.');
  }

  static String getTelebirrKey() {
    if (isTelebirrConfigured) return _telebirrApiKey;
    if (kDebugMode) return _developmentTelebirrKey;
    throw Exception('Telebirr API key not configured. Please set TELEBIRR_API_KEY environment variable.');
  }

  static String getSantimpayKey() {
    if (isSantimpayConfigured) return _santimpayApiKey;
    if (kDebugMode) return _developmentSantimpayKey;
    throw Exception('SantimPay API key not configured. Please set SANTIMPAY_API_KEY environment variable.');
  }

  static String getGoogleTranslateKey() {
    if (isGoogleTranslateConfigured) return _googleTranslateApiKey;
    if (kDebugMode) return _developmentGoogleTranslateKey;
    throw Exception('Google Translate API key not configured. Please set GOOGLE_TRANSLATE_API_KEY environment variable.');
  }
}

