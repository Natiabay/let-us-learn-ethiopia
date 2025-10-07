import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/chat/models/chat_message.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onSpeak;
  final VoidCallback? onRetry;

  const ChatMessageWidget({
    super.key,
    required this.message,
    this.onSpeak,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isUser 
            ? MainAxisAlignment.end 
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            _buildAvatar(context),
            const SizedBox(width: 12),
          ],
          
          Flexible(
            child: _buildMessageBubble(context),
          ),
          
          if (message.isUser) ...[
            const SizedBox(width: 12),
            _buildUserAvatar(context),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
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
        size: 20,
      ),
    );
  }

  Widget _buildUserAvatar(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.person_rounded,
        color: AppColors.textOnSecondary,
        size: 20,
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      child: Column(
        crossAxisAlignment: message.isUser 
            ? CrossAxisAlignment.end 
            : CrossAxisAlignment.start,
        children: [
          // Message Bubble
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: message.isUser 
                  ? AppColors.primary 
                  : AppColors.surface,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(message.isUser ? 20 : 4),
                bottomRight: Radius.circular(message.isUser ? 4 : 20),
              ),
              border: message.error 
                  ? Border.all(color: AppColors.error, width: 1)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _buildMessageContent(context),
          ),
          
          const SizedBox(height: 4),
          
          // Message Info
          _buildMessageInfo(context),
        ],
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    if (message.isVoiceMessage) {
      return _buildVoiceMessage(context);
    }

    if (message.error) {
      return _buildErrorMessage(context);
    }

    return _buildTextMessage(context);
  }

  Widget _buildTextMessage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Message Text
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: message.isUser 
                  ? AppColors.textOnPrimary 
                  : AppColors.textPrimary,
              height: 1.4,
            ),
            children: _parseMarkdown(message.text, context),
          ),
        ),
        
        // Location info
        if (message.location != null) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: (message.isUser ? AppColors.textOnPrimary : AppColors.primary)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 12,
                  color: message.isUser 
                      ? AppColors.textOnPrimary 
                      : AppColors.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  message.location!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: message.isUser 
                        ? AppColors.textOnPrimary 
                        : AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildVoiceMessage(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.mic_rounded,
          size: 16,
          color: message.isUser 
              ? AppColors.textOnPrimary 
              : AppColors.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message.text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: message.isUser 
                  ? AppColors.textOnPrimary 
                  : AppColors.textPrimary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error_outline_rounded,
          size: 16,
          color: AppColors.error,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message.text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.error,
            ),
          ),
        ),
        if (onRetry != null) ...[
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onRetry,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.refresh_rounded,
                size: 16,
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMessageInfo(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Timestamp
        Text(
          _formatTime(message.timestamp),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            fontSize: 11,
          ),
        ),
        
        // Voice message indicator
        if (message.isVoiceMessage) ...[
          const SizedBox(width: 4),
          Icon(
            Icons.mic_rounded,
            size: 12,
            color: AppColors.textSecondary,
          ),
        ],
        
        // Speak button for AI messages
        if (!message.isUser && !message.error && onSpeak != null) ...[
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onSpeak,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.volume_up_rounded,
                size: 12,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ],
    );
  }

  List<TextSpan> _parseMarkdown(String text, BuildContext context) {
    final document = md.Document();
    final nodes = document.parse(text);
    final spans = <TextSpan>[];

    for (final node in nodes) {
      if (node is md.Text) {
        spans.add(TextSpan(text: node.text));
      } else if (node is md.Element) {
        switch (node.tag) {
          case 'strong':
          case 'b':
            spans.add(TextSpan(
              text: node.textContent,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ));
            break;
          case 'em':
          case 'i':
            spans.add(TextSpan(
              text: node.textContent,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ));
            break;
          case 'code':
            spans.add(TextSpan(
              text: node.textContent,
              style: TextStyle(
                fontFamily: 'monospace',
                backgroundColor: AppColors.grey200,
                color: AppColors.primary,
              ),
            ));
            break;
          default:
            spans.add(TextSpan(text: node.textContent));
        }
      }
    }

    return spans;
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }
}
