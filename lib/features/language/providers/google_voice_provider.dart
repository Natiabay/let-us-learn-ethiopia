import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/features/language/services/google_voice_service.dart';

// Provider for Google Voice Service
final googleVoiceServiceProvider = Provider<GoogleVoiceService>((ref) {
  final service = GoogleVoiceService();
  ref.onDispose(() => service.dispose());
  return service;
});

// Provider for voice state
final voiceStateProvider = StateNotifierProvider<VoiceStateNotifier, VoiceState>((ref) {
  final service = ref.watch(googleVoiceServiceProvider);
  return VoiceStateNotifier(service);
});

class VoiceState {
  final bool isListening;
  final bool isSpeaking;
  final bool isInitialized;
  final String? error;
  final String? lastRecognizedText;

  const VoiceState({
    this.isListening = false,
    this.isSpeaking = false,
    this.isInitialized = false,
    this.error,
    this.lastRecognizedText,
  });

  VoiceState copyWith({
    bool? isListening,
    bool? isSpeaking,
    bool? isInitialized,
    String? error,
    String? lastRecognizedText,
  }) {
    return VoiceState(
      isListening: isListening ?? this.isListening,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      isInitialized: isInitialized ?? this.isInitialized,
      error: error,
      lastRecognizedText: lastRecognizedText ?? this.lastRecognizedText,
    );
  }
}

class VoiceStateNotifier extends StateNotifier<VoiceState> {
  final GoogleVoiceService _service;

  VoiceStateNotifier(this._service) : super(const VoiceState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _service.initialize();
      state = state.copyWith(isInitialized: true);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> speak(String text, {String language = 'en-US'}) async {
    state = state.copyWith(isSpeaking: true, error: null);
    
    try {
      await _service.speak(text, language: language);
      state = state.copyWith(isSpeaking: false);
    } catch (e) {
      state = state.copyWith(isSpeaking: false, error: e.toString());
    }
  }

  Future<void> speakAmharic(String text) async {
    await speak(text, language: 'am-ET');
  }

  Future<void> speakEnglish(String text) async {
    await speak(text, language: 'en-US');
  }

  Future<void> startListening() async {
    state = state.copyWith(isListening: true, error: null);
    
    try {
      await _service.startListening(
        onResult: (text) {
          state = state.copyWith(
            isListening: false,
            lastRecognizedText: text,
          );
        },
        onError: (error) {
          state = state.copyWith(
            isListening: false,
            error: error,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isListening: false,
        error: e.toString(),
      );
    }
  }

  Future<void> stopListening() async {
    await _service.stopListening();
    state = state.copyWith(isListening: false);
  }

  Future<void> stopSpeaking() async {
    await _service.stopSpeaking();
    state = state.copyWith(isSpeaking: false);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

