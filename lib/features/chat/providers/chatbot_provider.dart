import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/features/chat/models/chat_message.dart';
import 'package:tourist_assistive_app/features/chat/services/ai_chatbot_service.dart';
import 'package:tourist_assistive_app/features/chat/services/rag_chatbot_service.dart';
import 'package:tourist_assistive_app/features/chat/services/enhanced_professional_rag_service.dart';
import 'package:tourist_assistive_app/features/chat/services/voice_service.dart';
import 'package:tourist_assistive_app/features/language/services/google_voice_service.dart';

// Chat State Provider
final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier(ref);
});

// Voice Service Provider (Legacy - using Flutter TTS)
final voiceServiceProvider = Provider<VoiceService>((ref) {
  return VoiceService();
});

// Google Voice Service Provider (New - using Google Cloud APIs)
final googleVoiceServiceProvider = Provider<GoogleVoiceService>((ref) {
  final service = GoogleVoiceService();
  ref.onDispose(() => service.dispose());
  return service;
});

// AI Chatbot Service Provider
final aiChatbotServiceProvider = Provider<AIChatbotService>((ref) {
  return AIChatbotService();
});

// RAG Chatbot Service Provider (Enhanced with OpenAI + Knowledge Base)
final ragChatbotServiceProvider = Provider<RAGChatbotService>((ref) {
  return RAGChatbotService();
});

