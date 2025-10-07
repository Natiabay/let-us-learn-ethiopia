import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:tourist_assistive_app/features/chat/models/chat_message.dart';
import 'package:tourist_assistive_app/features/chat/models/ethiopia_knowledge.dart';
import 'package:tourist_assistive_app/core/config/development_config.dart';
import 'package:tourist_assistive_app/core/services/api_key_manager.dart';
import 'package:tourist_assistive_app/core/services/knowledge_expansion_service.dart';
import 'package:tourist_assistive_app/core/services/multi_ai_service.dart';
import 'package:tourist_assistive_app/core/data/massive_ethiopia_knowledge_base.dart';
import 'package:tourist_assistive_app/core/data/comprehensive_ethiopia_database.dart';
import 'package:flutter/foundation.dart';

final aiChatbotServiceProvider = Provider<AIChatbotService>((ref) {
  return AIChatbotService();
});

class AIChatbotService {
  final _uuid = const Uuid();
  final List<ChatMessage> _chatHistory = [];
  final ApiKeyManager _apiKeyManager = ApiKeyManager();

  // OpenAI API Configuration
  static const String _baseUrl = 'https://api.openai.com/v1';
  static const String _model = 'gpt-4-turbo-preview'; // Using the most advanced model
  
  final EthiopiaKnowledgeBase _knowledgeBase = EthiopiaKnowledgeBase();
  final ComprehensiveEthiopiaDatabase _comprehensiveDatabase = ComprehensiveEthiopiaDatabase();
  
  // System prompt for the AI to act as an Ethiopian guide
  static const String _systemPrompt = '''
You are "EthioBot", an intelligent and friendly AI assistant specifically designed to help tourists in Ethiopia. You are like a knowledgeable local guide who knows everything about Ethiopia - its culture, history, food, places, language, customs, and more.

Your personality:
- Warm, welcoming, and genuinely helpful
- Proud of Ethiopian culture and eager to share it
- Patient with tourists who are learning
- Knowledgeable about both traditional and modern Ethiopia
- Fluent in English and Amharic
- Always prioritize tourist safety and well-being

Your capabilities:
- Answer questions about Ethiopian culture, history, and traditions
- Provide travel recommendations and local insights
- Help with Amharic language learning and pronunciation
- Give practical advice about transportation, food, and accommodation
- Share interesting facts about Ethiopian landmarks and attractions
- Help with emergency situations and provide safety tips
- Suggest authentic local experiences and hidden gems
- Explain Ethiopian customs and etiquette
- Provide real-time information about events and festivals

Always respond in a conversational, friendly tone with proper markdown formatting. Use headers (# ## ###), bullet points (•), and bold text (**text**) to make responses clear and easy to read. If asked about something you're not sure about, admit it and offer to help find the information. Be culturally sensitive and respectful of Ethiopian traditions.

Remember: You're not just providing information - you're helping tourists feel welcome and connected to Ethiopia, making their journey memorable and safe.
''';

  Future<ChatMessage> sendMessage(String userMessage, {
    String? userLocation,
    String? userLanguage,
    bool isVoiceMessage = false,
  }) async {
    try {
      // Add user message to history
      final userMsg = ChatMessage(
        id: _uuid.v4(),
        text: userMessage,
        isUser: true,
        timestamp: DateTime.now(),
        isVoiceMessage: isVoiceMessage,
        location: userLocation,
        language: userLanguage,
      );
      _chatHistory.add(userMsg);

      // Initialize API key manager
      await _apiKeyManager.initialize();
      
      // Check if we have a valid OpenAI API key
      if (!_apiKeyManager.hasWorkingApiKey) {
        // Use comprehensive knowledge system with multiple AI services
        final comprehensiveResponse = await _getComprehensiveResponse(userMessage);
        
        final aiMessage = ChatMessage(
          id: _uuid.v4(),
          text: comprehensiveResponse,
          isUser: false,
          timestamp: DateTime.now(),
          isVoiceMessage: false,
          location: userLocation,
          language: userLanguage,
        );

        _chatHistory.add(aiMessage);
        return aiMessage;
      }

      // Prepare messages for API
      final messages = _prepareMessagesForAPI(userMessage, userLocation);

      // Call OpenAI API
      final response = await _callOpenAIAPI(messages);

      // Create AI response message
      final aiMessage = ChatMessage(
        id: _uuid.v4(),
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
        isVoiceMessage: false,
        location: userLocation,
        language: userLanguage,
      );

      _chatHistory.add(aiMessage);
      return aiMessage;

    } catch (e) {
      // Use comprehensive response system as fallback
      final fallbackResponse = await _getComprehensiveResponse(userMessage);

      final errorMessage = ChatMessage(
        id: _uuid.v4(),
        text: fallbackResponse,
        isUser: false,
        timestamp: DateTime.now(),
        isVoiceMessage: false,
        error: false, // Don't mark as error if we have a fallback response
      );
      _chatHistory.add(errorMessage);
      return errorMessage;
    }
  }

