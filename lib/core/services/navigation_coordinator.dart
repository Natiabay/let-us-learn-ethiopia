import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

/// Navigation coordinator service to manage app navigation flow
/// and coordinate between different features for better user experience
class NavigationCoordinator {
  static final NavigationCoordinator _instance = NavigationCoordinator._internal();
  factory NavigationCoordinator() => _instance;
  NavigationCoordinator._internal();

  // Navigation state management
  int _currentBottomNavIndex = 0;
  String? _lastVisitedLocation;
  Map<String, dynamic> _userContext = {};

  // Getters
  int get currentBottomNavIndex => _currentBottomNavIndex;
  String? get lastVisitedLocation => _lastVisitedLocation;
  Map<String, dynamic> get userContext => _userContext;

  /// Navigate to a specific bottom navigation tab
  void navigateToTab(BuildContext context, int index) {
    _currentBottomNavIndex = index;
    // Navigate using GoRouter
    if (context.mounted) {
      switch (index) {
        case 0:
          context.go('/home');
          break;
        case 1:
          context.go('/language');
          break;
        case 2:
          context.go('/locations');
          break;
        case 3:
          context.go('/chatbot');
          break;
        case 4:
          context.go('/profile');
          break;
      }
    }
  }

  /// Navigate to a specific location with context
  void navigateToLocation(BuildContext context, String locationId, {
    Map<String, dynamic>? userContext,
  }) {
    _lastVisitedLocation = locationId;
    if (userContext != null) {
      _userContext.addAll(userContext);
    }
    
    if (context.mounted) {
      context.go('/locations/detail/$locationId');
    }
  }

  /// Navigate to language learning with specific lesson
  void navigateToLanguageLesson(BuildContext context, String lessonId, {
    Map<String, dynamic>? userContext,
  }) {
    if (userContext != null) {
      _userContext.addAll(userContext);
    }
    
    if (context.mounted) {
      context.go('/language/amharic/lesson/$lessonId');
    }
  }

  /// Navigate to chatbot with pre-filled context
  void navigateToChatbot(BuildContext context, {
    String? initialMessage,
    Map<String, dynamic>? userContext,
  }) {
    if (userContext != null) {
      _userContext.addAll(userContext);
    }
    
    if (context.mounted) {
      context.go('/chatbot');
      // TODO: Pass initial message to chatbot
    }
  }

  /// Navigate to emergency contacts
  void navigateToEmergency(BuildContext context) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => _EmergencyContactsDialog(),
      );
    }
  }

  /// Navigate to translation feature
  void navigateToTranslation(BuildContext context, {
    String? initialText,
    String? fromLanguage,
    String? toLanguage,
  }) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => _TranslationDialog(
          initialText: initialText,
          fromLanguage: fromLanguage,
          toLanguage: toLanguage,
        ),
      );
    }
  }

  /// Get contextual navigation suggestions based on user location and interests
  List<NavigationSuggestion> getContextualSuggestions({
    String? userLocation,
    List<String>? interests,
    String? currentFeature,
  }) {
    final suggestions = <NavigationSuggestion>[];

    // Location-based suggestions
    if (userLocation != null) {
      if (userLocation.toLowerCase().contains('addis')) {
        suggestions.add(NavigationSuggestion(
          title: 'Explore Addis Ababa',
          description: 'Discover the capital city',
          icon: Icons.location_city,
          action: () {}, // Will be handled by the calling widget
          priority: 1,
        ));
      }
    }

    // Interest-based suggestions
    if (interests != null) {
      if (interests.contains('history')) {
        suggestions.add(NavigationSuggestion(
          title: 'Historical Sites',
          description: 'Visit Lalibela, Gondar, and Axum',
          icon: Icons.history_edu,
          action: () {}, // Will be handled by the calling widget
          priority: 2,
        ));
      }

      if (interests.contains('nature')) {
        suggestions.add(NavigationSuggestion(
          title: 'Natural Wonders',
          description: 'Explore Simien Mountains and Danakil',
          icon: Icons.landscape,
          action: () {}, // Will be handled by the calling widget
          priority: 2,
        ));
      }
    }

    // Feature-based suggestions
    if (currentFeature != 'language') {
      suggestions.add(NavigationSuggestion(
        title: 'Learn Amharic',
        description: 'Practice essential phrases',
        icon: Icons.school,
        action: () {}, // Will be handled by the calling widget
        priority: 3,
      ));
    }

    if (currentFeature != 'chatbot') {
      suggestions.add(NavigationSuggestion(
        title: 'Ask AI Assistant',
        description: 'Get instant help and recommendations',
        icon: Icons.assistant,
        action: () {}, // Will be handled by the calling widget
        priority: 3,
      ));
    }

    // Sort by priority
    suggestions.sort((a, b) => a.priority.compareTo(b.priority));
    return suggestions;
  }

  /// Update user context for better personalization
  void updateUserContext(Map<String, dynamic> context) {
    _userContext.addAll(context);
  }

  /// Clear navigation history
  void clearHistory() {
    _lastVisitedLocation = null;
    _userContext.clear();
  }

  /// Make a phone call
  static Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Cannot make phone call to $phoneNumber'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error making phone call: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

