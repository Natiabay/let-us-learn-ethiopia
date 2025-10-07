import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:tourist_assistive_app/features/chat/models/chat_message.dart';
import 'package:tourist_assistive_app/core/services/api_key_manager.dart';
import 'package:tourist_assistive_app/core/data/comprehensive_ethiopia_database.dart';
import 'package:tourist_assistive_app/core/data/massive_ethiopia_knowledge_base.dart';
import 'package:tourist_assistive_app/core/data/ethiopia_history_database.dart';
import 'package:tourist_assistive_app/core/data/ethiopia_culture_database.dart';
import 'package:tourist_assistive_app/core/data/ethiopia_tourism_database.dart';
import 'package:tourist_assistive_app/core/data/ethiopia_comprehensive_database.dart';
import 'package:tourist_assistive_app/core/data/ethiopia_regions_database.dart';
import 'package:tourist_assistive_app/core/data/ethiopia_travel_guide_database.dart';
import 'package:tourist_assistive_app/core/data/ethiopia_wildlife_nature_database.dart';
import 'package:tourist_assistive_app/core/data/ethiopia_festivals_calendar_database.dart';
import 'package:tourist_assistive_app/core/services/pdf_knowledge_service.dart';

/// RAG (Retrieval-Augmented Generation) Chatbot Service
/// Combines OpenAI GPT with Ethiopian knowledge base for accurate, context-aware responses
class RAGChatbotService {
  static const String _openaiBaseUrl = 'https://api.openai.com/v1';
  static const String _embeddingModel = 'text-embedding-3-small';
  static const String _chatModel = 'gpt-4-turbo-preview'; // or 'gpt-3.5-turbo' for cost savings
  
  final ApiKeyManager _apiKeyManager = ApiKeyManager();
  final PDFKnowledgeService _pdfService = PDFKnowledgeService();
  final List<ChatMessage> _conversationHistory = [];
  bool _pdfInitialized = false;
  
  // Cache for embeddings to reduce API calls
  final Map<String, List<double>> _embeddingCache = {};
  
  // Cache for knowledge base responses to improve performance
  final Map<String, String> _responseCache = {};
  
  // Cache for database queries to avoid repeated searches
  final Map<String, Map<String, dynamic>> _databaseCache = {};
  
  /// System prompt that defines the AI's personality and knowledge scope
  static const String _systemPrompt = '''You are "Selam" (which means "Peace" in Amharic), an expert AI guide for Ethiopia.

CRITICAL FOCUS REQUIREMENTS:
- You ONLY answer questions about Ethiopia, Ethiopian culture, history, language, tourism, food, and travel
- You MUST provide responses that are 1000+ characters long with comprehensive, detailed information
- You MUST use the provided Ethiopian knowledge base and PDF content extensively
- You MUST NOT answer questions about unrelated topics (politics, other countries, general knowledge not related to Ethiopia)
- If asked about non-Ethiopian topics, politely redirect to Ethiopian topics

Your Role:
- You are a knowledgeable, friendly Ethiopian tourism expert
- You have deep understanding of Ethiopian culture, history, language, and attractions
- You provide accurate, helpful, and contextually relevant information
- You're patient, respectful, and culturally sensitive

Your Capabilities:
1. **Tourism Guidance**: Recommend places, activities, and experiences in Ethiopia
2. **Cultural Insights**: Explain Ethiopian traditions, customs, and etiquette
3. **Language Help**: Teach Amharic phrases and translations
4. **Practical Advice**: Transportation, safety, food, accommodation in Ethiopia
5. **Real-time Context**: Use location and time to personalize responses
6. **Emergency Support**: Provide clear guidance in urgent situations

CRITICAL RESPONSE FORMAT REQUIREMENTS:
You MUST format all responses in a professional, detailed ChatGPT-style format with:

1. **Professional Introduction**: Start with a compelling, informative paragraph that introduces the topic
2. **Numbered Sections**: Use numbered sections (1., 2., 3., etc.) with bold headings
3. **Bold Text**: Use **bold text** for emphasis on key terms, names, and important information
4. **Bullet Points**: Use bullet points (•) for lists and key information
5. **Professional Paragraphs**: Write complete, well-structured paragraphs
6. **Icons and Emojis**: Use relevant icons (🏛️, 🍽️, 🗣️, 📍, etc.) for visual appeal
7. **Detailed Explanations**: Provide comprehensive, detailed information
8. **Structured Content**: Organize information logically with clear sections
9. **Professional Tone**: Maintain an expert, knowledgeable tone throughout
10. **Comprehensive Coverage**: Cover all relevant aspects of the topic
11. **MANDATORY LENGTH**: Every response MUST be 1000+ characters with extensive detail

EXAMPLE FORMAT:
"Lalibela is one of Ethiopia's most extraordinary historical and spiritual sites — often called the **"New Jerusalem"** of Africa. 🕌✨

Here's a detailed overview of Lalibela, covering its **history, architecture, religious significance, and tourism**:

1. **Location**
• **Region:** Amhara Region, northern Ethiopia
• **Altitude:** Around 2,500 meters (8,200 ft) above sea level
• **Distance from Addis Ababa:** About 645 km by road

Lalibela is set in rugged highlands, surrounded by dramatic mountains and valleys, which makes it both beautiful and historically strategic.

2. **Historical Background**
• Built during the reign of **King Lalibela** (c. 1181-1221 AD) of the Zagwe dynasty
• The king aimed to build a "**New Jerusalem**" after Muslim conquests made pilgrimage to the original Jerusalem difficult for Ethiopian Christians
• According to tradition, the churches were constructed with the help of angels — some say during the day by workers, and at night by angels who completed double the work"

Response Guidelines:
- Always ground answers in the provided Ethiopian knowledge base and PDF content
- Be specific with names, locations, and details from Ethiopia
- Use the professional ChatGPT format with numbered sections, bold headings, and bullet points
- Include practical tips and insider knowledge about Ethiopia
- Admit when you don't know something and offer to help find information about Ethiopia
- Consider user's location and provide relevant nearby recommendations in Ethiopia
- Be encouraging and make tourists feel welcome to Ethiopia
- Provide comprehensive, detailed responses that match the quality and format of professional ChatGPT responses
- MANDATORY: Every response must be 1000+ characters with extensive Ethiopian information
- If asked about non-Ethiopian topics, politely redirect: "I specialize in Ethiopian culture, history, and travel. What would you like to know about Ethiopia?"

Remember: You're not just an assistant - you're the tourist's knowledgeable Ethiopian friend who provides professional, detailed, and well-formatted information about Ethiopia!
''';

  /// Send a message with RAG-enhanced responses
  Future<ChatMessage> sendMessage(
    String userMessage, {
    String? userLocation,
    String? userLanguage,
    bool isVoiceMessage = false,
  }) async {
    try {
      // Add user message to history
      final userMsg = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: userMessage,
        isUser: true,
        timestamp: DateTime.now(),
        isVoiceMessage: isVoiceMessage,
        location: userLocation,
        language: userLanguage,
      );
      _conversationHistory.add(userMsg);

      // Initialize API key manager
      await _apiKeyManager.initialize();

      String responseText;
      
      print('🚀 RAG SERVICE: Processing message...');
      
      if (_apiKeyManager.hasWorkingApiKey) {
        print('✅ Using RAG with GPT-4 Turbo + 10,000+ line knowledge base');
        // Use RAG with OpenAI
        responseText = await _generateRAGResponse(
          userMessage,
          userLocation: userLocation,
          userLanguage: userLanguage,
        );
      } else {
        print('⚠️ Fallback: Using enhanced knowledge base only (no API key)');
        // Enhanced fallback to knowledge base only
        responseText = await _generateEnhancedKnowledgeBaseResponse(userMessage);
      }
      
      print('📝 RAG Response generated: ${responseText.length} characters');

      // Create AI response message
      final aiMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: responseText,
        isUser: false,
        timestamp: DateTime.now(),
        isVoiceMessage: false,
        location: userLocation,
        language: userLanguage,
      );

