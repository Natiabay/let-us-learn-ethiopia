import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/core/services/api_key_manager.dart';

/// Provider for API Key Manager
final apiKeyManagerProvider = Provider<ApiKeyManager>((ref) {
  return ApiKeyManager();
});

/// Provider for API status
final apiStatusProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final apiManager = ref.read(apiKeyManagerProvider);
  await apiManager.initialize();
  return apiManager.getApiStatus();
});

/// Provider for checking if setup is needed
final needsSetupProvider = FutureProvider<bool>((ref) async {
  final apiManager = ref.read(apiKeyManagerProvider);
  await apiManager.initialize();
  return !apiManager.hasWorkingApiKey;
});

/// Provider for auto-detection status
final autoDetectionProvider = FutureProvider<bool>((ref) async {
  final apiManager = ref.read(apiKeyManagerProvider);
  await apiManager.initialize();
  return await apiManager.autoDetectApiKey();
});

















































