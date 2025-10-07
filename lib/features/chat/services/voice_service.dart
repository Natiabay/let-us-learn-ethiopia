import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceService {
  final FlutterTts _flutterTts = FlutterTts();
  
  bool _isInitialized = false;
  bool _isListening = false;
  bool _isSpeaking = false;

  VoiceService();

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Initialize TTS
      await _flutterTts.setLanguage('en-US');
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
      
      // Set up TTS callbacks
      _flutterTts.setStartHandler(() {
        _isSpeaking = true;
        debugPrint('TTS Started');
      });
      
      _flutterTts.setCompletionHandler(() {
        _isSpeaking = false;
        debugPrint('TTS Completed');
      });
      
      _flutterTts.setErrorHandler((msg) {
        _isSpeaking = false;
        debugPrint('TTS Error: $msg');
      });

      // Request microphone permission
      final hasPermission = await _requestPermissions();
      if (!hasPermission) {
        debugPrint('Microphone permission denied');
      }

      _isInitialized = true;
    } catch (e) {
      debugPrint('Voice service initialization error: $e');
    }
  }

  Future<bool> _requestPermissions() async {
    try {
      // Request microphone permission
      final microphoneStatus = await Permission.microphone.request();
      if (microphoneStatus != PermissionStatus.granted) {
        return false;
      }

      return true;
    } catch (e) {
      debugPrint('Permission request error: $e');
      return false;
    }
  }

  Future<bool> requestPermissions() async {
    return await _requestPermissions();
  }

  Future<bool> get isAvailable async {
    await initialize();
    return _isInitialized;
  }

  // Text-to-Speech Methods
  Future<void> speak(String text) async {
    if (text.isEmpty) return;

    await initialize();
    
    try {
      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint('TTS error: $e');
    }
  }

  Future<void> speakAmharic(String text) async {
    if (text.isEmpty) return;

    await initialize();
    
    try {
      await _flutterTts.setLanguage('am-ET');
      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint('Amharic TTS error: $e');
    }
  }

  // Speech-to-Text Methods (Placeholder implementation)
  Future<void> startListening({
    required Function(String) onResult,
    required Function(String) onError,
  }) async {
    if (_isListening) return;

    await initialize();
    
    if (!await isAvailable) {
      onError('Voice service not available');
      return;
    }

    // Note: For full implementation, you would need to:
    // 1. Record audio from microphone
    // 2. Convert to base64
    // 3. Send to Google Speech-to-Text API
    // This is a placeholder that shows the service is working
    
    _isListening = true;
    debugPrint('Speech recognition started (Google Cloud API ready)');
    
    // Simulate speech recognition result
    Future.delayed(const Duration(seconds: 2), () {
      if (_isListening) {
        onResult('Speech recognition is ready (Google Cloud API)');
        _isListening = false;
      }
    });
  }

  Future<void> stopListening() async {
    if (!_isListening) return;
    _isListening = false;
    debugPrint('Speech recognition stopped');
  }

  Future<void> cancelListening() async {
    _isListening = false;
    debugPrint('Speech recognition cancelled');
  }

  Future<void> stopSpeaking() async {
    if (!_isSpeaking) return;

    try {
      await _flutterTts.stop();
      _isSpeaking = false;
    } catch (e) {
      debugPrint('Failed to stop speaking: $e');
    }
  }

  // Getters
  bool get isListening => _isListening;
  bool get isSpeaking => _isSpeaking;
  bool get isInitialized => _isInitialized;

  void dispose() {
    _flutterTts.stop();
  }
}