  List<Map<String, String>> _prepareMessagesForAPI(String userMessage, String? location) {
    final messages = <Map<String, String>>[
      {'role': 'system', 'content': _systemPrompt},
    ];

    // Add location context if available
    if (location != null) {
      messages.add({
        'role': 'system',
        'content': 'The user is currently in: $location. Provide location-specific advice and recommendations.',
      });
    }

    // Add recent chat history for context (last 10 messages)
    final recentHistory = _chatHistory.length > 10 
        ? _chatHistory.sublist(_chatHistory.length - 10)
        : _chatHistory;

    for (final msg in recentHistory) {
      messages.add({
        'role': msg.isUser ? 'user' : 'assistant',
        'content': msg.text,
      });
    }

    // Add current user message
    messages.add({
      'role': 'user',
      'content': userMessage,
    });

    return messages;
  }

  Future<String> _callOpenAIAPI(List<Map<String, String>> messages) async {
    // Get the best available API key
    final apiKey = _apiKeyManager.getBestAvailableKey();
    if (apiKey == null) {
      throw Exception('OpenAI API key not configured. Please set up your API key in the settings.');
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': _model,
        'messages': messages,
        'max_tokens': 1000,
        'temperature': 0.7,
        'top_p': 1,
        'frequency_penalty': 0,
        'presence_penalty': 0,
        'stream': false,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'] ?? 'I apologize, but I couldn\'t generate a response. Please try again.';
    } else {
      throw Exception('API Error: ${response.statusCode} - ${response.body}');
    }
  }

  // Get quick responses for common questions
  Future<List<QuickResponse>> getQuickResponses(String? location) async {
    final responses = <QuickResponse>[];

    // Location-specific quick responses
    if (location != null) {
      final locationResponses = _knowledgeBase.getLocationSpecificResponses(location);
      responses.addAll(locationResponses.map((lr) => QuickResponse(
        title: lr.category,
        subtitle: lr.response,
        response: lr.response,
        category: lr.category,
      )));
    }

    // General quick responses
    responses.addAll([
      QuickResponse(
        title: 'Best Local Food',
        subtitle: 'What should I try?',
        response: 'You must try injera with wat (stew), kitfo, and doro wat! I can recommend the best local restaurants.',
        category: 'food',
      ),
      QuickResponse(
        title: 'Amharic Phrases',
        subtitle: 'Teach me basic words',
        response: 'Of course! Let me teach you essential Amharic phrases like "Selam" (hello), "Ameseginalehu" (thank you), and more!',
        category: 'language',
      ),
      QuickResponse(
        title: 'Cultural Etiquette',
        subtitle: 'What should I know?',
        response: 'Ethiopian culture is rich and respectful. Let me share important customs and etiquette tips for your visit.',
        category: 'culture',
      ),
      QuickResponse(
        title: 'Transportation',
        subtitle: 'How do I get around?',
        response: 'I can help you with buses, taxis, ride-sharing, and walking routes. What\'s your destination?',
        category: 'transport',
      ),
      QuickResponse(
        title: 'Emergency Help',
        subtitle: 'I need assistance',
        response: 'I\'m here to help! For emergencies, call 911. I can also guide you to hospitals, police stations, or embassies.',
        category: 'emergency',
      ),
      QuickResponse(
        title: 'Hidden Gems',
        subtitle: 'Show me local secrets',
        response: 'I know the best local spots that tourists often miss! Let me share some authentic Ethiopian experiences.',
        category: 'attractions',
      ),
    ]);

    return responses;
  }

