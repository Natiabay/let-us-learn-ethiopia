import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
// import 'package:markdown/markdown.dart' as md;
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/chat/models/chat_message.dart';
import 'package:tourist_assistive_app/features/chat/providers/chatbot_provider.dart';
import 'package:tourist_assistive_app/features/chat/widgets/enhanced_chat_message_widget.dart';
import 'package:tourist_assistive_app/features/chat/widgets/voice_input_widget.dart';
import 'package:tourist_assistive_app/features/chat/widgets/quick_replies_widget.dart';
import 'package:tourist_assistive_app/features/chat/widgets/chat_suggestions_widget.dart';
import 'package:tourist_assistive_app/features/chat/widgets/typing_indicator_widget.dart';

class AdvancedChatbotScreen extends ConsumerStatefulWidget {
  const AdvancedChatbotScreen({super.key});

  @override
  ConsumerState<AdvancedChatbotScreen> createState() => _AdvancedChatbotScreenState();
}

class _AdvancedChatbotScreenState extends ConsumerState<AdvancedChatbotScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _fabController;
  late AnimationController _suggestionController;
  
  bool _showSuggestions = true;
  // bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _suggestionController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _suggestionController.forward();
    
    // Listen to keyboard visibility
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _fabController.dispose();
    _suggestionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final chatNotifier = ref.read(chatProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(chatState, chatNotifier),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: _buildChatMessages(chatState),
          ),
          
          // Suggestions (when visible)
          if (_showSuggestions && chatState.suggestions.isNotEmpty)
            _buildSuggestions(chatState, chatNotifier),
          
          // Quick Replies
          if (chatState.quickReplies.isNotEmpty)
            _buildQuickReplies(chatState, chatNotifier),
          
          // Typing Indicator
          if (chatState.isTyping)
            const TypingIndicatorWidget(),
          
          // Input Area
          _buildInputArea(chatState, chatNotifier),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(chatState, chatNotifier),
    );
  }

  PreferredSizeWidget _buildAppBar(ChatState chatState, ChatNotifier chatNotifier) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back_ios_rounded),
      ),
      title: Row(
        children: [
          // AI Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.primaryGradient,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.smart_toy_rounded,
              color: AppColors.textOnPrimary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ETHIO-TOUR Assistant',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  chatState.isTyping ? 'Typing...' : 'Online',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: chatState.isTyping ? AppColors.primary : AppColors.success,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Voice Mode Toggle
        IconButton(
          onPressed: () => chatNotifier.toggleVoiceMode(),
          icon: Icon(
            chatState.isVoiceMode ? Icons.mic_rounded : Icons.mic_off_rounded,
            color: chatState.isVoiceMode ? AppColors.primary : AppColors.grey500,
          ),
        ),
        // Settings
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'clear':
                _showClearChatDialog(chatNotifier);
                break;
              case 'location':
                _showLocationDialog(chatNotifier);
                break;
              case 'settings':
                _showSettingsDialog();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'location',
              child: Row(
                children: [
                  Icon(Icons.location_on_rounded, size: 20),
                  SizedBox(width: 8),
                  Text('Set Location'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'clear',
              child: Row(
                children: [
                  Icon(Icons.clear_all_rounded, size: 20),
                  SizedBox(width: 8),
                  Text('Clear Chat'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'settings',
              child: Row(
                children: [
                  Icon(Icons.settings_rounded, size: 20),
                  SizedBox(width: 8),
                  Text('Settings'),
                ],
              ),
            ),
          ],
          child: const Icon(Icons.more_vert_rounded),
        ),
      ],
    );
  }

  Widget _buildChatMessages(ChatState chatState) {
    if (chatState.messages.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: chatState.messages.length,
      itemBuilder: (context, index) {
        final message = chatState.messages[index];
        return EnhancedChatMessageWidget(
          message: message,
          onSpeak: () => ref.read(chatProvider.notifier).speakMessage(message),
          onRetry: message.error ? () => _retryMessage(message) : null,
          onCopy: () => _copyMessage(message),
        ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.3, end: 0);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Welcome Animation
          Lottie.asset(
            'assets/animations/welcome.json',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'Welcome to Ethiopia! 🇪🇹',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          Text(
            'I\'m Selam, your AI guide. Ask me anything about Ethiopian culture, food, places to visit, or learn some Amharic phrases!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 32),
          
          // Quick Start Buttons
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildQuickStartButton(
                '🍽️ Food',
                'Best local dishes',
                () => _sendQuickMessage('What\'s the best Ethiopian food to try?'),
              ),
              _buildQuickStartButton(
                '📍 Places',
                'Must-visit locations',
                () => _sendQuickMessage('What are the must-visit places in Ethiopia?'),
              ),
              _buildQuickStartButton(
                '🗣️ Language',
                'Learn Amharic',
                () => _sendQuickMessage('Teach me some basic Amharic phrases'),
              ),
              _buildQuickStartButton(
                '🎭 Culture',
                'Cultural insights',
                () => _sendQuickMessage('Tell me about Ethiopian culture and traditions'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStartButton(String emoji, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions(ChatState chatState, ChatNotifier chatNotifier) {
    return ChatSuggestionsWidget(
      suggestions: chatState.suggestions,
      onSuggestionTap: (suggestion) {
        chatNotifier.sendSuggestion(suggestion);
        setState(() {
          _showSuggestions = false;
        });
      },
    ).animate(controller: _suggestionController)
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildQuickReplies(ChatState chatState, ChatNotifier chatNotifier) {
    return QuickRepliesWidget(
      quickReplies: chatState.quickReplies,
      onQuickReplyTap: (quickReply) {
        chatNotifier.sendQuickReply(quickReply);
      },
    );
  }

  Widget _buildInputArea(ChatState chatState, ChatNotifier chatNotifier) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.grey200, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Text Input
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.grey300),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Ask me anything about Ethiopia...',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (text) => _sendMessage(chatNotifier),
                onChanged: (text) {
                  setState(() {
                    _showSuggestions = text.isEmpty;
                  });
                },
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Send Button
          GestureDetector(
            onTap: () => _sendMessage(chatNotifier),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.primaryGradient,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.send_rounded,
                color: AppColors.textOnPrimary,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(ChatState chatState, ChatNotifier chatNotifier) {
    if (chatState.isVoiceMode) {
      return VoiceInputWidget(
        isRecording: chatState.isRecording,
        onStartRecording: () => chatNotifier.startVoiceRecording(),
        onStopRecording: () => chatNotifier.stopVoiceRecording(),
      );
    }

    return FloatingActionButton(
      heroTag: "chat_fab_unique",
      onPressed: () => chatNotifier.toggleVoiceMode(),
      backgroundColor: AppColors.secondary,
      child: const Icon(
        Icons.mic_rounded,
        color: AppColors.textOnSecondary,
      ),
    ).animate(controller: _fabController)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }

  void _sendMessage(ChatNotifier chatNotifier) {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      chatNotifier.sendMessage(text);
      _messageController.clear();
      setState(() {
        _showSuggestions = true;
      });
      _scrollToBottom();
    }
  }

  void _sendQuickMessage(String message) {
    ref.read(chatProvider.notifier).sendMessage(message);
    setState(() {
      _showSuggestions = false;
    });
    _scrollToBottom();
  }

  void _retryMessage(ChatMessage message) {
    if (message.isUser) {
      ref.read(chatProvider.notifier).sendMessage(message.text);
    }
  }

  void _copyMessage(ChatMessage message) {
    // Copy functionality is handled in the EnhancedChatMessageWidget
    // This method is called when copy button is tapped
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showClearChatDialog(ChatNotifier chatNotifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Clear Chat'),
        content: const Text('Are you sure you want to clear all messages? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              chatNotifier.clearChat();
              context.pop();
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showLocationDialog(ChatNotifier chatNotifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Set Your Location'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Help me provide better recommendations by setting your current location.'),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'City or Location',
                hintText: 'e.g., Addis Ababa, Lalibela, Gondar',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (location) {
                if (location.trim().isNotEmpty) {
                  chatNotifier.setLocation(location.trim());
                  context.pop();
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // You can implement location detection here
              context.pop();
            },
            child: const Text('Use Current Location'),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Chat Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.volume_up_rounded),
              title: const Text('Voice Responses'),
              subtitle: const Text('Enable AI voice responses'),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Implement voice response toggle
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language_rounded),
              title: const Text('Language'),
              subtitle: const Text('English'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onTap: () {
                // Implement language selection
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_rounded),
              title: const Text('Notifications'),
              subtitle: const Text('Enable chat notifications'),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Implement notification toggle
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