// Enhanced Professional RAG Service Provider (LLM + LangGraph/LangChain implementation)
final enhancedProfessionalRagServiceProvider = Provider<EnhancedProfessionalRAGService>((ref) {
  return EnhancedProfessionalRAGService();
});

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool isTyping;
  final String? currentLocation;
  final List<ChatSuggestion> suggestions;
  final List<QuickReply> quickReplies;
  final bool isVoiceMode;
  final bool isRecording;
  final String? error;
  final ChatSession? currentSession;

  ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.isTyping = false,
    this.currentLocation,
    this.suggestions = const [],
    this.quickReplies = const [],
    this.isVoiceMode = false,
    this.isRecording = false,
    this.error,
    this.currentSession,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? isTyping,
    String? currentLocation,
    List<ChatSuggestion>? suggestions,
    List<QuickReply>? quickReplies,
    bool? isVoiceMode,
    bool? isRecording,
    String? error,
    ChatSession? currentSession,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isTyping: isTyping ?? this.isTyping,
      currentLocation: currentLocation ?? this.currentLocation,
      suggestions: suggestions ?? this.suggestions,
      quickReplies: quickReplies ?? this.quickReplies,
      isVoiceMode: isVoiceMode ?? this.isVoiceMode,
      isRecording: isRecording ?? this.isRecording,
      error: error ?? this.error,
      currentSession: currentSession ?? this.currentSession,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final Ref ref;
  final AIChatbotService _aiService;
  final RAGChatbotService _ragService;
  final EnhancedProfessionalRAGService _enhancedProfessionalRagService;
  final VoiceService _voiceService;

  ChatNotifier(this.ref) 
      : _aiService = ref.read(aiChatbotServiceProvider),
        _ragService = ref.read(ragChatbotServiceProvider),
        _enhancedProfessionalRagService = ref.read(enhancedProfessionalRagServiceProvider),
        _voiceService = ref.read(voiceServiceProvider),
        super(ChatState()) {
    _initializeChat();
  }

  void _initializeChat() {
    // Add welcome message
    final welcomeMessage = ChatMessage(
      id: 'welcome',
      text: 'Selam! I\'m Selam, your AI guide to Ethiopia! 🇪🇹\n\nI\'m here to help you discover the beauty of Ethiopia - from the ancient rock-hewn churches of Lalibela to the bustling markets of Addis Ababa. Ask me anything about Ethiopian culture, food, places to visit, or even learn some Amharic phrases!\n\nWhat would you like to know about Ethiopia?',
      isUser: false,
      timestamp: DateTime.now(),
      type: MessageType.text,
    );

    // Add quick replies
    final quickReplies = [
      QuickReply(
        id: 'food',
        text: '🍽️ Best Local Food',
        icon: '🍽️',
        type: QuickReplyType.text,
      ),
      QuickReply(
        id: 'places',
        text: '📍 Places to Visit',
        icon: '📍',
        type: QuickReplyType.text,
      ),
      QuickReply(
        id: 'language',
        text: '🗣️ Learn Amharic',
        icon: '🗣️',
        type: QuickReplyType.text,
      ),
      QuickReply(
        id: 'culture',
        text: '🎭 Cultural Tips',
        icon: '🎭',
        type: QuickReplyType.text,
      ),
    ];

    // Add suggestions
    final suggestions = [
      ChatSuggestion(
        id: 'coffee',
        title: 'Ethiopian Coffee Ceremony',
        subtitle: 'Experience the traditional coffee ritual',
        action: 'Tell me about coffee ceremonies',
        icon: '☕',
        type: SuggestionType.culture,
      ),
      ChatSuggestion(
        id: 'injera',
        title: 'Try Injera',
        subtitle: 'Ethiopia\'s famous sourdough bread',
        action: 'Where can I try injera?',
        icon: '🍽️',
        type: SuggestionType.food,
      ),
      ChatSuggestion(
        id: 'lalibela',
        title: 'Visit Lalibela',
        subtitle: 'Ancient rock-hewn churches',
        action: 'Tell me about Lalibela',
        icon: '⛪',
        type: SuggestionType.attraction,
      ),
    ];

    state = state.copyWith(
      messages: [welcomeMessage],
      quickReplies: quickReplies,
      suggestions: suggestions,
    );
  }

  Future<void> sendMessage(String text, {bool isVoiceMessage = false}) async {
    if (text.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
      isVoiceMessage: isVoiceMessage,
      location: state.currentLocation,
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      isTyping: true,
    );

    try {
      // Use RAG Chatbot Service with focused templates
      print('🔧 RAG CHATBOT: Using focused template system...');
      print('📍 User query: "$text"');
      print('🎯 RAG CHATBOT: Using focused topic-specific responses');
      
      final aiResponse = await _ragService.sendMessage(
        text,
        userLocation: state.currentLocation,
        isVoiceMessage: isVoiceMessage,
      );
      
      print('✅ RAG CHATBOT: Generated ${aiResponse.text.length} character response');

      // Add AI response
      print('CHAT PROVIDER: Adding AI response to state');
      print('CHAT PROVIDER: Response text: ${aiResponse.text.substring(0, aiResponse.text.length > 100 ? 100 : aiResponse.text.length)}...');
      
      // Force state update with proper message creation
      final updatedMessages = List<ChatMessage>.from(state.messages)..add(aiResponse);
      
      state = state.copyWith(
        messages: updatedMessages,
        isLoading: false,
        isTyping: false,
        error: null,
      );
      
      print('CHAT PROVIDER: State updated with ${state.messages.length} messages');
      print('CHAT PROVIDER: Last message: ${state.messages.last.text.substring(0, state.messages.last.text.length > 50 ? 50 : state.messages.last.text.length)}...');

      // Update suggestions based on conversation
      await _updateSuggestions(text);

    } catch (e) {
      // Add helpful error message instead of generic error
      final errorMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: '''I'm here to help! While I'm working on my connection, I can still assist you with information about Ethiopia.

Here are some topics I can help with:

🏛️ **Culture & History** - Ethiopian traditions, coffee ceremonies, historical sites
🍽️ **Food & Dining** - Amazing Ethiopian cuisine and dining etiquette  
📍 **Places to Visit** - Must-see destinations and travel recommendations
🗣️ **Language** - Basic Amharic phrases and pronunciation
🎯 **Travel Tips** - Practical advice for your Ethiopian journey

Try asking me about:
• "Tell me about coffee ceremonies"
• "What's the best local food?"
• "Where should I visit in Ethiopia?"
• "How do I learn Amharic?"
• "What cultural tips should I know?"

What would you like to know more about?''',
        isUser: false,
        timestamp: DateTime.now(),
        error: false, // Don't mark as error to avoid red styling
        type: MessageType.text,
      );

      state = state.copyWith(
        messages: [...state.messages, errorMessage],
        isLoading: false,
        isTyping: false,
        error: null, // Clear error state
      );
    }
  }

  Future<void> sendQuickReply(QuickReply quickReply) async {
    await sendMessage(quickReply.text);
  }

  Future<void> sendSuggestion(ChatSuggestion suggestion) async {
    await sendMessage(suggestion.action);
  }

  Future<void> startVoiceRecording() async {
    if (state.isRecording) return;

    state = state.copyWith(isRecording: true);

    try {
      await _voiceService.startListening(
        onResult: (text) {
          if (text.isNotEmpty) {
            sendMessage(text, isVoiceMessage: true);
          }
        },
        onError: (error) {
          state = state.copyWith(
            isRecording: false,
            error: 'Voice recognition error: $error',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isRecording: false,
        error: 'Failed to start voice recording: $e',
      );
    }
  }

  Future<void> stopVoiceRecording() async {
    if (!state.isRecording) return;

    try {
      await _voiceService.stopListening();
      state = state.copyWith(isRecording: false);
    } catch (e) {
      state = state.copyWith(
        isRecording: false,
        error: 'Failed to stop voice recording: $e',
      );
    }
  }

  Future<void> speakMessage(ChatMessage message) async {
    if (message.isUser) return;

    try {
      await _voiceService.speak(message.text);
    } catch (e) {
      state = state.copyWith(error: 'Failed to speak message: $e');
    }
  }

  void toggleVoiceMode() {
    state = state.copyWith(isVoiceMode: !state.isVoiceMode);
  }

  void setLocation(String location) {
    state = state.copyWith(currentLocation: location);
    
    // Update suggestions based on location
    _updateLocationBasedSuggestions(location);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearChat() {
    state = state.copyWith(
      messages: [],
      suggestions: [],
      quickReplies: [],
      error: null,
    );
    _initializeChat();
  }

  Future<void> _updateSuggestions(String userMessage) async {
    try {
      final suggestions = _aiService.getContextualSuggestions(
        location: state.currentLocation,
        time: DateTime.now(),
        userInterests: _extractInterests(userMessage),
      );

      final chatSuggestions = suggestions.map((suggestion) => ChatSuggestion(
        id: suggestion.title.toLowerCase().replaceAll(' ', '_'),
        title: suggestion.title,
        subtitle: suggestion.subtitle,
        action: suggestion.action,
        icon: suggestion.icon,
      )).toList();

      state = state.copyWith(suggestions: chatSuggestions);
    } catch (e) {
      // Ignore suggestion update errors
    }
  }

  void _updateLocationBasedSuggestions(String location) {
    // Add location-specific suggestions
    final locationSuggestions = [
      ChatSuggestion(
        id: 'local_food',
        title: 'Local Food in $location',
        subtitle: 'Discover authentic local cuisine',
        action: 'What\'s the best food in $location?',
        icon: '🍽️',
        type: SuggestionType.food,
      ),
      ChatSuggestion(
        id: 'local_attractions',
        title: 'Attractions in $location',
        subtitle: 'Must-see places nearby',
        action: 'What should I visit in $location?',
        icon: '📍',
        type: SuggestionType.attraction,
      ),
      ChatSuggestion(
        id: 'local_transport',
        title: 'Getting Around $location',
        subtitle: 'Transportation options',
        action: 'How do I get around $location?',
        icon: '🚌',
        type: SuggestionType.transport,
      ),
    ];

    state = state.copyWith(suggestions: locationSuggestions);
  }

  List<String> _extractInterests(String message) {
    final interests = <String>[];
    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('food') || lowerMessage.contains('eat') || lowerMessage.contains('restaurant')) {
      interests.add('food');
    }
    if (lowerMessage.contains('culture') || lowerMessage.contains('tradition') || lowerMessage.contains('custom')) {
      interests.add('culture');
    }
    if (lowerMessage.contains('history') || lowerMessage.contains('ancient') || lowerMessage.contains('historical')) {
      interests.add('history');
    }
    if (lowerMessage.contains('language') || lowerMessage.contains('amharic') || lowerMessage.contains('learn')) {
      interests.add('language');
    }
    if (lowerMessage.contains('place') || lowerMessage.contains('visit') || lowerMessage.contains('attraction')) {
      interests.add('attractions');
    }

    return interests;
  }

  // Get conversation summary
  String getConversationSummary() {
    return _aiService.getConversationSummary();
  }

  // Check if API is configured
  bool get isApiConfigured => _aiService.isApiKeyConfigured;
}
