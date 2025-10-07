class Word {
  final int id;
  final String amharic;
  final String english;
  final String pronunciation;
  final String? audioUrl;
  final String? imageUrl;
  final String category;
  final List<String> examples;
  final String? partOfSpeech;
  final int difficulty; // 1-5 scale
  final bool isLearned;
  final int correctAnswers;
  final int totalAttempts;

  Word({
    required this.id,
    required this.amharic,
    required this.english,
    required this.pronunciation,
    this.audioUrl,
    this.imageUrl,
    required this.category,
    this.examples = const [],
    this.partOfSpeech,
    this.difficulty = 1,
    this.isLearned = false,
    this.correctAnswers = 0,
    this.totalAttempts = 0,
  });

  Word copyWith({
    int? id,
    String? amharic,
    String? english,
    String? pronunciation,
    String? audioUrl,
    String? imageUrl,
    String? category,
    List<String>? examples,
    String? partOfSpeech,
    int? difficulty,
    bool? isLearned,
    int? correctAnswers,
    int? totalAttempts,
  }) {
    return Word(
      id: id ?? this.id,
      amharic: amharic ?? this.amharic,
      english: english ?? this.english,
      pronunciation: pronunciation ?? this.pronunciation,
      audioUrl: audioUrl ?? this.audioUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      examples: examples ?? this.examples,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      difficulty: difficulty ?? this.difficulty,
      isLearned: isLearned ?? this.isLearned,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      totalAttempts: totalAttempts ?? this.totalAttempts,
    );
  }

  double get accuracy {
    if (totalAttempts == 0) return 0.0;
    return correctAnswers / totalAttempts;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amharic': amharic,
      'english': english,
      'pronunciation': pronunciation,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'category': category,
      'examples': examples,
      'partOfSpeech': partOfSpeech,
      'difficulty': difficulty,
      'isLearned': isLearned,
      'correctAnswers': correctAnswers,
      'totalAttempts': totalAttempts,
    };
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'],
      amharic: json['amharic'],
      english: json['english'],
      pronunciation: json['pronunciation'],
      audioUrl: json['audioUrl'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      examples: List<String>.from(json['examples'] ?? []),
      partOfSpeech: json['partOfSpeech'],
      difficulty: json['difficulty'] ?? 1,
      isLearned: json['isLearned'] ?? false,
      correctAnswers: json['correctAnswers'] ?? 0,
      totalAttempts: json['totalAttempts'] ?? 0,
    );
  }
}

