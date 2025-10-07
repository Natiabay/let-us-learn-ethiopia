import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Language provider to manage app language settings
final languageProvider = StateNotifierProvider<LanguageNotifier, String>((ref) {
  return LanguageNotifier();
});

class LanguageNotifier extends StateNotifier<String> {
  LanguageNotifier() : super('en') {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString('selected_language') ?? 'en';
      state = savedLanguage;
    } catch (e) {
      // Fallback to English if loading fails
      state = 'en';
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_language', languageCode);
      state = languageCode;
    } catch (e) {
      // Handle error silently, keep current state
    }
  }

  String get currentLanguage => state;
  
  bool get isAmharic => state == 'am';
  bool get isEnglish => state == 'en';
  
  String getLocalizedString(String english, String amharic) {
    return isAmharic ? amharic : english;
  }
}