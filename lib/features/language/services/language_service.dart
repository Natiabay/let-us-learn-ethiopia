import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_assistive_app/features/language/models/lesson.dart';
import 'package:tourist_assistive_app/features/language/models/language_progress.dart';
import 'package:tourist_assistive_app/features/language/data/ethiopian_lessons.dart';

class LanguageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Lesson>> getLessons() async {
    try {
      final snapshot = await _firestore
          .collection('lessons')
          .orderBy('difficulty')
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((doc) => Lesson.fromMap({'id': doc.id, ...doc.data()}))
            .toList();
      }

      // Return Ethiopian lessons if none exist in Firestore
      return EthiopianLessons.all;
    } catch (e) {
      // Return Ethiopian lessons on error
      return EthiopianLessons.all;
    }
  }

  Future<LanguageProgress> getUserProgress() async {
    final user = _auth.currentUser;
    if (user == null) {
      return const LanguageProgress(
        currentLevel: 1,
        totalXP: 0,
        currentXP: 0,
        targetXP: 100,
        streakDays: 0,
        completedLessons: [],
      );
    }

    try {
      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        final progressData = data['languageProgress'] as Map<String, dynamic>?;
        
        if (progressData != null) {
          return LanguageProgress.fromMap(progressData);
        }
      }

      // Return default progress
      return const LanguageProgress(
        currentLevel: 1,
        totalXP: 0,
        currentXP: 0,
        targetXP: 100,
        streakDays: 0,
        completedLessons: [],
      );
    } catch (e) {
      return const LanguageProgress(
        currentLevel: 1,
        totalXP: 0,
        currentXP: 0,
        targetXP: 100,
        streakDays: 0,
        completedLessons: [],
      );
    }
  }

  Future<void> updateUserProgress(LanguageProgress progress) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      await _firestore.collection('users').doc(user.uid).update({
        'languageProgress': progress.toMap(),
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Handle error silently for now
    }
  }

  Future<Lesson?> getLesson(String lessonId) async {
    try {
      final doc = await _firestore
          .collection('lessons')
          .doc(lessonId)
          .get();

      if (doc.exists) {
        return Lesson.fromMap({'id': doc.id, ...doc.data()!});
      }

      // Return Ethiopian lesson if not found
      return EthiopianLessons.all.firstWhere(
        (lesson) => lesson.id == lessonId,
        orElse: () => EthiopianLessons.all.first,
      );
    } catch (e) {
      return null;
    }
  }

}
