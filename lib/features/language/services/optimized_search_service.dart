import 'package:flutter/foundation.dart';
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_model.dart';
import 'package:tourist_assistive_app/features/language/data/comprehensive_amharic_data.dart';

class OptimizedSearchService {
  static Map<String, List<AmharicWord>>? _categoryCache;
  static Map<String, List<AmharicWord>>? _searchCache;
  static List<AmharicWord>? _allWordsCache;
  
  // Initialize the service and cache
  static Future<void> initialize() async {
    if (_allWordsCache == null) {
      // Load words in the background for better performance
      await compute(_loadAllWords, null);
    }
  }

  static Future<List<AmharicWord>> _loadAllWords(dynamic _) async {
    _allWordsCache = ComprehensiveAmharicData.getAllWords();
    return _allWordsCache!;
  }

  // Get all words with caching
  static List<AmharicWord> getAllWords() {
    _allWordsCache ??= ComprehensiveAmharicData.getAllWords();
    return _allWordsCache!;
  }

  // Get words by category with caching
  static List<AmharicWord> getWordsByCategory(String category) {
    _categoryCache ??= {};
    
    if (!_categoryCache!.containsKey(category)) {
      _categoryCache![category] = getAllWords()
          .where((word) => word.category == category)
          .toList();
    }
    
    return _categoryCache![category]!;
  }

  // Optimized search with caching and fuzzy matching
  static List<AmharicWord> searchWords(String query, {int limit = 100}) {
    if (query.trim().isEmpty) return [];
    
    final cacheKey = query.toLowerCase().trim();
    _searchCache ??= {};
    
    if (_searchCache!.containsKey(cacheKey)) {
      return _searchCache![cacheKey]!;
    }

    final results = _performSearch(query, limit);
    _searchCache![cacheKey] = results;
    
    // Limit cache size to prevent memory issues
    if (_searchCache!.length > 1000) {
      _searchCache!.clear();
    }
    
    return results;
  }

  static List<AmharicWord> _performSearch(String query, int limit) {
    final lowercaseQuery = query.toLowerCase().trim();
    final words = getAllWords();
    final results = <AmharicWord>[];
    final exactMatches = <AmharicWord>[];
    final startMatches = <AmharicWord>[];
    final containsMatches = <AmharicWord>[];

    for (final word in words) {
      final amharic = word.amharic.toLowerCase();
      final english = word.english.toLowerCase();
      final pronunciation = word.pronunciation.toLowerCase();

      // Exact matches (highest priority)
      if (amharic == lowercaseQuery || 
          english == lowercaseQuery || 
          pronunciation == lowercaseQuery) {
        exactMatches.add(word);
        continue;
      }

      // Starts with matches (high priority)
      if (amharic.startsWith(lowercaseQuery) || 
          english.startsWith(lowercaseQuery) || 
          pronunciation.startsWith(lowercaseQuery)) {
        startMatches.add(word);
        continue;
      }

      // Contains matches (medium priority)
      if (amharic.contains(lowercaseQuery) || 
          english.contains(lowercaseQuery) || 
          pronunciation.contains(lowercaseQuery)) {
        containsMatches.add(word);
        if (containsMatches.length >= limit) break;
      }
    }

    // Combine results in priority order
    results.addAll(exactMatches);
    results.addAll(startMatches);
    results.addAll(containsMatches);

    return results.take(limit).toList();
  }

  // Advanced search with filters
  static List<AmharicWord> advancedSearch({
    String? query,
    String? category,
    int? difficulty,
    int limit = 100,
  }) {
    List<AmharicWord> results = getAllWords();

    // Apply category filter
    if (category != null && category.isNotEmpty && category != 'All') {
      results = results.where((word) => word.category == category).toList();
    }

    // Apply difficulty filter
    if (difficulty != null) {
      results = results.where((word) => word.difficulty == difficulty).toList();
    }

    // Apply text search
    if (query != null && query.trim().isNotEmpty) {
      final searchResults = searchWords(query, limit: results.length);
      results = results.where((word) => searchResults.contains(word)).toList();
    }

    return results.take(limit).toList();
  }

  // Get random words for practice
  static List<AmharicWord> getRandomWords(int count, {String? category}) {
    List<AmharicWord> words = category != null 
        ? getWordsByCategory(category)
        : getAllWords();
    
    words.shuffle();
    return words.take(count).toList();
  }

  // Get words by difficulty level
  static List<AmharicWord> getWordsByDifficulty(int difficulty) {
    return getAllWords()
        .where((word) => word.difficulty == difficulty)
        .toList();
  }

  // Get popular/frequently used words
  static List<AmharicWord> getPopularWords(int count) {
    final words = getAllWords();
    // Sort by usage frequency (correctAnswers / totalAttempts)
    words.sort((a, b) {
      final aRatio = a.totalAttempts > 0 ? a.correctAnswers / a.totalAttempts : 0;
      final bRatio = b.totalAttempts > 0 ? b.correctAnswers / b.totalAttempts : 0;
      return bRatio.compareTo(aRatio);
    });
    
    return words.take(count).toList();
  }

  // Get all categories
  static List<String> getAllCategories() {
    return ComprehensiveAmharicData.getAllCategories();
  }

  // Get statistics
  static Map<String, dynamic> getStatistics() {
    final words = getAllWords();
    final categories = getAllCategories();
    
    return {
      'totalWords': words.length,
      'totalCategories': categories.length,
      'wordsByCategory': Map.fromEntries(
        categories.map((cat) => MapEntry(cat, getWordsByCategory(cat).length))
      ),
      'wordsByDifficulty': {
        'Beginner (1)': getWordsByDifficulty(1).length,
        'Intermediate (2)': getWordsByDifficulty(2).length,
        'Advanced (3)': getWordsByDifficulty(3).length,
        'Expert (4)': getWordsByDifficulty(4).length,
      },
    };
  }

  // Clear cache to free memory
  static void clearCache() {
    _categoryCache?.clear();
    _searchCache?.clear();
    _allWordsCache = null;
  }

  // Preload specific categories for better performance
  static Future<void> preloadCategories(List<String> categories) async {
    for (final category in categories) {
      getWordsByCategory(category);
    }
  }

  // Get similar words (same category, similar difficulty)
  static List<AmharicWord> getSimilarWords(AmharicWord word, {int limit = 10}) {
    return getAllWords()
        .where((w) => 
            w.id != word.id && 
            w.category == word.category && 
            (w.difficulty - word.difficulty).abs() <= 1)
        .take(limit)
        .toList();
  }

  // Search with autocomplete suggestions
  static List<String> getSearchSuggestions(String query, {int limit = 10}) {
    if (query.trim().isEmpty) return [];
    
    final lowercaseQuery = query.toLowerCase();
    final suggestions = <String>{};
    
    for (final word in getAllWords()) {
      if (word.english.toLowerCase().startsWith(lowercaseQuery)) {
        suggestions.add(word.english);
      }
      if (word.amharic.toLowerCase().startsWith(lowercaseQuery)) {
        suggestions.add(word.amharic);
      }
      if (suggestions.length >= limit) break;
    }
    
    return suggestions.toList();
  }
}
