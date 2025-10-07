/// ENHANCED WORD MODEL WITH MULTI-LANGUAGE SUPPORT
class AmharicWordModel {
  final String amharic;
  final String english;
  final String pronunciation;
  final String category;
  final String? chinese;
  final String? french;
  final String? german;
  final String? spanish;
  final String? arabic;
  final String? portuguese;
  final String? russian;
  final String? japanese;
  final String? hindi;
  final String? italian;
  final String? audioUrl;
  final String? imageUrl;
  final List<String>? examples;
  final Map<String, String>? culturalContext;

  AmharicWordModel({
    required this.amharic,
    required this.english,
    required this.pronunciation,
    required this.category,
    this.chinese,
    this.french,
    this.german,
    this.spanish,
    this.arabic,
    this.portuguese,
    this.russian,
    this.japanese,
    this.hindi,
    this.italian,
    this.audioUrl,
    this.imageUrl,
    this.examples,
    this.culturalContext,
  });

  String getTranslation(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'en': return english;
      case 'zh': return chinese ?? english;
      case 'fr': return french ?? english;
      case 'de': return german ?? english;
      case 'es': return spanish ?? english;
      case 'ar': return arabic ?? english;
      case 'pt': return portuguese ?? english;
      case 'ru': return russian ?? english;
      case 'ja': return japanese ?? english;
      case 'hi': return hindi ?? english;
      case 'it': return italian ?? english;
      default: return english;
    }
  }
}

























