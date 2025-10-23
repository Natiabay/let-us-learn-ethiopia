import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

/// Professional quick action card with smooth animations
/// Provides interactive feedback and consistent styling
class QuickActionCard extends StatefulWidget {
  /// The icon to display in the card
  final IconData icon;
  
  /// The main title text
  final String title;
  
  /// The subtitle or description text
  final String subtitle;
  
  /// The primary color theme for the card
  final Color color;
  
  /// Callback function when the card is tapped
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  State<QuickActionCard> createState() => _QuickActionCardState();
}

class _QuickActionCardState extends State<QuickActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _elevationAnimation = Tween<double>(
      begin: 2.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _isPressed 
                      ? [
                          widget.color.withValues(alpha: 0.3),
                          widget.color.withValues(alpha: 0.2),
                        ]
                      : [
                          AppColors.duolingoCard,
                          widget.color.withValues(alpha: 0.1),
                        ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isPressed 
                      ? widget.color.withValues(alpha: 0.6)
                      : widget.color.withValues(alpha: 0.2),
                  width: _isPressed ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withValues(alpha: _isPressed ? 0.4 : 0.15),
                    blurRadius: _elevationAnimation.value * 2,
                    offset: Offset(0, _elevationAnimation.value),
                  ),
                  BoxShadow(
                    color: AppColors.duolingoDark.withValues(alpha: 0.8),
                    blurRadius: 1,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          widget.color,
                          widget.color.withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: widget.color.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.icon,
                      color: AppColors.duolingoTextPrimary,
                      size: 20,
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.duolingoTextPrimary,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 1),
                  
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      color: AppColors.duolingoTextSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}