/// Navigation suggestion model
class NavigationSuggestion {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback action;
  final int priority;

  NavigationSuggestion({
    required this.title,
    required this.description,
    required this.icon,
    required this.action,
    required this.priority,
  });
}

/// Emergency contacts dialog
class _EmergencyContactsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emergencyContacts = [
      {'name': 'Police', 'number': '991', 'icon': Icons.local_police},
      {'name': 'Medical Emergency', 'number': '907', 'icon': Icons.medical_services},
      {'name': 'Fire Department', 'number': '939', 'icon': Icons.local_fire_department},
      {'name': 'Tourist Police', 'number': 'Contact hotel', 'icon': Icons.support_agent},
    ];

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.emergency, color: Colors.red, size: 32),
                const SizedBox(width: 12),
                Text(
                  'Emergency Contacts',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...emergencyContacts.map((contact) => 
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(contact['icon'] as IconData, color: Colors.red, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contact['name'] as String,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            contact['number'] as String,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.phone),
                      onPressed: () {
                        NavigationCoordinator._makePhoneCall(context, contact['number'] as String);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Translation dialog for quick translations
class _TranslationDialog extends StatefulWidget {
  final String? initialText;
  final String? fromLanguage;
  final String? toLanguage;

  const _TranslationDialog({
    this.initialText,
    this.fromLanguage,
    this.toLanguage,
  });

  @override
  _TranslationDialogState createState() => _TranslationDialogState();
}

class _TranslationDialogState extends State<_TranslationDialog> {
  final TextEditingController _textController = TextEditingController();
  String _translatedText = '';
  bool _isTranslating = false;
  String _fromLanguage = 'en';
  String _toLanguage = 'am';

  @override
  void initState() {
    super.initState();
    _textController.text = widget.initialText ?? '';
    _fromLanguage = widget.fromLanguage ?? 'en';
    _toLanguage = widget.toLanguage ?? 'am';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.translate, color: Colors.blue, size: 32),
                const SizedBox(width: 12),
                Text(
                  'Quick Translation',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Language selection
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromLanguage,
                    decoration: const InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'en', child: Text('English')),
                      DropdownMenuItem(value: 'am', child: Text('Amharic')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _fromLanguage = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.swap_horiz),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _toLanguage,
                    decoration: const InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'en', child: Text('English')),
                      DropdownMenuItem(value: 'am', child: Text('Amharic')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _toLanguage = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Input text
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Enter text to translate',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            
            // Translate button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isTranslating ? null : _translateText,
                icon: _isTranslating 
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.translate),
                label: Text(_isTranslating ? 'Translating...' : 'Translate'),
              ),
            ),
            
            if (_translatedText.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Translation:',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _translatedText,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
                if (_translatedText.isNotEmpty)
                  ElevatedButton.icon(
                    onPressed: () {
                      _copyToClipboard(context, _translatedText);
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _translateText() async {
    if (_textController.text.isEmpty) return;

    setState(() {
      _isTranslating = true;
    });

    try {
      // Use Google Translate API for actual translation
      final translatedText = await _performTranslation(
        _textController.text,
        _fromLanguage,
        _toLanguage,
      );
      
      setState(() {
        _translatedText = translatedText;
        _isTranslating = false;
      });
    } catch (e) {
      setState(() {
        _translatedText = 'Translation failed: $e';
        _isTranslating = false;
      });
    }
  }

  Future<String> _performTranslation(String text, String fromLang, String toLang) async {
    // For now, return a placeholder translation
    // In a real implementation, you would call Google Translate API here
    await Future.delayed(const Duration(seconds: 1));
    
    if (fromLang == 'en' && toLang == 'am') {
      // Simple English to Amharic mapping for demo
      final translations = {
        'hello': 'ሰላም',
        'thank you': 'አመሰግናለሁ',
        'goodbye': 'ቻይ',
        'yes': 'አዎ',
        'no': 'አይ',
        'water': 'ውሃ',
        'food': 'ምግብ',
        'help': 'እርዳታ',
        'emergency': 'አደጋ',
        'hospital': 'ሆስፒታል',
        'police': 'ፖሊስ',
      };
      
      final lowerText = text.toLowerCase();
      for (final entry in translations.entries) {
        if (lowerText.contains(entry.key)) {
          return text.replaceAll(entry.key, entry.value);
        }
      }
    }
    
    return 'Translation: $text'; // Fallback
  }

  void _copyToClipboard(BuildContext context, String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Copied to clipboard!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to copy: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

/// Provider for navigation coordinator
final navigationCoordinatorProvider = Provider<NavigationCoordinator>((ref) {
  return NavigationCoordinator();
});
