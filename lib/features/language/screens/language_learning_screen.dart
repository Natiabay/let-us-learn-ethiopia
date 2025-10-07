import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/features/language/screens/multilingual_learning_dashboard.dart';

class LanguageLearningScreen extends ConsumerWidget {
  const LanguageLearningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MultilingualLearningDashboard();
  }
}