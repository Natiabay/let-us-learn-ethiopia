import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/features/language/services/google_cloud_translation_service.dart';

// Provider for Google Cloud Translation Service
final googleTranslationServiceProvider = Provider<GoogleCloudTranslationService>((ref) {
  // TODO: Replace with your actual Google Cloud API key
  const String apiKey = 'YOUR_GOOGLE_CLOUD_API_KEY_HERE';
  return GoogleCloudTranslationService(apiKey: apiKey);
});

// Provider for translation state
final translationStateProvider = StateNotifierProvider<TranslationStateNotifier, TranslationState>((ref) {
  final service = ref.watch(googleTranslationServiceProvider);
  return TranslationStateNotifier(service);
});

class TranslationState {
  final bool isLoading;
  final String? error;
  final String? translatedText;
  final String? detectedLanguage;

  const TranslationState({
    this.isLoading = false,
    this.error,
    this.translatedText,
    this.detectedLanguage,
  });

  TranslationState copyWith({
    bool? isLoading,
    String? error,
    String? translatedText,
    String? detectedLanguage,
  }) {
    return TranslationState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      translatedText: translatedText ?? this.translatedText,
      detectedLanguage: detectedLanguage ?? this.detectedLanguage,
    );
  }
}

class TranslationStateNotifier extends StateNotifier<TranslationState> {
  final GoogleCloudTranslationService _service;

  TranslationStateNotifier(this._service) : super(const TranslationState());

  Future<void> translateText({
    required String text,
    required String fromLanguage,
    required String toLanguage,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final translatedText = await _service.translateText(
        text: text,
        fromLanguage: fromLanguage,
        toLanguage: toLanguage,
      );
      
      state = state.copyWith(
        isLoading: false,
        translatedText: translatedText,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> translateToAmharic(String englishText) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final translatedText = await _service.translateToAmharic(englishText);
      
      state = state.copyWith(
        isLoading: false,
        translatedText: translatedText,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> translateToEnglish(String amharicText) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final translatedText = await _service.translateToEnglish(amharicText);
      
      state = state.copyWith(
        isLoading: false,
        translatedText: translatedText,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> detectLanguage(String text) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final detectedLanguage = await _service.detectLanguage(text);
      
      state = state.copyWith(
        isLoading: false,
        detectedLanguage: detectedLanguage,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clearState() {
    state = const TranslationState();
  }
}

