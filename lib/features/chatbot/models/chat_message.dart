import 'package:flutter/material.dart';

class ChatMessage {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final MessageType type;
  final Map<String, dynamic>? metadata;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.type = MessageType.text,
    this.metadata,
  });

  ChatMessage copyWith({
    String? id,
    String? content,
    bool? isUser,
    DateTime? timestamp,
    MessageType? type,
    Map<String, dynamic>? metadata,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
      'type': type.name,
      'metadata': metadata,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      isUser: map['isUser'] ?? false,
      timestamp: DateTime.parse(map['timestamp']),
      type: MessageType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => MessageType.text,
      ),
      metadata: map['metadata'],
    );
  }
}

enum MessageType {
  text,
  image,
  location,
  suggestion,
  emergency,
  translation,
}

class ChatSuggestion {
  final String id;
  final String text;
  final String category;
  final IconData? icon;

  const ChatSuggestion({
    required this.id,
    required this.text,
    required this.category,
    this.icon,
  });
}

// Quick response suggestions
class QuickResponses {
  static const List<ChatSuggestion> suggestions = [
    ChatSuggestion(
      id: 'attractions',
      text: 'Show me top attractions',
      category: 'places',
    ),
    ChatSuggestion(
      id: 'food',
      text: 'What should I eat?',
      category: 'food',
    ),
    ChatSuggestion(
      id: 'transport',
      text: 'How do I get around?',
      category: 'transport',
    ),
    ChatSuggestion(
      id: 'safety',
      text: 'Is it safe to travel?',
      category: 'safety',
    ),
    ChatSuggestion(
      id: 'weather',
      text: 'What\'s the weather like?',
      category: 'weather',
    ),
    ChatSuggestion(
      id: 'emergency',
      text: 'Emergency numbers',
      category: 'emergency',
    ),
  ];
}
