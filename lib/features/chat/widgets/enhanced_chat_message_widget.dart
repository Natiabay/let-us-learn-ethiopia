import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/chat/models/chat_message.dart';

class EnhancedChatMessageWidget extends StatefulWidget {
  final ChatMessage message;
  final VoidCallback? onSpeak;
  final VoidCallback? onRetry;
  final VoidCallback? onCopy;

  const EnhancedChatMessageWidget({
    super.key,
    required this.message,
    this.onSpeak,
    this.onRetry,
    this.onCopy,
  });

  @override
  State<EnhancedChatMessageWidget> createState() => _EnhancedChatMessageWidgetState();
}

class _EnhancedChatMessageWidgetState extends State<EnhancedChatMessageWidget>
    with TickerProviderStateMixin {
  late AnimationController _typingController;
  late AnimationController _fadeController;
  bool _showCopyButton = false;

  @override
  void initState() {
    super.initState();
    _typingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    if (!widget.message.isUser) {
      _fadeController.forward();
    }
  }

  @override
  void dispose() {
    _typingController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: widget.message.isUser 
            ? MainAxisAlignment.end 
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!widget.message.isUser) ...[
            _buildAIAvatar(context),
            const SizedBox(width: 12),
          ],
          
          Flexible(
            child: _buildMessageBubble(context),
          ),
          
          if (widget.message.isUser) ...[
            const SizedBox(width: 12),
            _buildUserAvatar(context),
          ],
        ],
      ),
    );
  }

  Widget _buildAIAvatar(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.smart_toy_rounded,
        color: Colors.white,
        size: 18,
      ),
    );
  }

  Widget _buildUserAvatar(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.person_rounded,
        color: Colors.white,
        size: 18,
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _showCopyButton = true),
      onExit: (_) => setState(() => _showCopyButton = false),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          minWidth: 200,
        ),
        child: Column(
          crossAxisAlignment: widget.message.isUser 
              ? CrossAxisAlignment.end 
              : CrossAxisAlignment.start,
          children: [
            // Message Bubble with ChatGPT-like styling
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: widget.message.isUser 
                    ? AppColors.primary 
                    : AppColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(widget.message.isUser ? 18 : 4),
                  bottomRight: Radius.circular(widget.message.isUser ? 4 : 18),
                ),
                border: widget.message.error 
                    ? Border.all(color: AppColors.error, width: 1)
                    : Border.all(
                        color: widget.message.isUser 
                            ? AppColors.primary.withValues(alpha: 0.2)
                            : AppColors.grey200,
                        width: 1,
                      ),
                boxShadow: [
                  BoxShadow(
                    color: widget.message.isUser 
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : AppColors.shadowLight,
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: _buildMessageContent(context),
            ),
            
            const SizedBox(height: 6),
            
            // Message Actions (Copy, Speak, Retry)
            _buildMessageActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    if (widget.message.isVoiceMessage) {
      return _buildVoiceMessage(context);
    }

    if (widget.message.error) {
      return _buildErrorMessage(context);
    }

    return _buildTextMessage(context);
  }

  Widget _buildTextMessage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Enhanced text rendering with better formatting
        SelectableText.rich(
          TextSpan(
            children: _parseEnhancedMarkdown(widget.message.text, context),
          ),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: widget.message.isUser 
                ? Colors.white 
                : AppColors.textPrimary,
            height: 1.6,
            fontSize: 15,
          ),
        ),
        
        // Location info with better styling
        if (widget.message.location != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: (widget.message.isUser ? Colors.white : AppColors.primary)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: (widget.message.isUser ? Colors.white : AppColors.primary)
                    .withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 14,
                  color: widget.message.isUser 
                      ? Colors.white 
                      : AppColors.primary,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    widget.message.location ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: widget.message.isUser 
                          ? Colors.white 
                          : AppColors.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: (widget.message.isUser ? Colors.white : AppColors.primary)
                  .withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.mic_rounded,
              size: 16,
              color: widget.message.isUser 
                  ? Colors.white 
                  : AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.message.text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: widget.message.isUser 
                    ? Colors.white 
                    : AppColors.textPrimary,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.error_outline_rounded,
              size: 16,
              color: AppColors.error,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.message.text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.error,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (widget.onRetry != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: widget.onRetry,
              child: Container(
                padding: const EdgeInsets.all(6),
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
      ),
    );
  }

  Widget _buildMessageActions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Timestamp
        Text(
          _formatTime(widget.message.timestamp),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Copy button (appears on hover for AI messages)
        if (!widget.message.isUser && _showCopyButton && widget.onCopy != null) ...[
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: widget.message.text));
              widget.onCopy?.call();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Message copied to clipboard'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.grey200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.copy_rounded,
                size: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
        
        // Voice message indicator
        if (widget.message.isVoiceMessage) ...[
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.grey200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.mic_rounded,
              size: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 4),
        ],
        
        // Speak button for AI messages
        if (!widget.message.isUser && !widget.message.error && widget.onSpeak != null) ...[
          GestureDetector(
            onTap: widget.onSpeak,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
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

  List<TextSpan> _parseEnhancedMarkdown(String text, BuildContext context) {
    final spans = <TextSpan>[];
    final lines = text.split('\n');
    
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      
      // Handle headers
      if (line.startsWith('#')) {
        final level = line.split(' ')[0].length;
        final content = line.substring(level).trim();
        spans.add(TextSpan(
          text: content,
          style: TextStyle(
            fontSize: level == 1 ? 18 : level == 2 ? 16 : 15,
            fontWeight: FontWeight.bold,
            color: widget.message.isUser ? Colors.white : AppColors.primary,
          ),
        ));
        if (i < lines.length - 1) spans.add(const TextSpan(text: '\n'));
        continue;
      }
      
      // Handle bold text
      if (line.contains('**')) {
        final parts = line.split('**');
        for (int j = 0; j < parts.length; j++) {
          if (j % 2 == 1) {
            spans.add(TextSpan(
              text: parts[j],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ));
          } else {
            spans.add(TextSpan(text: parts[j]));
          }
        }
        if (i < lines.length - 1) spans.add(const TextSpan(text: '\n'));
        continue;
      }
      
      // Handle italic text
      if (line.contains('*') && !line.contains('**')) {
        final parts = line.split('*');
        for (int j = 0; j < parts.length; j++) {
          if (j % 2 == 1) {
            spans.add(TextSpan(
              text: parts[j],
              style: const TextStyle(fontStyle: FontStyle.italic),
            ));
          } else {
            spans.add(TextSpan(text: parts[j]));
          }
        }
        if (i < lines.length - 1) spans.add(const TextSpan(text: '\n'));
        continue;
      }
      
      // Handle code blocks
      if (line.startsWith('```')) {
        spans.add(TextSpan(
          text: line.substring(3),
          style: TextStyle(
            fontFamily: 'monospace',
            backgroundColor: widget.message.isUser 
                ? Colors.white.withValues(alpha: 0.2)
                : AppColors.grey200,
            color: widget.message.isUser 
                ? Colors.white 
                : AppColors.primary,
          ),
        ));
        if (i < lines.length - 1) spans.add(const TextSpan(text: '\n'));
        continue;
      }
      
      // Handle inline code
      if (line.contains('`')) {
        final parts = line.split('`');
        for (int j = 0; j < parts.length; j++) {
          if (j % 2 == 1) {
            spans.add(TextSpan(
              text: parts[j],
              style: TextStyle(
                fontFamily: 'monospace',
                backgroundColor: widget.message.isUser 
                    ? Colors.white.withValues(alpha: 0.2)
                    : AppColors.grey200,
                color: widget.message.isUser 
                    ? Colors.white 
                    : AppColors.primary,
              ),
            ));
          } else {
            spans.add(TextSpan(text: parts[j]));
          }
        }
        if (i < lines.length - 1) spans.add(const TextSpan(text: '\n'));
        continue;
      }
      
      // Handle bullet points
      if (line.startsWith('•') || line.startsWith('-')) {
        spans.add(TextSpan(
          text: '• ${line.substring(1).trim()}',
          style: TextStyle(
            color: widget.message.isUser ? Colors.white : AppColors.textPrimary,
          ),
        ));
        if (i < lines.length - 1) spans.add(const TextSpan(text: '\n'));
        continue;
      }
      
      // Regular text
      spans.add(TextSpan(text: line));
      if (i < lines.length - 1) spans.add(const TextSpan(text: '\n'));
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
