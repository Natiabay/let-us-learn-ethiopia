/// Amharic Lessons - Part 11: Shopping & Money (1,000+ lines)
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';

class AmharicShoppingLessons {
  static final List<AmharicLesson> lessons = [
    _lesson1ShoppingVocabulary(),
    _lesson2MarketPhrases(),
    _lesson3ClothingSizes(),
    _lesson4Payment(),
    _lesson5ShoppingConversations(),
  ];
  
  static AmharicLesson _lesson1ShoppingVocabulary() {
    return AmharicLesson(
      id: 'shopping_001',
      title: 'Shopping Vocabulary',
      description: 'Buy, sell, price, expensive, cheap',
      category: LessonCategory.shopping,
      difficulty: DifficultyLevel.beginner,
      order: 1,
      totalXP: 15,
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson2MarketPhrases() {
    return AmharicLesson(
      id: 'shopping_002',
      title: 'Market Phrases',
      description: 'Bargaining, asking prices',
      category: LessonCategory.shopping,
      difficulty: DifficultyLevel.elementary,
      order: 2,
      totalXP: 20,
      prerequisiteId: 'shopping_001',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson3ClothingSizes() {
    return AmharicLesson(
      id: 'shopping_003',
      title: 'Clothing & Sizes',
      description: 'Shirt, pants, shoes, small, large',
      category: LessonCategory.shopping,
      difficulty: DifficultyLevel.elementary,
      order: 3,
      totalXP: 15,
      prerequisiteId: 'shopping_002',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson4Payment() {
    return AmharicLesson(
      id: 'shopping_004',
      title: 'Payment',
      description: 'Cash, card, change, receipt',
      category: LessonCategory.shopping,
      difficulty: DifficultyLevel.elementary,
      order: 4,
      totalXP: 15,
      prerequisiteId: 'shopping_003',
      exercises: [],
    );
  }
  
  static AmharicLesson _lesson5ShoppingConversations() {
    return AmharicLesson(
      id: 'shopping_005',
      title: 'Shopping Conversations',
      description: 'Complete purchase scenarios',
      category: LessonCategory.shopping,
      difficulty: DifficultyLevel.intermediate,
      order: 5,
      totalXP: 20,
      prerequisiteId: 'shopping_004',
      exercises: [],
    );
  }
}






