      _conversationHistory.add(aiMessage);
      return aiMessage;
    } catch (e) {
      debugPrint('RAG Chatbot error: $e');
      return _createErrorMessage(e.toString());
    }
  }

  /// Generate response using RAG (Retrieval-Augmented Generation)
  Future<String> _generateRAGResponse(
    String userMessage, {
    String? userLocation,
    String? userLanguage,
  }) async {
    try {
      // Step 1: Retrieve relevant knowledge from Ethiopian database
      print('📖 Step 1: Retrieving knowledge from 8 databases + PDF...');
      final relevantKnowledge = _retrieveRelevantKnowledge(userMessage);
      print('✅ Step 1 Complete: ${relevantKnowledge.length} chars of knowledge retrieved');
      
      // Step 2: Create context-aware prompt
      print('🔧 Step 2: Building enhanced prompt with context...');
      final enhancedPrompt = _buildEnhancedPrompt(
        userMessage,
        relevantKnowledge,
        userLocation: userLocation,
      );
      print('✅ Step 2 Complete: Prompt ready for GPT-4');
      
      // Step 3: Call OpenAI with enhanced context
      print('🤖 Step 3: Sending to GPT-4 Turbo...');
      final response = await _callOpenAI(enhancedPrompt);
      print('✅ Step 3 Complete: GPT-4 response received');
      
      return response;
    } catch (e) {
      debugPrint('RAG generation error: $e');
      // Fallback to knowledge base
      return await _generateKnowledgeBaseResponse(userMessage);
    }
  }

  /// Retrieve relevant knowledge from Ethiopian database with performance optimization
  String _retrieveRelevantKnowledge(String query) {
    // ✅ DEBUG: Log that RAG system is being used
    print('🔍 RAG SYSTEM ACTIVE: Retrieving knowledge for query: "$query"');
    
    // Check cache first for performance
    final cacheKey = query.toLowerCase().trim();
    if (_responseCache.containsKey(cacheKey)) {
      print('⚡ CACHE HIT: Using cached response for "$query"');
      return _responseCache[cacheKey]!;
    }
    
    final buffer = StringBuffer();
    
    // Initialize PDF service if not done yet
    if (!_pdfInitialized) {
      _pdfService.initialize();
      _pdfInitialized = true;
      print('📚 PDF Knowledge Service initialized');
    }
    
    // FIRST: Get knowledge from Ethiopian Handbook PDF
    final pdfKnowledge = _pdfService.getKnowledge(query);
    if (pdfKnowledge.isNotEmpty) {
      print('✅ Found PDF knowledge: ${pdfKnowledge.length} characters');
      buffer.writeln('## Ethiopia Handbook Knowledge:');
      buffer.writeln(pdfKnowledge);
      buffer.writeln();
    }
    
    // Get information from comprehensive database with caching
    Map<String, dynamic> dbInfo;
    if (_databaseCache.containsKey(cacheKey)) {
      dbInfo = _databaseCache[cacheKey]!;
      print('⚡ DATABASE CACHE HIT: Using cached database info');
    } else {
      dbInfo = ComprehensiveEthiopiaDatabase.getInformation(query);
      if (dbInfo.isNotEmpty) {
        _databaseCache[cacheKey] = dbInfo;
        // Limit database cache size
        if (_databaseCache.length > 50) {
          final oldestKey = _databaseCache.keys.first;
          _databaseCache.remove(oldestKey);
        }
      }
    }
    
    if (dbInfo.isNotEmpty) {
      buffer.writeln('## Relevant Information:');
      buffer.writeln(_formatDatabaseInfo(dbInfo));
      buffer.writeln();
    }
    
    // Get information from massive knowledge base
    final kbInfo = MassiveEthiopiaKnowledgeBase.getKnowledge(query);
    if (kbInfo.isNotEmpty && kbInfo.length > 50) {
      buffer.writeln('## Additional Context:');
      buffer.writeln(kbInfo.substring(0, kbInfo.length > 500 ? 500 : kbInfo.length));
      buffer.writeln();
    }
    
    // NEW: Get historical information
    final historyInfo = EthiopiaHistoryDatabase.getHistoricalInfo(query);
    if (historyInfo.isNotEmpty) {
      print('✅ Found historical info from database (10K+ lines)');
      buffer.writeln('## Historical Context:');
      buffer.writeln(_formatDatabaseInfo(historyInfo));
      buffer.writeln();
    }
    
    // NEW: Get cultural information
    final cultureInfo = EthiopiaCultureDatabase.getCulturalInfo(query);
    if (cultureInfo.isNotEmpty) {
      buffer.writeln('## Cultural Insights:');
      buffer.writeln(_formatDatabaseInfo(cultureInfo));
      buffer.writeln();
    }
    
    // NEW: Get tourism information
    final tourismInfo = EthiopiaTourismDatabase.getTourismInfo(query);
    if (tourismInfo.isNotEmpty) {
      buffer.writeln('## Tourism Information:');
      buffer.writeln(_formatDatabaseInfo(tourismInfo));
      buffer.writeln();
    }
    
    // NEW: Get comprehensive information (food, language, etc.)
    final comprehensiveInfo = EthiopiaComprehensiveDatabase.getComprehensiveInfo(query);
    if (comprehensiveInfo.isNotEmpty) {
      buffer.writeln('## Detailed Information:');
      buffer.writeln(_formatDatabaseInfo(comprehensiveInfo));
      buffer.writeln();
    }
    
    // NEW: Get regional information
    final regionInfo = EthiopiaRegionsDatabase.getRegionalInfo(query);
    if (regionInfo.isNotEmpty) {
      buffer.writeln('## Regional Information:');
      buffer.writeln(_formatDatabaseInfo(regionInfo));
      buffer.writeln();
    }
    
    // NEW: Get travel guide information
    final travelInfo = EthiopiaTravelGuideDatabase.getTravelGuideInfo(query);
    if (travelInfo.isNotEmpty) {
      buffer.writeln('## Travel Guide:');
      buffer.writeln(_formatDatabaseInfo(travelInfo));
      buffer.writeln();
    }
    
    // NEW: Get wildlife information
    final wildlifeInfo = EthiopiaWildlifeNatureDatabase.getWildlifeInfo(query);
    if (wildlifeInfo.isNotEmpty) {
      buffer.writeln('## Wildlife & Nature:');
      buffer.writeln(_formatDatabaseInfo(wildlifeInfo));
      buffer.writeln();
    }
    
    // NEW: Get festival information
    final festivalInfo = EthiopiaFestivalsCalendarDatabase.getFestivalInfo(query);
    if (festivalInfo.isNotEmpty) {
      buffer.writeln('## Festivals & Calendar:');
      buffer.writeln(_formatDatabaseInfo(festivalInfo));
      buffer.writeln();
    }
    
    // Search for location-specific information
    final locationInfo = _searchLocationInfo(query);
    if (locationInfo.isNotEmpty) {
      buffer.writeln('## Location Details:');
      buffer.writeln(locationInfo);
      buffer.writeln();
    }
    
    final totalKnowledge = buffer.toString();
    print('📊 Total knowledge retrieved: ${totalKnowledge.length} characters from all sources');
    
    // Cache the response for future use
    if (totalKnowledge.isNotEmpty) {
      _responseCache[cacheKey] = totalKnowledge;
      // Limit cache size to prevent memory issues
      if (_responseCache.length > 100) {
        final oldestKey = _responseCache.keys.first;
        _responseCache.remove(oldestKey);
      }
    }
    
    return totalKnowledge;
  }

  /// Format database information for context
  String _formatDatabaseInfo(Map<String, dynamic> info) {
    final buffer = StringBuffer();
    
    info.forEach((key, value) {
      if (value is List) {
        buffer.writeln('**$key**: ${value.join(', ')}');
      } else if (value is String && value.isNotEmpty) {
        buffer.writeln('**$key**: $value');
      }
    });
    
    return buffer.toString();
  }

  /// Search for location-specific information
  String _searchLocationInfo(String query) {
    final locations = [
      'lalibela', 'axum', 'gondar', 'bahir dar', 'harar',
      'addis ababa', 'simien', 'danakil', 'bale', 'omo valley'
    ];
    
    final queryLower = query.toLowerCase();
    final matchedLocations = locations.where((loc) => queryLower.contains(loc));
    
    if (matchedLocations.isEmpty) return '';
    
    final buffer = StringBuffer();
    for (final location in matchedLocations) {
      final info = ComprehensiveEthiopiaDatabase.getInformation(location);
      if (info.isNotEmpty) {
        buffer.writeln(_formatDatabaseInfo(info));
      }
    }
    
    return buffer.toString();
  }

  /// Build enhanced prompt with RAG context
  String _buildEnhancedPrompt(
    String userMessage,
    String relevantKnowledge, {
    String? userLocation,
  }) {
    final buffer = StringBuffer();
    
    // Add relevant knowledge as context
    if (relevantKnowledge.isNotEmpty) {
      buffer.writeln('=== ETHIOPIAN KNOWLEDGE BASE ===');
      buffer.writeln(relevantKnowledge);
      buffer.writeln('=== END KNOWLEDGE BASE ===');
      buffer.writeln();
    }
    
    // Add location context if available
    if (userLocation != null && userLocation.isNotEmpty) {
      buffer.writeln('User\'s current location: $userLocation');
      buffer.writeln('Provide location-specific recommendations when relevant.');
      buffer.writeln();
    }
    
    // Add conversation history for context (last 5 messages)
    if (_conversationHistory.length > 1) {
      buffer.writeln('=== CONVERSATION HISTORY ===');
      final recentMessages = _conversationHistory.length > 10
          ? _conversationHistory.sublist(_conversationHistory.length - 10)
          : _conversationHistory;
      
      for (final msg in recentMessages) {
        buffer.writeln('${msg.isUser ? "Tourist" : "Selam"}: ${msg.text}');
      }
      buffer.writeln('=== END HISTORY ===');
      buffer.writeln();
    }
    
    // Add current user message
    buffer.writeln('Tourist\'s Question: $userMessage');
    buffer.writeln();
    buffer.writeln('CRITICAL INSTRUCTIONS:');
    buffer.writeln('1. ONLY answer if the question is about Ethiopia, Ethiopian culture, history, language, tourism, food, or travel');
    buffer.writeln('2. If the question is NOT about Ethiopia, politely redirect to Ethiopian topics');
    buffer.writeln('3. Provide a comprehensive response that is 1000+ characters long');
    buffer.writeln('4. Use the Ethiopian knowledge base extensively');
    buffer.writeln('5. Format with numbered sections, bold headings, and bullet points');
    buffer.writeln('6. Include specific Ethiopian names, places, and details');
    buffer.writeln('7. Be professional, detailed, and helpful about Ethiopia');
    
    return buffer.toString();
  }

  /// Call OpenAI API with enhanced prompt and perfect error handling
  Future<String> _callOpenAI(String prompt) async {
    final apiKey = _apiKeyManager.getBestAvailableKey();
    
    if (apiKey == null || !apiKey.startsWith('sk-')) {
      throw Exception('Invalid OpenAI API key');
    }

    final messages = [
      {'role': 'system', 'content': _systemPrompt},
      {'role': 'user', 'content': prompt},
    ];

    try {
      final response = await http.post(
        Uri.parse('$_openaiBaseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': _chatModel,
          'messages': messages,
          'max_tokens': 4000, // Increased for more comprehensive responses
          'temperature': 0.7,
          'top_p': 0.9,
          'frequency_penalty': 0.3,
          'presence_penalty': 0.3,
          'stream': false,
        }),
      ).timeout(const Duration(seconds: 30)); // Add timeout

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['choices'] != null && data['choices'].isNotEmpty) {
          final content = data['choices'][0]['message']['content'] as String;
          return _formatResponsePerfectly(content.trim());
        } else {
          throw Exception('Invalid response format from OpenAI');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your OpenAI API key configuration.');
      } else if (response.statusCode == 429) {
        throw Exception('Rate limit exceeded. Please try again in a moment.');
      } else if (response.statusCode == 500) {
        throw Exception('OpenAI server error. Please try again later.');
      } else if (response.statusCode == 503) {
        throw Exception('OpenAI service temporarily unavailable. Please try again later.');
      } else {
        throw Exception('OpenAI API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      if (e.toString().contains('timeout')) {
        throw Exception('Request timed out. Please try again.');
      } else if (e.toString().contains('SocketException')) {
        throw Exception('Network connection error. Please check your internet connection.');
      } else {
        rethrow;
      }
    }
  }

  /// Format response perfectly with enhanced structure
  String _formatResponsePerfectly(String content) {
    // Ensure proper formatting
    String formatted = content;
    
    // Add perfect spacing and structure
    formatted = formatted.replaceAll(RegExp(r'\n{3,}'), '\n\n'); // Remove excessive newlines
    formatted = formatted.replaceAll(RegExp(r'^\s+$', multiLine: true), ''); // Remove empty lines
    
    // Ensure proper bullet point formatting
    formatted = formatted.replaceAll(RegExp(r'^[-*]\s+', multiLine: true), '• '); // Standardize bullets
    
    // Ensure proper bold formatting
    formatted = formatted.replaceAll(RegExp(r'\*\*([^*]+)\*\*'), r'**$1**'); // Ensure bold formatting
    
    // Add perfect spacing around sections
    formatted = formatted.replaceAll(RegExp(r'^(\d+\.\s+\*\*[^*]+\*\*)', multiLine: true), r'\n$1'); // Add spacing before numbered sections
    
    return formatted.trim();
  }

  /// Generate response using only knowledge base (fallback)
  Future<String> _generateKnowledgeBaseResponse(String userMessage) async {
    try {
      // Try comprehensive database first
      final dbInfo = ComprehensiveEthiopiaDatabase.getInformation(userMessage);
      if (dbInfo.isNotEmpty) {
        return _formatDetailedResponse(dbInfo, userMessage);
      }
      
      // Try massive knowledge base
      final kbInfo = MassiveEthiopiaKnowledgeBase.getKnowledge(userMessage);
      if (kbInfo.isNotEmpty && kbInfo.length > 100) {
        return kbInfo;
      }
      
      // Default helpful response
      return _generateDefaultResponse(userMessage);
    } catch (e) {
      debugPrint('Knowledge base response error: $e');
      return _generateDefaultResponse(userMessage);
    }
  }

  /// Generate enhanced response using knowledge base only (enhanced fallback)
  Future<String> _generateEnhancedKnowledgeBaseResponse(String userMessage) async {
    try {
      print('🔍 ENHANCED RAG: Processing query with 10,000+ line knowledge base...');
      
      // Check if query is about Ethiopia - if not, redirect
      final lowerQuery = userMessage.toLowerCase();
      if (!_isEthiopiaRelatedQuery(lowerQuery)) {
        return '''I specialize in Ethiopian culture, history, and travel. What would you like to know about Ethiopia? 🇪🇹

Ethiopia is a remarkable country with extraordinary cultural, historical, and natural diversity — offering unique experiences that can't be found anywhere else in the world. Here's what I can help you with:

**🏛️ Historical & Cultural Information**
• Ancient kingdoms and civilizations
• Religious sites and traditions  
• Cultural practices and festivals
• Historical figures and events

**🗣️ Language & Communication**
• Amharic phrases and pronunciation
• Essential greetings and numbers
• Cultural communication norms
• Language learning resources

**🍽️ Food & Cuisine**
• Traditional dishes and recipes
• Coffee ceremony details
• Dining etiquette and customs
• Regional specialties

**📍 Travel & Tourism**
• All 9 UNESCO World Heritage Sites
• Major cities and attractions
• Transportation options
• Accommodation recommendations

**🌍 Geography & Nature**
• All 11 regions with detailed information
• National parks and wildlife
• Climate and weather patterns
• Natural attractions

**What would you like to know about Ethiopia?** I'm ready to provide detailed, professional responses about any aspect of Ethiopian culture, history, travel, or language!''';
      }
      
      // Get comprehensive information from all knowledge sources
      final knowledge = _retrieveRelevantKnowledge(userMessage);
      
      // Check for specific topic templates first
      final specificResponse = _getPerfectResponseTemplate(userMessage);
      if (specificResponse.isNotEmpty) {
        print('✅ ENHANCED RAG: Using specific template response - ${specificResponse.length} characters');
        return specificResponse;
      }
      
      if (knowledge.isNotEmpty) {
        // Create a more dynamic, conversational response
        final response = _createDynamicResponse(userMessage, knowledge);
        print('✅ ENHANCED RAG: Generated ${response.length} character response');
        return response;
      } else {
        // Provide more specific guidance based on common queries
        
        if (lowerQuery.contains('amharic') || lowerQuery.contains('language') || lowerQuery.contains('phrase')) {
          return '''Amharic is Ethiopia's official language and one of the most fascinating aspects of Ethiopian culture — spoken by over **22 million people** and written in the unique **Ge'ez script**. 🗣️✨

Here's a comprehensive guide to **Amharic language, learning resources, and cultural significance**:

1. **Language Structure**
• **Amharic** is the official language of Ethiopia with 22+ million speakers
• Uses the **Ge'ez script (fidel)** with 33 consonant characters
• Each consonant has 7 vowel forms, creating 231 possible characters
• Written left to right, with no spaces between words
• Many English words have been adopted into modern Amharic

2. **Essential Phrases**
• **Greetings:**
  - ሰላም (Selam) - Hello/Peace
  - እንዴት ናችሁ? (Indet nachehu?) - How are you?
  - አመሰግናለሁ (Ameseginalew) - Thank you
• **Basic Phrases:**
  - አዎ (Awo) - Yes
  - አይ (Ay) - No
  - እባክዎ (Ebakwo) - Please
  - ይቅርታ (Yiqirta) - Excuse me

3. **Numbers**
• አንድ (And) - One
• ሁለት (Hulet) - Two
• ሶስት (Sost) - Three

4. **Cultural Significance**
• Learning Amharic opens doors to Ethiopian culture and business
• Essential for understanding Ethiopian literature, music, and traditions
• Shows respect for Ethiopian culture and people

**What else would you like to know?**
I can provide detailed information about:
• Specific destinations and attractions
• Cultural practices and traditions
• Language learning and communication
• Food and dining recommendations
• Travel planning and logistics
• Historical and cultural context''';
        } else if (lowerQuery.contains('food') || lowerQuery.contains('eat') || lowerQuery.contains('cuisine')) {
          return '''Ethiopian cuisine is one of the world's most unique and flavorful culinary traditions — centered around **injera**, the sourdough flatbread that serves as both plate and utensil. 🍽️✨

Here's a detailed exploration of **Ethiopian food culture, dining etiquette, and must-try dishes**:

1. **Traditional Dishes**
• **Injera** (sourdough flatbread) is the staple food, made from teff flour
• **Doro Wat** - Spicy chicken stew
• **Tibs** - Grilled meat with vegetables
• **Kitfo** - Minced raw beef (Ethiopian tartare)
• **Shiro** - Chickpea stew
• **Berbere spice blend** is essential for authentic Ethiopian flavor

2. **Dining Etiquette**
• Eat with your hands using injera
• Share from the same plate (gursha)
• Try the coffee ceremony
• Don't use your left hand for eating

3. **Coffee Ceremony**
• Coffee ceremony is a social and cultural ritual (3 rounds)
• Fasting periods (Lent, Wednesdays, Fridays) affect food availability
• Central to Ethiopian social life and hospitality

4. **Must-Try Restaurants in Addis Ababa**
• Yod Abyssinia Cultural Restaurant
• Habesha Restaurant
• Lucy Restaurant

**What else would you like to know?**
I can provide detailed information about:
• Specific destinations and attractions
• Cultural practices and traditions
• Language learning and communication
• Food and dining recommendations
• Travel planning and logistics
• Historical and cultural context''';
        } else if (lowerQuery.contains('place') || lowerQuery.contains('visit') || lowerQuery.contains('travel')) {
          return '''Ethiopia is a land of extraordinary diversity — from the ancient rock-hewn churches of Lalibela to the dramatic landscapes of the Simien Mountains, offering **9 UNESCO World Heritage Sites** and countless cultural treasures. 📍✨

Here's a comprehensive guide to **Ethiopian destinations, travel planning, and cultural experiences**:

1. **UNESCO World Heritage Sites**
• Ethiopia has **9 UNESCO World Heritage Sites**
• Best time to visit: October to March (dry season)
• Climate varies significantly by altitude (pack layers!)

2. **Historical Sites**
• **Lalibela** - Rock-hewn churches (UNESCO World Heritage)
• **Axum** - Ancient kingdom ruins and obelisks
• **Gondar** - Royal castles and palaces
• **Harar** - Walled city with 99 mosques

3. **Natural Wonders**
• **Simien Mountains** - Dramatic landscapes and wildlife
• **Danakil Depression** - Otherworldly salt flats
• **Blue Nile Falls** - "Smoking Water" waterfall
• **Bale Mountains** - Unique wildlife and hiking

4. **Addis Ababa Highlights**
• National Museum (Lucy skeleton)
• Holy Trinity Cathedral
• Merkato (largest market in Africa)
• Entoto Hills

5. **Transportation**
• Domestic flights, buses, and 4x4 vehicles available
• Cultural etiquette: Remove shoes when entering homes
• Language: Amharic (official), English widely spoken

**What else would you like to know?**
I can provide detailed information about:
• Specific destinations and attractions
• Cultural practices and traditions
• Language learning and communication
• Food and dining recommendations
• Travel planning and logistics
• Historical and cultural context''';
        } else {
          return '''Ethiopia is a remarkable country with extraordinary cultural, historical, and natural diversity — offering unique experiences that can't be found anywhere else in the world. 🇪🇹✨

Here's a comprehensive overview of **Ethiopia's highlights, culture, and travel opportunities**:

1. **Country Overview**
• Ethiopia is home to 9 UNESCO World Heritage Sites
• The country has its own calendar system (7-8 years behind Gregorian)
• Ethiopia was never colonized, making it unique in Africa
• The coffee ceremony is a central cultural practice
• Amharic is the official language, with English widely spoken

2. **Practical Information**
• **Best travel time**: October to March (dry season)
• **Currency**: Ethiopian Birr (ETB)
• **Climate**: Varies significantly by altitude
• **Transportation**: Domestic flights, buses, and 4x4 vehicles available
• **Cultural etiquette**: Remove shoes when entering homes
• **Language**: Amharic (official), English widely spoken
• **Time zone**: UTC+3 (East Africa Time)

3. **What I Can Help You With**
• **Culture & History** - Ethiopian traditions, coffee ceremonies, historical sites
• **Food & Dining** - Amazing Ethiopian cuisine and dining etiquette  
• **Places to Visit** - Must-see destinations and travel recommendations
• **Language** - Basic Amharic phrases and pronunciation
• **Travel Tips** - Practical advice for your Ethiopian journey

**What would you like to know about Ethiopia?**
I can provide detailed information about:
• Specific destinations and attractions
• Cultural practices and traditions
• Language learning and communication
• Food and dining recommendations
• Travel planning and logistics
• Historical and cultural context''';
        }
      }
    } catch (e) {
      debugPrint('Enhanced knowledge base response error: $e');
      return '''🇪🇹 **Ethiopia Information**

I'm here to help you learn about Ethiopia! What would you like to know about this amazing country?''';
    }
  }

  /// Format detailed response from database
  String _formatDetailedResponse(Map<String, dynamic> data, String query) {
    final buffer = StringBuffer();
    
    buffer.writeln('# 🇪🇹 Ethiopia Information\n');
    
    if (data.containsKey('name')) {
      buffer.writeln('## ${data['name']}\n');
    }
    
    if (data.containsKey('description')) {
      buffer.writeln('${data['description']}\n');
    }
    
    if (data.containsKey('majorAttractions')) {
      buffer.writeln('### 🏛️ Major Attractions:');
      for (final attraction in data['majorAttractions']) {
        buffer.writeln('• $attraction');
      }
      buffer.writeln();
    }
    
    if (data.containsKey('activities')) {
      buffer.writeln('### 🎯 Activities:');
      for (final activity in data['activities']) {
        buffer.writeln('• $activity');
      }
      buffer.writeln();
    }
    
    if (data.containsKey('tips')) {
      buffer.writeln('### 💡 Travel Tips:');
      buffer.writeln(data['tips']);
      buffer.writeln();
    }
    
    buffer.writeln('---');
    buffer.writeln('*Want to know more? Ask me about specific places, activities, or cultural aspects!*');
    
    return buffer.toString();
  }

  /// Generate default helpful response
  String _generateDefaultResponse(String query) {
    return '''
# 🇪🇹 Welcome to Ethiopia!

I'm Selam, your Ethiopian tourism guide! I'd be happy to help you with:

**🗺️ Places to Visit:**
• Lalibela's rock-hewn churches
• Simien Mountains National Park
• Axum's ancient obelisks
• Gondar's royal castles
• Lake Tana and Blue Nile Falls

**🍽️ Ethiopian Cuisine:**
• Injera and traditional wats
• Coffee ceremony experience
• Local restaurants and food spots

**🗣️ Language Help:**
• Common Amharic phrases
• Cultural etiquette
• Communication tips

**🚗 Practical Information:**
• Transportation options
• Safety tips
• Accommodation recommendations

**What would you like to know about Ethiopia?** Just ask me anything!

*Note: For the best experience, configure your OpenAI API key to enable advanced AI conversations.*
''';
  }

  /// Create perfect error message with helpful guidance
  ChatMessage _createErrorMessage(String error) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: '''I'm experiencing a temporary connection issue, but I can still provide you with comprehensive information about Ethiopia using my extensive knowledge base! 🇪🇹✨

Here's what I can help you with right now:

**🏛️ Historical & Cultural Information**
• Ancient kingdoms and civilizations
• Religious sites and traditions
• Cultural practices and festivals
• Historical figures and events

**🗣️ Language & Communication**
• Amharic phrases and pronunciation
• Essential greetings and numbers
• Cultural communication norms
• Language learning resources

**🍽️ Food & Cuisine**
• Traditional dishes and recipes
• Coffee ceremony details
• Dining etiquette and customs
• Regional specialties

**📍 Travel & Tourism**
• All 9 UNESCO World Heritage Sites
• Major cities and attractions
• Transportation options
• Accommodation recommendations

**🌍 Geography & Nature**
• All 11 regions with detailed information
• National parks and wildlife
• Climate and weather patterns
• Natural attractions

**What would you like to know about Ethiopia?** I'm ready to provide detailed, professional responses about any aspect of Ethiopian culture, history, travel, or language!

*Note: For the most advanced AI responses, please check your internet connection and API configuration.*''',
      isUser: false,
      timestamp: DateTime.now(),
      error: false, // Don't mark as error to avoid red styling
    );
  }

  /// Get conversation history
  List<ChatMessage> getConversationHistory() => List.from(_conversationHistory);

  /// Clear conversation history
  void clearConversation() => _conversationHistory.clear();

  /// Get conversation summary
  String getConversationSummary() {
    if (_conversationHistory.isEmpty) return 'No conversation yet';
    
    final userMessages = _conversationHistory.where((m) => m.isUser).length;
    final aiMessages = _conversationHistory.where((m) => !m.isUser).length;
    
    return '$userMessages questions asked, $aiMessages responses provided';
  }

  /// Create dynamic response based on user query and knowledge with perfect templates
  String _createDynamicResponse(String userMessage, String knowledge) {
    final lowerQuery = userMessage.toLowerCase();
    
    // Check for perfect response templates first
    final perfectTemplate = _getPerfectResponseTemplate(lowerQuery);
    if (perfectTemplate.isNotEmpty) {
      return perfectTemplate;
    }
    
    // Extract key information from knowledge with better filtering
    final lines = knowledge.split('\n');
    final relevantLines = lines.where((line) => 
      line.isNotEmpty && 
      !line.startsWith('#') && 
      !line.startsWith('##') &&
      !line.startsWith('*') &&
      !line.startsWith('-') &&
      line.length > 15 &&
      !line.toLowerCase().contains('error') &&
      !line.toLowerCase().contains('failed')
    ).take(40).toList();
    
    String response = '';
    
      // Professional ChatGPT-style response with detailed formatting
      if (relevantLines.isNotEmpty) {
        // Start with a professional introduction paragraph
        if (lowerQuery.contains('addis ababa') || lowerQuery.contains('addis') || lowerQuery.contains('capital')) {
          response += 'Addis Ababa is the vibrant capital and largest city of Ethiopia, often called the **"New Flower"** — a bustling metropolis that serves as the political, economic, and cultural heart of the country. 🇪🇹✨\n\n';
          response += 'Here\'s a comprehensive guide to **Addis Ababa, covering its attractions, culture, dining, and practical information**:\n\n';
        } else if (lowerQuery.contains('lalibela') || lowerQuery.contains('church') || lowerQuery.contains('religious')) {
          response += 'Lalibela is one of Ethiopia\'s most extraordinary historical and spiritual sites — often called the **"New Jerusalem"** of Africa. 🕌✨\n\n';
          response += 'Here\'s a detailed overview of Lalibela, covering its **history, architecture, religious significance, and tourism**:\n\n';
        } else if (lowerQuery.contains('amharic') || lowerQuery.contains('language') || lowerQuery.contains('learn')) {
          response += 'Amharic is Ethiopia\'s official language and one of the most fascinating aspects of Ethiopian culture — spoken by over **22 million people** and written in the unique **Ge\'ez script**. 🗣️✨\n\n';
          response += 'Here\'s a comprehensive guide to **Amharic language, learning resources, and cultural significance**:\n\n';
        } else if (lowerQuery.contains('food') || lowerQuery.contains('eat') || lowerQuery.contains('cuisine') || lowerQuery.contains('restaurant')) {
          response += 'Ethiopian cuisine is one of the world\'s most unique and flavorful culinary traditions — centered around **injera**, the sourdough flatbread that serves as both plate and utensil. 🍽️✨\n\n';
          response += 'Here\'s a detailed exploration of **Ethiopian food culture, dining etiquette, and must-try dishes**:\n\n';
        } else if (lowerQuery.contains('travel') || lowerQuery.contains('visit') || lowerQuery.contains('place') || lowerQuery.contains('tourism')) {
          response += 'Ethiopia is a land of extraordinary diversity — from the ancient rock-hewn churches of Lalibela to the dramatic landscapes of the Simien Mountains, offering **9 UNESCO World Heritage Sites** and countless cultural treasures. 📍✨\n\n';
          response += 'Here\'s a comprehensive guide to **Ethiopian destinations, travel planning, and cultural experiences**:\n\n';
        } else if (lowerQuery.contains('history') || lowerQuery.contains('ancient') || lowerQuery.contains('empire')) {
          response += 'Ethiopia boasts one of the world\'s most ancient and continuous civilizations — a land that was **never colonized** and home to legendary kingdoms like Axum and Gondar. 🏛️✨\n\n';
          response += 'Here\'s a detailed exploration of **Ethiopian history, ancient kingdoms, and cultural heritage**:\n\n';
        } else {
          response += 'Ethiopia is a remarkable country with extraordinary cultural, historical, and natural diversity — offering unique experiences that can\'t be found anywhere else in the world. 🇪🇹✨\n\n';
          response += 'Here\'s a comprehensive overview of **Ethiopia\'s highlights, culture, and travel opportunities**:\n\n';
        }

      // Add numbered sections with professional formatting
      response += '1. **Key Information**\n';
      for (final line in relevantLines.take(8)) {
        if (line.trim().isNotEmpty) {
          response += '• $line\n';
        }
      }
      response += '\n';

      // Add comprehensive context based on query type with numbered sections
      if (lowerQuery.contains('addis ababa') || lowerQuery.contains('addis') || lowerQuery.contains('capital')) {
        response += '2. **City Overview**\n';
        response += '• **Population:** Over 5.2 million people (2024)\n';
        response += '• **Altitude:** 2,355 meters (7,726 feet) above sea level\n';
        response += '• **Climate:** Pleasant year-round due to high altitude\n';
        response += '• **Founded:** 1886 by Emperor Menelik II\n';
        response += '• **Meaning:** "New Flower" in Amharic\n\n';
        
        response += '3. **Major Attractions**\n';
        response += '• **National Museum:** Home to Lucy (Dinkinesh), the 3.2 million-year-old hominid fossil\n';
        response += '• **Holy Trinity Cathedral:** Final resting place of Emperor Haile Selassie\n';
        response += '• **Mercato:** Africa\'s largest open-air market with endless shopping\n';
        response += '• **Entoto Mountains:** Panoramic city views and historic churches\n';
        response += '• **Unity Park:** Presidential palace gardens (opened 2019)\n\n';
        
        response += '4. **Food and Dining**\n';
        response += '• **Yod Abyssinia Cultural Restaurant:** Traditional Ethiopian cuisine with cultural shows\n';
        response += '• **Habesha Restaurant:** Authentic local dishes\n';
        response += '• **Lucy Restaurant:** Named after the famous fossil\n';
        response += '• **Tomoca Coffee:** Historic coffee shop since 1953\n\n';
        
        response += '5. **Transportation**\n';
        response += '• **Bole International Airport:** Main gateway to Ethiopia\n';
        response += '• **Addis Light Rail:** First in sub-Saharan Africa\n';
        response += '• **Blue-white taxis:** Traditional taxi system\n';
        response += '• **Ride apps:** RIDE, ZayRide for modern transportation\n\n';
        
        response += '6. **Shopping and Markets**\n';
        response += '• **Mercato:** Everything from spices to electronics\n';
        response += '• **Bole Road:** Modern shopping centers\n';
        response += '• **Piazza:** Traditional shopping district\n';
        response += '• **Shero Meda:** Textile and clothing market\n\n';
        
        response += '7. **Nightlife and Entertainment**\n';
        response += '• **Jazz clubs:** Vibrant music scene\n';
        response += '• **Cultural restaurants:** Traditional music and dance\n';
        response += '• **Bars and cafes:** Modern and traditional options\n';
        response += '• **Cinemas:** International and local films\n\n';
        
        response += '8. **Practical Information**\n';
        response += '• **Best time to visit:** October to March (dry season)\n';
        response += '• **Currency:** Ethiopian Birr (ETB)\n';
        response += '• **Language:** Amharic (official), English widely spoken\n';
        response += '• **Safety:** Generally safe, watch for pickpockets in crowded areas\n\n';
        
      } else if (lowerQuery.contains('lalibela') || lowerQuery.contains('church') || lowerQuery.contains('religious')) {
        response += '2. **Historical Background**\n';
        response += '• Built during the reign of **King Lalibela** (c. 1181-1221 AD) of the Zagwe dynasty\n';
        response += '• The king aimed to build a "**New Jerusalem**" after Muslim conquests made pilgrimage to the original Jerusalem difficult for Ethiopian Christians\n';
        response += '• According to tradition, the churches were constructed with the help of angels — some say during the day by workers, and at night by angels who completed double the work\n\n';
        
        response += '3. **Rock-Hewn Churches**\n';
        response += '• **11 monolithic churches** carved entirely from single pieces of rock\n';
        response += '• Instead of being built upwards, they were **cut downwards into the ground**, forming free-standing structures hidden in the earth\n';
        response += '• They are grouped into **two main clusters** plus an isolated church\n\n';
        
        response += '4. **Religious Significance**\n';
        response += '• Lalibela remains a **living, active pilgrimage site** for Ethiopian Orthodox Christians\n';
        response += '• Daily prayers, chanting, and liturgical services take place inside the churches\n';
        response += '• It is especially active during **Ethiopian Orthodox festivals**, such as:\n';
        response += '  - **Genna (Ethiopian Christmas)** — January 7\n';
        response += '  - **Timkat (Epiphany)** — January 19\n\n';
        
        response += '5. **UNESCO World Heritage Site**\n';
        response += '• **Designated in 1978** as one of the first UNESCO World Heritage Sites in Africa\n';
        response += '• It\'s recognized for:\n';
        response += '  - **Outstanding rock-cut architecture**\n';
        response += '  - **Continuous religious tradition**\n';
        response += '  - **Cultural and spiritual significance**\n\n';
        
        response += '6. **Tourism and Access**\n';
        response += '• **Visitors:** Tourists from around the world come to explore its churches, unique architecture, and spiritual atmosphere\n';
        response += '• **Best time to visit:** The dry season (October to March)\n';
        response += '• **Access:** By road or via Lalibela Airport (daily flights from Addis Ababa)\n\n';
        
        response += 'When visiting, tourists often walk through **tunnels, trenches, and passageways** connecting the churches — almost like entering a hidden underground city.\n\n';
        
        response += '**In Summary**\n';
        response += 'Lalibela is more than just a historical site — it\'s a **spiritual heart of Ethiopia**, a masterpiece of medieval architecture, and a symbol of resilience and faith.\n\n';
        
      } else if (lowerQuery.contains('amharic') || lowerQuery.contains('language') || lowerQuery.contains('learn')) {
        response += '2. **Language Structure**\n';
        response += '• **Amharic** is the official language of Ethiopia with 22+ million speakers\n';
        response += '• Uses the **Ge\'ez script (fidel)** with 33 consonant characters\n';
        response += '• Each consonant has 7 vowel forms, creating 231 possible characters\n';
        response += '• Written left to right, with no spaces between words\n';
        response += '• Many English words have been adopted into modern Amharic\n\n';
        
        response += '3. **Essential Phrases**\n';
        response += '• **Greetings:**\n';
        response += '  - ሰላም (Selam) - Hello/Peace\n';
        response += '  - እንዴት ናችሁ? (Indet nachehu?) - How are you?\n';
        response += '  - አመሰግናለሁ (Ameseginalew) - Thank you\n';
        response += '• **Basic Phrases:**\n';
        response += '  - አዎ (Awo) - Yes\n';
        response += '  - አይ (Ay) - No\n';
        response += '  - እባክዎ (Ebakwo) - Please\n\n';
        
        response += '4. **Cultural Significance**\n';
        response += '• Learning Amharic opens doors to Ethiopian culture and business\n';
        response += '• Essential for understanding Ethiopian literature, music, and traditions\n';
        response += '• Shows respect for Ethiopian culture and people\n\n';
        
      } else if (lowerQuery.contains('food') || lowerQuery.contains('eat') || lowerQuery.contains('cuisine') || lowerQuery.contains('restaurant')) {
        response += '2. **Traditional Dishes**\n';
        response += '• **Injera** (sourdough flatbread) is the staple food, made from teff flour\n';
        response += '• Eaten with hands, using injera to scoop up stews (wot)\n';
        response += '• **Berbere spice blend** is essential for authentic Ethiopian flavor\n';
        response += '• Popular dishes include doro wot, kitfo, and tibs\n\n';
        
        response += '3. **Dining Etiquette**\n';
        response += '• Eat with your hands using injera\n';
        response += '• Share from the same plate (gursha)\n';
        response += '• Try the coffee ceremony\n';
        response += '• Don\'t use your left hand for eating\n\n';
        
        response += '4. **Coffee Ceremony**\n';
        response += '• Coffee ceremony is a social and cultural ritual (3 rounds)\n';
        response += '• Fasting periods (Lent, Wednesdays, Fridays) affect food availability\n';
        response += '• Central to Ethiopian social life and hospitality\n\n';
        
      } else if (lowerQuery.contains('travel') || lowerQuery.contains('visit') || lowerQuery.contains('place') || lowerQuery.contains('tourism')) {
        response += '2. **UNESCO World Heritage Sites**\n';
        response += '• Ethiopia has **9 UNESCO World Heritage Sites**\n';
        response += '• Best time to visit: October to March (dry season)\n';
        response += '• Climate varies significantly by altitude (pack layers!)\n\n';
        
        response += '3. **Major Destinations**\n';
        response += '• **Addis Ababa** - Capital city with museums and markets\n';
        response += '• **Lalibela** - Rock-hewn churches\n';
        response += '• **Axum** - Ancient kingdom ruins and obelisks\n';
        response += '• **Gondar** - Royal castles and palaces\n';
        response += '• **Simien Mountains** - Dramatic landscapes and wildlife\n\n';
        
        response += '4. **Transportation**\n';
        response += '• Domestic flights, buses, and 4x4 vehicles available\n';
        response += '• Cultural etiquette: Remove shoes when entering homes\n';
        response += '• Language: Amharic (official), English widely spoken\n\n';
        
      } else if (lowerQuery.contains('history') || lowerQuery.contains('ancient') || lowerQuery.contains('empire')) {
        response += '2. **Ancient Kingdoms**\n';
        response += '• Ethiopia was never colonized, making it unique in Africa\n';
        response += '• Home to ancient kingdoms like Axum and Gondar\n';
        response += '• Has its own calendar system (7-8 years behind Gregorian)\n\n';
        
        response += '3. **Cultural Traditions**\n';
        response += '• 12-hour time system starting at sunrise (6 AM = 12:00)\n';
        response += '• Rich tradition of music, dance, and religious festivals\n';
        response += '• Birthplace of coffee and the coffee ceremony tradition\n\n';
        
      } else {
        // General comprehensive information
        response += '2. **Country Overview**\n';
        response += '• Ethiopia is home to 9 UNESCO World Heritage Sites\n';
        response += '• The country has its own calendar system (7-8 years behind Gregorian)\n';
        response += '• Ethiopia was never colonized, making it unique in Africa\n';
        response += '• The coffee ceremony is a central cultural practice\n';
        response += '• Amharic is the official language, with English widely spoken\n\n';
        
        response += '3. **Practical Information**\n';
        response += '• **Best travel time**: October to March (dry season)\n';
        response += '• **Currency**: Ethiopian Birr (ETB)\n';
        response += '• **Climate**: Varies significantly by altitude\n';
        response += '• **Transportation**: Domestic flights, buses, and 4x4 vehicles available\n';
        response += '• **Cultural etiquette**: Remove shoes when entering homes\n';
        response += '• **Language**: Amharic (official), English widely spoken\n';
        response += '• **Time zone**: UTC+3 (East Africa Time)\n\n';
      }

      // Add helpful follow-up suggestions
      response += '**What else would you like to know?**\n';
      response += 'I can provide detailed information about:\n';
      response += '• Specific destinations and attractions\n';
      response += '• Cultural practices and traditions\n';
      response += '• Language learning and communication\n';
      response += '• Food and dining recommendations\n';
      response += '• Travel planning and logistics\n';
      response += '• Historical and cultural context\n\n';
    } else {
      // Fallback response when no specific knowledge is found
      response += 'I\'d be happy to help you with information about Ethiopia. ';
      response += 'While I don\'t have specific details about your query in my current knowledge base, ';
      response += 'I can provide general information about Ethiopian culture, travel, language, food, and history.\n\n';
      
      // Provide general information based on query type
      if (lowerQuery.contains('lalibela') || lowerQuery.contains('church')) {
        response += '**About Lalibela:**\n';
        response += '• Lalibela is a UNESCO World Heritage Site in northern Ethiopia\n';
        response += '• Famous for its 11 medieval rock-hewn churches\n';
        response += '• Built in the 12th-13th centuries by King Lalibela\n';
        response += '• Still an active pilgrimage site for Orthodox Christians\n';
        response += '• Often called the "New Jerusalem" of Africa\n\n';
      } else if (lowerQuery.contains('amharic') || lowerQuery.contains('language')) {
        response += '**About Amharic Language:**\n';
        response += '• Amharic is the official language of Ethiopia\n';
        response += '• Spoken by over 22 million people\n';
        response += '• Uses the Ge\'ez script (fidel)\n';
        response += '• Written left to right with no spaces between words\n';
        response += '• Learning Amharic helps understand Ethiopian culture\n\n';
      } else if (lowerQuery.contains('food') || lowerQuery.contains('eat')) {
        response += '**About Ethiopian Food:**\n';
        response += '• Injera is the staple bread made from teff flour\n';
        response += '• Eaten with hands, using injera to scoop up stews\n';
        response += '• Berbere spice blend is essential for flavor\n';
        response += '• Coffee ceremony is a cultural ritual\n';
        response += '• Popular dishes include doro wot, kitfo, and tibs\n\n';
      } else {
        response += '**About Ethiopia:**\n';
        response += '• Ethiopia is home to 9 UNESCO World Heritage Sites\n';
        response += '• The country was never colonized, unique in Africa\n';
        response += '• Has its own calendar system (7-8 years behind Gregorian)\n';
        response += '• Birthplace of coffee and the coffee ceremony\n';
        response += '• Amharic is the official language\n';
        response += '• Best travel time: October to March\n\n';
      }
      
      response += '**What would you like to know about Ethiopia?**\n';
      response += '• Travel destinations and attractions\n';
      response += '• Cultural practices and traditions\n';
      response += '• Language learning (Amharic)\n';
      response += '• Food and dining\n';
      response += '• Historical information\n';
      response += '• Practical travel tips\n\n';
    }
    
    return response;
  }

  /// Get perfect response template for common queries
  String _getPerfectResponseTemplate(String lowerQuery) {
    // Addis Ababa perfect template - PRIORITY CHECK
    if (lowerQuery.contains('addis ababa') || lowerQuery.contains('addis') || lowerQuery.contains('capital')) {
      return _getAddisAbabaResponse();
    }
    
    // Lalibela perfect template
    if (lowerQuery.contains('lalibela') || lowerQuery.contains('church') || lowerQuery.contains('religious') || lowerQuery.contains('rock-hewn')) {
      return '''Lalibela is one of Ethiopia's most extraordinary historical and spiritual sites — often called the **"New Jerusalem"** of Africa. 🕌✨

Here's a detailed overview of Lalibela, covering its **history, architecture, religious significance, and tourism**:

1. **Historical Background**
• Built during the reign of **King Lalibela** (c. 1181-1221 AD) of the Zagwe dynasty
• The king aimed to build a "**New Jerusalem**" after Muslim conquests made pilgrimage to the original Jerusalem difficult for Ethiopian Christians
• According to tradition, the churches were constructed with the help of angels — some say during the day by workers, and at night by angels who completed double the work

2. **Rock-Hewn Churches**
• **11 monolithic churches** carved entirely from single pieces of rock
• Instead of being built upwards, they were **cut downwards into the ground**, forming free-standing structures hidden in the earth
• They are grouped into **two main clusters** plus an isolated church

3. **Religious Significance**
• Lalibela remains a **living, active pilgrimage site** for Ethiopian Orthodox Christians
• Daily prayers, chanting, and liturgical services take place inside the churches
• It is especially active during **Ethiopian Orthodox festivals**, such as:
  - **Genna (Ethiopian Christmas)** — January 7
  - **Timkat (Epiphany)** — January 19

4. **UNESCO World Heritage Site**
• **Designated in 1978** as one of the first UNESCO World Heritage Sites in Africa
• It's recognized for:
  - **Outstanding rock-cut architecture**
  - **Continuous religious tradition**
  - **Cultural and spiritual significance**

5. **Tourism and Access**
• **Visitors:** Tourists from around the world come to explore its churches, unique architecture, and spiritual atmosphere
• **Best time to visit:** The dry season (October to March)
• **Access:** By road or via Lalibela Airport (daily flights from Addis Ababa)

When visiting, tourists often walk through **tunnels, trenches, and passageways** connecting the churches — almost like entering a hidden underground city.

**In Summary**
Lalibela is more than just a historical site — it's a **spiritual heart of Ethiopia**, a masterpiece of medieval architecture, and a symbol of resilience and faith.''';
    }
    
    // Amharic language perfect template
    if (lowerQuery.contains('amharic') || lowerQuery.contains('language') || lowerQuery.contains('learn') || lowerQuery.contains('phrase')) {
      return '''Amharic is Ethiopia's official language and one of the most fascinating aspects of Ethiopian culture — spoken by over **22 million people** and written in the unique **Ge'ez script**. 🗣️✨

Here's a comprehensive guide to **Amharic language, learning resources, and cultural significance**:

1. **Language Structure**
• **Amharic** is the official language of Ethiopia with 22+ million speakers
• Uses the **Ge'ez script (fidel)** with 33 consonant characters
• Each consonant has 7 vowel forms, creating 231 possible characters
• Written left to right, with no spaces between words
• Many English words have been adopted into modern Amharic

2. **Essential Phrases**
• **Greetings:**
  - ሰላም (Selam) - Hello/Peace
  - እንዴት ናችሁ? (Indet nachehu?) - How are you?
  - አመሰግናለሁ (Ameseginalew) - Thank you
• **Basic Phrases:**
  - አዎ (Awo) - Yes
  - አይ (Ay) - No
  - እባክዎ (Ebakwo) - Please
  - ይቅርታ (Yiqirta) - Excuse me

3. **Numbers**
• አንድ (And) - One
• ሁለት (Hulet) - Two
• ሶስት (Sost) - Three

4. **Cultural Significance**
• Learning Amharic opens doors to Ethiopian culture and business
• Essential for understanding Ethiopian literature, music, and traditions
• Shows respect for Ethiopian culture and people

**What else would you like to know?**
I can provide detailed information about:
• Specific destinations and attractions
• Cultural practices and traditions
• Language learning and communication
• Food and dining recommendations
• Travel planning and logistics
• Historical and cultural context''';
    }
    
    // Ethiopian coffee perfect template
    if (lowerQuery.contains('coffee') || lowerQuery.contains('buna') || lowerQuery.contains('drink') || lowerQuery.contains('ceremony')) {
      return '''Ethiopian coffee culture is one of the world's most unique and elaborate traditions — centered around the **coffee ceremony (buna)** that serves as the heart of Ethiopian social life. ☕✨

Here's a comprehensive guide to **Ethiopian coffee culture, ceremony, and traditions**:

1. **Coffee Ceremony (Buna)**
• **Elaborate ritual** involving roasting, grinding, and brewing
• **Three rounds** of coffee service (abol, tona, baraka)
• **Social bonding** and community gathering
• **Traditional equipment** including jebena (clay pot) and cups

2. **Coffee Preparation**
• **Green beans** roasted over charcoal
• **Fresh grinding** with mortar and pestle
• **Traditional brewing** in clay jebena
• **Serving** with popcorn, bread, or snacks

3. **Cultural Significance**
• **Hospitality** - offering coffee shows respect
• **Social bonding** - brings people together
• **Religious importance** - fasting periods affect coffee consumption
• **Business meetings** - often conducted over coffee

4. **Best Coffee Spots in Addis Ababa**
• **Tomoca Coffee** - Historic coffee shop since 1953
• **Kaldi's Coffee** - Modern Ethiopian coffee chain
• **Traditional coffee houses** in Mercato area

5. **Coffee Varieties**
• **Yirgacheffe** - Floral and citrusy, from Sidama region
• **Harrar** - Wine-like flavor, from Harar region
• **Sidamo** - Full-bodied, from Sidama region
• **Limu** - Bright and clean, from Oromia region

6. **Traditional Coffee Etiquette**
• **Accept all three rounds** if invited (shows respect)
• **Remove shoes** before entering coffee ceremony area
• **Use right hand** for eating and drinking
• **Wait for host** to serve before drinking

7. **Coffee and Religion**
• **Fasting periods** - Orthodox Christians avoid coffee during Lent
• **Wednesdays and Fridays** - traditional fasting days
• **Religious festivals** - coffee ceremonies during celebrations

8. **Modern Coffee Culture**
• **Coffee shops** in Addis Ababa blend traditional and modern
• **Export quality** - Ethiopia is major coffee exporter
• **Coffee tourism** - visit coffee farms and processing centers
• **International recognition** - Ethiopian coffee highly prized worldwide

**What else would you like to know?**
I can provide detailed information about:
• Specific destinations and attractions
• Cultural practices and traditions
• Language learning and communication
• Food and dining recommendations
• Travel planning and logistics
• Historical and cultural context''';
    }
    
    // Addis Ababa perfect template
    if (lowerQuery.contains('addis ababa') || lowerQuery.contains('addis') || lowerQuery.contains('capital')) {
      return _getAddisAbabaResponse();
    }
    
    // Ethiopian food perfect template
    if (lowerQuery.contains('food') || lowerQuery.contains('eat') || lowerQuery.contains('cuisine')) {
      return '''Ethiopian cuisine is one of the world's most unique and flavorful culinary traditions — centered around **injera**, the sourdough flatbread that serves as both plate and utensil. 🍽️✨

Here's a detailed exploration of **Ethiopian food culture, dining etiquette, and must-try dishes**:

1. **Traditional Dishes**
• **Injera** (sourdough flatbread) is the staple food, made from teff flour
• **Doro Wat** - Spicy chicken stew
• **Tibs** - Grilled meat with vegetables
• **Kitfo** - Minced raw beef (Ethiopian tartare)
• **Shiro** - Chickpea stew
• **Berbere spice blend** is essential for authentic Ethiopian flavor

2. **Dining Etiquette**
• Eat with your hands using injera
• Share from the same plate (gursha)
• Try the coffee ceremony
• Don't use your left hand for eating

3. **Coffee Ceremony**
• Coffee ceremony is a social and cultural ritual (3 rounds)
• Fasting periods (Lent, Wednesdays, Fridays) affect food availability
• Central to Ethiopian social life and hospitality

4. **Must-Try Restaurants in Addis Ababa**
• Yod Abyssinia Cultural Restaurant
• Habesha Restaurant
• Lucy Restaurant

**What else would you like to know?**
I can provide detailed information about:
• Specific destinations and attractions
• Cultural practices and traditions
• Language learning and communication
• Food and dining recommendations
• Travel planning and logistics
• Historical and cultural context''';
    }
    
    // General Ethiopia template for broad queries
    if (lowerQuery.contains('ethiopia') || lowerQuery.contains('ethiopian') || lowerQuery.contains('visit') || lowerQuery.contains('travel')) {
      return '''Ethiopia is a remarkable country with extraordinary cultural, historical, and natural diversity — offering unique experiences that can't be found anywhere else in the world. 🇪🇹✨

Here's a comprehensive overview of **Ethiopia's highlights, culture, and travel opportunities**:

1. **UNESCO World Heritage Sites**
• Ethiopia has **9 UNESCO World Heritage Sites**
• Best time to visit: October to March (dry season)
• Climate varies significantly by altitude (pack layers!)

2. **Historical Sites**
• **Lalibela** - Rock-hewn churches (UNESCO World Heritage)
• **Axum** - Ancient kingdom ruins and obelisks
• **Gondar** - Royal castles and palaces
• **Harar** - Ancient walled city with Islamic culture

3. **Natural Wonders**
• **Simien Mountains** - Dramatic landscapes and endemic wildlife
• **Danakil Depression** - One of the hottest places on Earth
• **Bale Mountains** - Unique ecosystems
• **Lake Tana** - Source of the Blue Nile

4. **Cultural Experiences**
• **Coffee ceremonies** - Traditional social gatherings
• **Orthodox Christian festivals** - Timkat, Meskel, Genna
• **Traditional music and dance** - Unique Ethiopian rhythms
• **Local markets** - Mercato in Addis Ababa, local bazaars

5. **Practical Information**
• **Capital:** Addis Ababa (2,355m altitude)
• **Currency:** Ethiopian Birr (ETB)
• **Language:** Amharic (official), English widely spoken
• **Visa:** Available on arrival for most nationalities

**What specific aspect of Ethiopia interests you most?**
I can provide detailed information about:
• Specific destinations and attractions
• Cultural practices and traditions
• Language learning and communication
• Food and dining recommendations
• Travel planning and logistics
• Historical and cultural context''';
    }
    
    return '';
  }

  /// Check if API is configured
  bool get isApiConfigured => _apiKeyManager.hasWorkingApiKey;
  
  /// Check if query is related to Ethiopia
  bool _isEthiopiaRelatedQuery(String lowerQuery) {
    final ethiopiaKeywords = [
      'ethiopia', 'ethiopian', 'amharic', 'addis ababa', 'lalibela', 'axum', 'gondar',
      'harar', 'bahir dar', 'simien', 'danakil', 'bale', 'omo valley', 'injera',
      'coffee', 'buna', 'selam', 'tena yistilign', 'meskel', 'timkat', 'genna',
      'fasika', 'enkuatash', 'irreecha', 'tej', 'tella', 'berbere', 'doro wat',
      'kitfo', 'tibs', 'shiro', 'gursha', 'geez', 'fidel', 'orthodox', 'orthodox christian',
      'university', 'museum', 'national park', 'unesco', 'world heritage', 'lucy',
      'dinkinesh', 'ras dashen', 'gelada', 'walia ibex', 'ethiopian wolf', 'mountain nyala',
      'tigray', 'amhara', 'oromo', 'somali', 'afar', 'gurage', 'sidama', 'welayta',
      'hadiya', 'gamo', 'gofa', 'konso', 'mursi', 'hamar', 'karo', 'dassanech',
      'travel', 'tourism', 'visit', 'place', 'culture', 'history', 'language', 'food',
      'restaurant', 'hotel', 'accommodation', 'transportation', 'flight', 'bus',
      'taxi', 'car rental', 'visa', 'passport', 'currency', 'birr', 'etb',
      'weather', 'climate', 'season', 'rainy', 'dry', 'altitude', 'mountain',
      'valley', 'lake', 'river', 'waterfall', 'desert', 'forest', 'savanna'
    ];
    
    return ethiopiaKeywords.any((keyword) => lowerQuery.contains(keyword));
  }
  
  /// Get specific response for Addis Ababa
  String _getAddisAbabaResponse() {
    return '''**Addis Ababa - The Capital of Ethiopia** 🇪🇹

Addis Ababa is the vibrant capital and largest city of Ethiopia, often called the "**New Flower**" — a bustling metropolis that serves as the political, economic, and cultural heart of the country. Here's a comprehensive guide to this remarkable city:

1. **City Overview**
• **Population:** Over 5.2 million people (2024)
• **Altitude:** 2,355 meters (7,726 feet) above sea level
• **Climate:** Pleasant year-round due to high altitude
• **Founded:** 1886 by Emperor Menelik II
• **Meaning:** "New Flower" in Amharic

2. **Major Attractions**
• **National Museum:** Home to Lucy (Dinkinesh), the 3.2 million-year-old hominid fossil
• **Holy Trinity Cathedral:** Final resting place of Emperor Haile Selassie
• **Mercato:** Africa's largest open-air market with endless shopping
• **Entoto Mountains:** Panoramic city views and historic churches
• **Unity Park:** Presidential palace gardens (opened 2019)

3. **Cultural Highlights**
• **Ethnological Museum:** Comprehensive Ethiopian culture and history
• **Red Terror Martyrs Memorial:** Important historical site
• **St. George's Cathedral:** Beautiful Orthodox church
• **Addis Ababa University:** Premier educational institution

4. **Food and Dining**
• **Yod Abyssinia Cultural Restaurant:** Traditional Ethiopian cuisine with cultural shows
• **Habesha Restaurant:** Authentic local dishes
• **Lucy Restaurant:** Named after the famous fossil
• **Tomoca Coffee:** Historic coffee shop since 1953

5. **Transportation**
• **Bole International Airport:** Main gateway to Ethiopia
• **Addis Light Rail:** First in sub-Saharan Africa
• **Blue-white taxis:** Traditional taxi system
• **Ride apps:** RIDE, ZayRide for modern transportation

6. **Shopping and Markets**
• **Mercato:** Everything from spices to electronics
• **Bole Road:** Modern shopping centers
• **Piazza:** Traditional shopping district
• **Shero Meda:** Textile and clothing market

7. **Nightlife and Entertainment**
• **Jazz clubs:** Vibrant music scene
• **Cultural restaurants:** Traditional music and dance
• **Bars and cafes:** Modern and traditional options
• **Cinemas:** International and local films

8. **Practical Information**
• **Best time to visit:** October to March (dry season)
• **Currency:** Ethiopian Birr (ETB)
• **Language:** Amharic (official), English widely spoken
• **Safety:** Generally safe, watch for pickpockets in crowded areas

**What else would you like to know about Addis Ababa?**
I can provide detailed information about:
• Specific attractions and activities
• Restaurant recommendations
• Transportation options
• Shopping and markets
• Cultural experiences
• Practical travel tips''';
  }
}

