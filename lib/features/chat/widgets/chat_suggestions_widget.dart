import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/chat/models/chat_message.dart';

class ChatSuggestionsWidget extends StatelessWidget {
  final List<ChatSuggestion> suggestions;
  final Function(ChatSuggestion) onSuggestionTap;

  const ChatSuggestionsWidget({
    super.key,
    required this.suggestions,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                size: 16,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 8),
              Text(
                'Suggestions',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                return Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: 12),
                  child: _buildSuggestion(suggestion, context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestion(ChatSuggestion suggestion, BuildContext context) {
    return GestureDetector(
      onTap: () => onSuggestionTap(suggestion),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getSuggestionGradient(suggestion.type),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _getSuggestionColor(suggestion.type).withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  suggestion.icon,
                  style: const TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: AppColors.textOnPrimary,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              suggestion.title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Flexible(
              child: Text(
                suggestion.subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textOnPrimary.withValues(alpha: 0.8),
                  fontSize: 10,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.3, end: 0);
  }

  List<Color> _getSuggestionGradient(SuggestionType type) {
    switch (type) {
      case SuggestionType.food:
        return [AppColors.success, AppColors.success.withValues(alpha: 0.8)];
      case SuggestionType.culture:
        return [AppColors.secondary, AppColors.secondary.withValues(alpha: 0.8)];
      case SuggestionType.attraction:
        return [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)];
      case SuggestionType.emergency:
        return [AppColors.error, AppColors.error.withValues(alpha: 0.8)];
      case SuggestionType.language:
        return [AppColors.accent, AppColors.accent.withValues(alpha: 0.8)];
      case SuggestionType.transport:
        return [AppColors.info, AppColors.info.withValues(alpha: 0.8)];
      default:
        return [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)];
    }
  }

  Color _getSuggestionColor(SuggestionType type) {
    switch (type) {
      case SuggestionType.food:
        return AppColors.success;
      case SuggestionType.culture:
        return AppColors.secondary;
      case SuggestionType.attraction:
        return AppColors.primary;
      case SuggestionType.emergency:
        return AppColors.error;
      case SuggestionType.language:
        return AppColors.accent;
      case SuggestionType.transport:
        return AppColors.info;
      default:
        return AppColors.primary;
    }
  }
}

