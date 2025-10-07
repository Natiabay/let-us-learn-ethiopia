import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

class FeaturedLocationCard extends StatefulWidget {
  final int index;
  final VoidCallback onTap;

  const FeaturedLocationCard({
    super.key,
    required this.index,
    required this.onTap,
  });

  @override
  State<FeaturedLocationCard> createState() => _FeaturedLocationCardState();
}

class _FeaturedLocationCardState extends State<FeaturedLocationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isPressed = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
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
      begin: 4.0,
      end: 12.0,
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

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final location = _getFeaturedLocation(widget.index);
    
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
              width: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: _isPressed ? 0.2 : 0.1),
                    blurRadius: _elevationAnimation.value,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Background Image
                    Container(
                      height: 200,
                      child: location['imageUrl'] != null
                          ? Image.asset(
                              location['imageUrl'] as String,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        location['color'] as Color,
                                        (location['color'] as Color).withValues(alpha: 0.7),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      location['icon'] as IconData,
                                      size: 60,
                                      color: AppColors.white.withValues(alpha: 0.8),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              height: 200,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    location['color'] as Color,
                                    (location['color'] as Color).withValues(alpha: 0.7),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  location['icon'] as IconData,
                                  size: 60,
                                  color: AppColors.white.withValues(alpha: 0.8),
                                ),
                              ),
                            ),
                    ),
                    
                    // Gradient Overlay
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    
                    // Content
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              location['name'] as String,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              location['description'] as String,
                              style: TextStyle(
                                color: AppColors.white.withValues(alpha: 0.9),
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColors.secondary,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  location['rating'] as String,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    location['type'] as String,
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Heart Icon
                    Positioned(
                      top: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: _toggleFavorite,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: _isFavorite ? Colors.red : AppColors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Map<String, dynamic> _getFeaturedLocation(int index) {
    final locations = [
      {
        'name': 'Lalibela Rock Churches',
        'description': 'Ancient rock-hewn churches dating back to the 12th century',
        'rating': '4.8',
        'type': 'Historical',
        'icon': Icons.church,
        'color': AppColors.accent,
        'imageUrl': 'assets/images/Lalibela.png',
      },
      {
        'name': 'Axum Obelisks',
        'description': 'Ancient kingdom with legendary obelisks and Queen of Sheba',
        'rating': '4.7',
        'type': 'Historical',
        'icon': Icons.landscape,
        'color': AppColors.success,
        'imageUrl': 'assets/images/Axum.png',
      },
      {
        'name': 'Gondar Castles',
        'description': 'Royal castles and palaces from the 17th century',
        'rating': '4.6',
        'type': 'Historical',
        'icon': Icons.castle,
        'color': AppColors.warning,
        'imageUrl': 'assets/images/Fassil Gimb.png',
      },
      {
        'name': 'Harar Jugol',
        'description': 'Walled city with 99 mosques and unique architecture',
        'rating': '4.6',
        'type': 'Cultural',
        'icon': Icons.mosque,
        'color': AppColors.primary,
        'imageUrl': 'assets/images/Jugol.png',
      },
    ];
    
    return locations[index % locations.length];
  }
}