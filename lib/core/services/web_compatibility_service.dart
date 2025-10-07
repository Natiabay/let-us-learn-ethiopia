import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Service to handle web platform compatibility issues
class WebCompatibilityService {
  /// Check if the current platform supports the given feature
  static bool supportsFeature(String feature) {
    if (kIsWeb) {
      switch (feature) {
        case 'file_operations':
        case 'camera':
        case 'microphone':
        case 'location':
        case 'storage':
          return false;
        case 'audio_playback':
        case 'network_requests':
        case 'ui_rendering':
          return true;
        default:
          return true;
      }
    }
    return true;
  }
  
  /// Get a fallback message for unsupported features
  static String getFallbackMessage(String feature) {
    if (kIsWeb) {
      switch (feature) {
        case 'file_operations':
          return 'File operations are not available on web. Please use the mobile app for full functionality.';
        case 'camera':
          return 'Camera access is limited on web. Please use the mobile app for camera features.';
        case 'microphone':
          return 'Microphone access is limited on web. Please use the mobile app for voice features.';
        case 'location':
          return 'Location services are limited on web. Please use the mobile app for location features.';
        case 'storage':
          return 'Local storage is limited on web. Please use the mobile app for offline features.';
        default:
          return 'This feature is not available on web. Please use the mobile app.';
      }
    }
    return 'Feature not available on this platform.';
  }
  
  /// Show a platform-specific dialog for unsupported features
  static void showUnsupportedFeatureDialog(BuildContext context, String feature) {
    if (kIsWeb) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Feature Not Available'),
          content: Text(getFallbackMessage(feature)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  
  /// Get platform-specific widget for unsupported features
  static Widget getUnsupportedFeatureWidget(String feature) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.grey[600],
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'Feature Not Available',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            getFallbackMessage(feature),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  
  /// Check if a service should be initialized
  static bool shouldInitializeService(String serviceName) {
    if (kIsWeb) {
      switch (serviceName) {
        case 'file_service':
        case 'camera_service':
        case 'microphone_service':
        case 'location_service':
          return false;
        default:
          return true;
      }
    }
    return true;
  }
  
  /// Get platform-specific configuration
  static Map<String, dynamic> getPlatformConfig() {
    if (kIsWeb) {
      return {
        'supports_file_operations': false,
        'supports_camera': false,
        'supports_microphone': false,
        'supports_location': false,
        'supports_storage': false,
        'supports_audio_playback': true,
        'supports_network_requests': true,
        'supports_ui_rendering': true,
        'platform': 'web',
      };
    } else {
      return {
        'supports_file_operations': true,
        'supports_camera': true,
        'supports_microphone': true,
        'supports_location': true,
        'supports_storage': true,
        'supports_audio_playback': true,
        'supports_network_requests': true,
        'supports_ui_rendering': true,
        'platform': 'mobile',
      };
    }
  }
}



















































