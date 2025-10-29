import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

/// Language Selection Screen for Language Learning Setup
/// Allows users to select their target language
class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLanguage;

  final List<Map<String, dynamic>> _languages = [
    {
      'code': 'am',
      'name': 'Amharic',
      'nativeName': 'አማርኛ',
      'flag': '🇪🇹',
      'description': 'Official language of Ethiopia',
    },
    {
      'code': 'en',
      'name': 'English',
      'nativeName': 'English',
      'flag': '🇺🇸',
      'description': 'International language',
    },
    {
      'code': 'ar',
      'name': 'Arabic',
      'nativeName': 'العربية',
      'flag': '🇸🇦',
      'description': 'Widely spoken in the region',
    },
    {
      'code': 'fr',
      'name': 'French',
      'nativeName': 'Français',
      'flag': '🇫🇷',
      'description': 'International language',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Choose Language',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'What language would you like to learn?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ).animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .slideX(begin: -0.3, end: 0, delay: 200.ms),

              const SizedBox(height: 8),

              Text(
                'Select your target language to get started',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 16,
                ),
              ).animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideX(begin: -0.3, end: 0, delay: 400.ms),

              const SizedBox(height: 32),

              // Language Options
              Expanded(
                child: ListView.builder(
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final language = _languages[index];
                    final isSelected = _selectedLanguage == language['code'];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildLanguageCard(
                        language: language,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            _selectedLanguage = language['code'];
                          });
                        },
                        delay: (index + 1) * 100,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedLanguage != null
                      ? () {
                          // Navigate to proficiency screen
                          context.push('/language/setup/proficiency');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedLanguage != null
                        ? const Color(0xFF58CC02)
                        : Colors.grey.withValues(alpha: 0.3),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ).animate()
                .fadeIn(delay: 1000.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, delay: 1000.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard({
    required Map<String, dynamic> language,
    required bool isSelected,
    required VoidCallback onTap,
    required int delay,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF58CC02).withValues(alpha: 0.1)
              : const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF58CC02)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            // Flag
            Text(
              language['flag'],
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(width: 16),

            // Language Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language['name'],
                    style: TextStyle(
                      color: isSelected ? const Color(0xFF58CC02) : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    language['nativeName'],
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF58CC02).withValues(alpha: 0.8)
                          : Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    language['description'],
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF58CC02).withValues(alpha: 0.6)
                          : Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Selection Indicator
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF58CC02),
                size: 24,
              ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(delay: delay.ms, duration: 600.ms)
      .slideX(begin: -0.3, end: 0, delay: delay.ms);
  }
}