  // Get contextual suggestions based on time, location, and user behavior
  List<ContextualSuggestion> getContextualSuggestions({
    String? location,
    DateTime? time,
    List<String>? userInterests,
  }) {
    final suggestions = <ContextualSuggestion>[];

    // Time-based suggestions
    if (time != null) {
      final hour = time.hour;
      if (hour >= 6 && hour < 10) {
        suggestions.add(ContextualSuggestion(
          title: 'Good Morning!',
          subtitle: 'Start your day with traditional Ethiopian coffee',
          action: 'Tell me about coffee ceremonies',
          icon: '☕',
        ));
      } else if (hour >= 12 && hour < 14) {
        suggestions.add(ContextualSuggestion(
          title: 'Lunch Time!',
          subtitle: 'Try authentic Ethiopian cuisine',
          action: 'Recommend local restaurants',
          icon: '🍽️',
        ));
      } else if (hour >= 18 && hour < 22) {
        suggestions.add(ContextualSuggestion(
          title: 'Evening Plans?',
          subtitle: 'Discover Ethiopian nightlife and culture',
          action: 'Show me evening activities',
          icon: '🌙',
        ));
      }
    }

    // Location-based suggestions
    if (location != null) {
      final locationSuggestions = _knowledgeBase.getLocationSuggestions(location);
      suggestions.addAll(locationSuggestions.map((ls) => ContextualSuggestion(
        title: ls.title,
        subtitle: ls.subtitle,
        action: ls.action,
        icon: ls.icon,
      )));
    }

    // Interest-based suggestions
    if (userInterests != null && userInterests.isNotEmpty) {
      for (final interest in userInterests) {
        final interestSuggestions = _knowledgeBase.getInterestBasedSuggestions(interest);
        suggestions.addAll(interestSuggestions.map((interestSuggestion) => ContextualSuggestion(
          title: interestSuggestion.title,
          subtitle: interestSuggestion.subtitle,
          action: interestSuggestion.action,
          icon: interestSuggestion.icon,
        )));
      }
    }

    return suggestions;
  }

  // Voice message processing
  Future<ChatMessage> processVoiceMessage(String audioText, {
    String? userLocation,
    String? userLanguage,
  }) async {
    return await sendMessage(
      audioText,
      userLocation: userLocation,
      userLanguage: userLanguage,
      isVoiceMessage: true,
    );
  }

  // Get chat history
  List<ChatMessage> getChatHistory() {
    return List.from(_chatHistory);
  }

  // Clear chat history
  void clearChatHistory() {
    _chatHistory.clear();
  }

  // Get conversation summary
  String getConversationSummary() {
    if (_chatHistory.isEmpty) return 'No conversation yet.';
    
    final userMessages = _chatHistory.where((msg) => msg.isUser).length;
    final aiMessages = _chatHistory.where((msg) => !msg.isUser).length;
    
    return 'You\'ve had $userMessages questions and I\'ve provided $aiMessages helpful responses about Ethiopia!';
  }

  // Check if API key is configured
  bool get isApiKeyConfigured => _apiKeyManager.hasWorkingApiKey;

  /// Get comprehensive response using multiple AI services and knowledge bases
  Future<String> _getComprehensiveResponse(String userMessage) async {
    try {
      // Try comprehensive database first
      final comprehensiveResponse = ComprehensiveEthiopiaDatabase.getInformation(userMessage);
      if (comprehensiveResponse.isNotEmpty && comprehensiveResponse.toString().length > 100) {
        return _formatComprehensiveResponse(comprehensiveResponse, userMessage);
      }
      
      // Try multiple AI services
      final multiAIResponse = await MultiAIService.getIntelligentResponse(userMessage);
      if (multiAIResponse.isNotEmpty && multiAIResponse.length > 100) {
        return multiAIResponse;
      }
      
      // Try knowledge expansion service
      final knowledgeResponse = await KnowledgeExpansionService.getComprehensiveResponse(userMessage);
      if (knowledgeResponse.isNotEmpty && knowledgeResponse.length > 100) {
        return knowledgeResponse;
      }
      
      // Try massive knowledge base
      final massiveKnowledgeResponse = MassiveEthiopiaKnowledgeBase.getKnowledge(userMessage);
      if (massiveKnowledgeResponse.isNotEmpty && massiveKnowledgeResponse.length > 100) {
        return massiveKnowledgeResponse;
      }
      
      // Fallback to development config
      return DevelopmentConfig.getMockResponse(userMessage);
      
    } catch (e) {
      debugPrint('Comprehensive response error: $e');
      return DevelopmentConfig.getMockResponse(userMessage);
    }
  }

