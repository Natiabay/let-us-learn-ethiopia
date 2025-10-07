import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/core/services/api_key_manager.dart';
import 'package:tourist_assistive_app/features/setup/screens/api_setup_wizard.dart';

/// Automatic Setup Service
/// Handles automatic API key detection and setup on app startup
class AutoSetupService {
  static final AutoSetupService _instance = AutoSetupService._internal();
  factory AutoSetupService() => _instance;
  AutoSetupService._internal();

  final ApiKeyManager _apiKeyManager = ApiKeyManager();
  bool _hasShownSetup = false;

  /// Initialize automatic setup
  Future<void> initialize(BuildContext context) async {
    try {
      await _apiKeyManager.initialize();
      
      // Try auto-detection first
      final autoDetected = await _apiKeyManager.autoDetectApiKey();
      if (autoDetected) {
        debugPrint('✅ API key auto-detected successfully');
        return;
      }

      // If no API key found and we haven't shown setup yet, show setup wizard
      if (!_apiKeyManager.hasWorkingApiKey && !_hasShownSetup) {
        // Only show setup wizard if context is still mounted and app is ready
        if (context.mounted) {
          await _showSetupWizardIfNeeded(context);
        }
      }
    } catch (e) {
      debugPrint('Auto setup initialization failed: $e');
    }
  }

  /// Show setup wizard if needed
  Future<void> _showSetupWizardIfNeeded(BuildContext context) async {
    if (_hasShownSetup || !context.mounted) return;
    
    _hasShownSetup = true;
    
    // Wait a bit for the app to fully load
    await Future.delayed(const Duration(seconds: 2));
    
    if (!context.mounted) return;

    // Show setup wizard
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const ApiSetupWizard(),
    );

    if (result == true) {
      debugPrint('✅ API setup completed successfully');
    } else {
      debugPrint('ℹ️ API setup skipped by user');
    }
  }

  /// Force show setup wizard
  Future<void> showSetupWizard(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const ApiSetupWizard(),
    );

    if (result == true) {
      debugPrint('✅ API setup completed successfully');
    }
  }

  /// Check if setup is needed
  Future<bool> isSetupNeeded() async {
    await _apiKeyManager.initialize();
    return !_apiKeyManager.hasWorkingApiKey;
  }

  /// Get setup status
  Future<Map<String, dynamic>> getSetupStatus() async {
    await _apiKeyManager.initialize();
    return _apiKeyManager.getApiStatus();
  }

  /// Reset setup state (for testing)
  void resetSetupState() {
    _hasShownSetup = false;
  }
}

/// Provider for Auto Setup Service
final autoSetupServiceProvider = Provider<AutoSetupService>((ref) {
  return AutoSetupService();
});

/// Provider for setup status
final setupStatusProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final service = ref.read(autoSetupServiceProvider);
  return await service.getSetupStatus();
});

/// Provider for checking if setup is needed
final setupNeededProvider = FutureProvider<bool>((ref) async {
  final service = ref.read(autoSetupServiceProvider);
  return await service.isSetupNeeded();
});






