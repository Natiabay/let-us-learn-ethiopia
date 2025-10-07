import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart';
import 'package:tourist_assistive_app/features/language/data/english_amharic_lessons.dart';
import 'package:tourist_assistive_app/features/language/data/arabic_amharic_lessons.dart';
import 'package:tourist_assistive_app/features/language/data/french_amharic_lessons.dart';
import 'package:tourist_assistive_app/features/language/data/spanish_amharic_lessons.dart';
import 'package:tourist_assistive_app/features/language/data/german_amharic_lessons.dart';
import 'package:tourist_assistive_app/features/language/data/portuguese_amharic_lessons.dart';
import 'package:tourist_assistive_app/features/language/data/chinese_amharic_lessons.dart';
import 'package:tourist_assistive_app/features/language/data/japanese_amharic_lessons.dart';
import 'package:tourist_assistive_app/features/language/data/italian_amharic_lessons.dart';
import 'package:tourist_assistive_app/features/language/data/russian_amharic_lessons.dart';
import 'package:tourist_assistive_app/features/language/data/hindi_amharic_lessons.dart';
import 'package:tourist_assistive_app/features/language/data/comprehensive_lesson_expansion.dart';

class MultilingualAmharicLessons {
  // English → Amharic Lessons (60+ comprehensive lessons)
  static List<Lesson> getEnglishLessons() {
    return EnglishAmharicLessons.getEnglishAmharicLessons();
  }

  // Arabic → Amharic Lessons (60+ comprehensive lessons)
  static List<Lesson> getArabicLessons() {
    return ArabicAmharicLessons.getAllLessons();
  }
  
  // French → Amharic Lessons (60+ comprehensive lessons)
  static List<Lesson> getFrenchLessons() {
    return FrenchAmharicLessons.getFrenchAmharicLessons();
  }
  
  // Spanish → Amharic Lessons (60+ comprehensive lessons)
  static List<Lesson> getSpanishLessons() {
    return SpanishAmharicLessons.getSpanishAmharicLessons();
  }
  
  // German → Amharic Lessons (60+ comprehensive lessons)
  static List<Lesson> getGermanLessons() {
    return GermanAmharicLessons.getGermanAmharicLessons();
  }
  
  // Italian → Amharic Lessons (60+ comprehensive lessons)
  static List<Lesson> getItalianLessons() {
    final baseItalianLessons = ItalianAmharicLessons.getAllLessons();
    if (baseItalianLessons.length >= 50) {
      return baseItalianLessons;
    }
    // If less than 50, add comprehensive expansion lessons
    return [...baseItalianLessons, ...ComprehensiveLessonExpansion.generateAdditionalItalianLessons()];
  }
  
  // Portuguese → Amharic Lessons (60+ comprehensive lessons)
  static List<Lesson> getPortugueseLessons() {
    final basePortugueseLessons = PortugueseAmharicLessons.getAllLessons();
    if (basePortugueseLessons.length >= 50) {
      return basePortugueseLessons;
    }
    // If less than 50, add comprehensive expansion lessons
    return [...basePortugueseLessons, ...ComprehensiveLessonExpansion.generateAdditionalPortugueseLessons()];
  }
  
  // Russian → Amharic Lessons (60+ comprehensive lessons)
  static List<Lesson> getRussianLessons() {
    final baseRussianLessons = RussianAmharicLessons.getAllLessons();
    if (baseRussianLessons.length >= 50) {
      return baseRussianLessons;
    }
    // If less than 50, add comprehensive expansion lessons
    return [...baseRussianLessons, ...ComprehensiveLessonExpansion.generateAdditionalRussianLessons()];
  }
  
  // Chinese → Amharic Lessons (60+ comprehensive lessons)
  static List<Lesson> getChineseLessons() {
    final baseChineseLessons = ChineseAmharicLessons.getAllLessons();
    if (baseChineseLessons.length >= 50) {
      return baseChineseLessons;
    }
    // If less than 50, add comprehensive expansion lessons
    return [...baseChineseLessons, ...ComprehensiveLessonExpansion.generateAdditionalChineseLessons()];
  }
  
  // Japanese → Amharic Lessons (60+ comprehensive lessons)
  static List<Lesson> getJapaneseLessons() {
    final baseJapaneseLessons = JapaneseAmharicLessons.getAllLessons();
    if (baseJapaneseLessons.length >= 50) {
      return baseJapaneseLessons;
    }
    // If less than 50, add comprehensive expansion lessons
    return [...baseJapaneseLessons, ...ComprehensiveLessonExpansion.generateAdditionalJapaneseLessons()];
  }
  
  // Hindi → Amharic Lessons (60+ comprehensive lessons)
  static List<Lesson> getHindiLessons() {
    final baseHindiLessons = HindiAmharicLessons.getAllLessons();
    if (baseHindiLessons.length >= 50) {
      return baseHindiLessons;
    }
    // If less than 50, add comprehensive expansion lessons
    return [...baseHindiLessons, ...ComprehensiveLessonExpansion.generateAdditionalHindiLessons()];
  }
  
}