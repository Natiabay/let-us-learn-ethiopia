import 'package:uuid/uuid.dart';

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final bool isVoiceMessage;
  final String? location;
  final String? language;
  final bool error;
  final MessageType type;
  final Map<String, dynamic>? metadata;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isVoiceMessage = false,
    this.location,
    this.language,
    this.error = false,
    this.type = MessageType.text,
    this.metadata,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] ?? const Uuid().v4(),
      text: json['text'] ?? '',
      isUser: json['isUser'] ?? false,
      timestamp: DateTime.parse(json['timestamp']),
      isVoiceMessage: json['isVoiceMessage'] ?? false,
      location: json['location'],
      language: json['language'],
      error: json['error'] ?? false,
      type: MessageType.values.firstWhere(
        (e) => e.toString() == 'MessageType.${json['type']}',
        orElse: () => MessageType.text,
      ),
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
      'isVoiceMessage': isVoiceMessage,
      'location': location,
      'language': language,
      'error': error,
      'type': type.toString().split('.').last,
      'metadata': metadata,
    };
  }

  ChatMessage copyWith({
    String? id,
    String? text,
    bool? isUser,
    DateTime? timestamp,
    bool? isVoiceMessage,
    String? location,
    String? language,
    bool? error,
    MessageType? type,
    Map<String, dynamic>? metadata,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      isVoiceMessage: isVoiceMessage ?? this.isVoiceMessage,
      location: location ?? this.location,
      language: language ?? this.language,
      error: error ?? this.error,
      type: type ?? this.type,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatMessage && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ChatMessage(id: $id, text: $text, isUser: $isUser, timestamp: $timestamp)';
  }
}

enum MessageType {
  text,
  voice,
  image,
  location,
  quickReply,
  suggestion,
  error,
}

class ChatSession {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime? lastMessageAt;
  final List<ChatMessage> messages;
  final String? userLocation;
  final List<String> topics;

  ChatSession({
    required this.id,
    required this.title,
    required this.createdAt,
    this.lastMessageAt,
    required this.messages,
    this.userLocation,
    this.topics = const [],
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id'] ?? const Uuid().v4(),
      title: json['title'] ?? 'New Chat',
      createdAt: DateTime.parse(json['createdAt']),
      lastMessageAt: json['lastMessageAt'] != null 
          ? DateTime.parse(json['lastMessageAt']) 
          : null,
      messages: (json['messages'] as List?)
          ?.map((msg) => ChatMessage.fromJson(msg))
          .toList() ?? [],
      userLocation: json['userLocation'],
      topics: List<String>.from(json['topics'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'lastMessageAt': lastMessageAt?.toIso8601String(),
      'messages': messages.map((msg) => msg.toJson()).toList(),
      'userLocation': userLocation,
      'topics': topics,
    };
  }

  ChatSession copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? lastMessageAt,
    List<ChatMessage>? messages,
    String? userLocation,
    List<String>? topics,
  }) {
    return ChatSession(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      messages: messages ?? this.messages,
      userLocation: userLocation ?? this.userLocation,
      topics: topics ?? this.topics,
    );
  }
}

class QuickReply {
  final String id;
  final String text;
  final String? icon;
  final QuickReplyType type;
  final Map<String, dynamic>? data;

  QuickReply({
    required this.id,
    required this.text,
    this.icon,
    this.type = QuickReplyType.text,
    this.data,
  });

  factory QuickReply.fromJson(Map<String, dynamic> json) {
    return QuickReply(
      id: json['id'] ?? const Uuid().v4(),
      text: json['text'] ?? '',
      icon: json['icon'],
      type: QuickReplyType.values.firstWhere(
        (e) => e.toString() == 'QuickReplyType.${json['type']}',
        orElse: () => QuickReplyType.text,
      ),
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'icon': icon,
      'type': type.toString().split('.').last,
      'data': data,
    };
  }
}

enum QuickReplyType {
  text,
  location,
  voice,
  action,
}

class ChatSuggestion {
  final String id;
  final String title;
  final String subtitle;
  final String action;
  final String icon;
  final SuggestionType type;
  final Map<String, dynamic>? data;

  ChatSuggestion({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.action,
    required this.icon,
    this.type = SuggestionType.general,
    this.data,
  });

  factory ChatSuggestion.fromJson(Map<String, dynamic> json) {
    return ChatSuggestion(
      id: json['id'] ?? const Uuid().v4(),
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      action: json['action'] ?? '',
      icon: json['icon'] ?? '💡',
      type: SuggestionType.values.firstWhere(
        (e) => e.toString() == 'SuggestionType.${json['type']}',
        orElse: () => SuggestionType.general,
      ),
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'action': action,
      'icon': icon,
      'type': type.toString().split('.').last,
      'data': data,
    };
  }
}

enum SuggestionType {
  general,
  location,
  food,
  culture,
  emergency,
  language,
  transport,
  attraction,
}