  /// Format comprehensive database response into ChatGPT-like format
  String _formatComprehensiveResponse(Map<String, dynamic> data, String query) {
    final buffer = StringBuffer();
    
    // Add header with emoji
    buffer.writeln('# 🇪🇹 **Ethiopia Travel Guide**');
    buffer.writeln();
    
    // Add description if available
    if (data.containsKey('description')) {
      buffer.writeln('## 📍 **Overview**');
      buffer.writeln(data['description']);
      buffer.writeln();
    }
    
    // Add key information sections
    if (data.containsKey('population')) {
      buffer.writeln('## 👥 **Population**');
      buffer.writeln(data['population']);
      buffer.writeln();
    }
    
    if (data.containsKey('elevation')) {
      buffer.writeln('## 🏔️ **Elevation**');
      buffer.writeln(data['elevation']);
      buffer.writeln();
    }
    
    if (data.containsKey('climate')) {
      buffer.writeln('## 🌤️ **Climate**');
      buffer.writeln(data['climate']);
      buffer.writeln();
    }
    
    if (data.containsKey('bestTimeToVisit')) {
      buffer.writeln('## 📅 **Best Time to Visit**');
      buffer.writeln(data['bestTimeToVisit']);
      buffer.writeln();
    }
    
    // Add attractions
    if (data.containsKey('majorAttractions')) {
      buffer.writeln('## 🏛️ **Major Attractions**');
      final attractions = data['majorAttractions'] as List<dynamic>;
      for (final attraction in attractions) {
        buffer.writeln('• **$attraction**');
      }
      buffer.writeln();
    }
    
    // Add restaurants
    if (data.containsKey('restaurants')) {
      buffer.writeln('## 🍽️ **Recommended Restaurants**');
      final restaurants = data['restaurants'] as List<dynamic>;
      for (final restaurant in restaurants) {
        buffer.writeln('• **$restaurant**');
      }
      buffer.writeln();
    }
    
    // Add hotels
    if (data.containsKey('hotels')) {
      buffer.writeln('## 🏨 **Accommodation Options**');
      final hotels = data['hotels'] as List<dynamic>;
      for (final hotel in hotels) {
        buffer.writeln('• **$hotel**');
      }
      buffer.writeln();
    }
    
    // Add activities
    if (data.containsKey('activities')) {
      buffer.writeln('## 🎯 **Activities**');
      final activities = data['activities'] as List<dynamic>;
      for (final activity in activities) {
        buffer.writeln('• **$activity**');
      }
      buffer.writeln();
    }
    
    // Add wildlife for national parks
    if (data.containsKey('wildlife')) {
      buffer.writeln('## 🦁 **Wildlife**');
      final wildlife = data['wildlife'] as List<dynamic>;
      for (final animal in wildlife) {
        buffer.writeln('• **$animal**');
      }
      buffer.writeln();
    }
    
    // Add ingredients for food
    if (data.containsKey('ingredients')) {
      buffer.writeln('## 🥘 **Ingredients**');
      final ingredients = data['ingredients'] as List<dynamic>;
      for (final ingredient in ingredients) {
        buffer.writeln('• **$ingredient**');
      }
      buffer.writeln();
    }
    
    // Add cultural significance
    if (data.containsKey('culturalSignificance')) {
      buffer.writeln('## 🎭 **Cultural Significance**');
      buffer.writeln(data['culturalSignificance']);
      buffer.writeln();
    }
    
    // Add tips
    if (data.containsKey('tips')) {
      buffer.writeln('## 💡 **Travel Tips**');
      buffer.writeln(data['tips']);
      buffer.writeln();
    }
    
    // Add footer
    buffer.writeln('---');
    buffer.writeln('*Need more specific information? Ask me about transportation, safety, language, or any other aspect of your Ethiopian journey!*');
    
    return buffer.toString();
  }

  // Get available features
  List<String> getAvailableFeatures() {
    return [
      'Real-time AI conversations',
      'Voice message support',
      'Location-aware responses',
      'Cultural insights',
      'Language learning help',
      'Travel recommendations',
      'Emergency assistance',
      'Local event information',
      'Food and restaurant suggestions',
      'Transportation guidance',
    ];
  }
}

class QuickResponse {
  final String title;
  final String subtitle;
  final String response;
  final String category;

  QuickResponse({
    required this.title,
    required this.subtitle,
    required this.response,
    required this.category,
  });
}

class ContextualSuggestion {
  final String title;
  final String subtitle;
  final String action;
  final String icon;

  ContextualSuggestion({
    required this.title,
    required this.subtitle,
    required this.action,
    required this.icon,
  });
}
