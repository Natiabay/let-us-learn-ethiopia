import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/onboarding/models/onboarding_data.dart';
import 'package:tourist_assistive_app/features/onboarding/screens/onboarding_screen.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final bool isActive;
  
  const OnboardingPage({
    super.key,
    required this.data,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 40,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          // Main Icon with Animation
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: isActive ? 160 : 140,
            height: isActive ? 160 : 140,
            decoration: BoxDecoration(
              gradient: data.gradient,
              borderRadius: BorderRadius.circular(80),
              boxShadow: [
                BoxShadow(
                  color: data.color.withValues(alpha: 0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 1,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background Circle (only if no logo)
                if (data.logoPath == null)
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                // Logo or Icon
                if (data.logoPath != null)
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        data.logoPath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.white,
                            child: Icon(
                              data.image,
                              size: 60,
                              color: data.color,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                else
                  Icon(
                    data.image,
                    size: 60,
                    color: data.color,
                  ),
                // Floating Elements
                if (isActive) ...[
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: data.color.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.star_rounded,
                        size: 12,
                        color: data.color,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: data.color.withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.favorite_rounded,
                        size: 10,
                        color: data.color,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ).animate(target: isActive ? 1 : 0)
            .scale(duration: 600.ms, curve: Curves.elasticOut)
            .fadeIn(duration: 400.ms),
          
          SizedBox(height: size.height < 700 ? 40 : 60),
          
          // Ethiopian Subtitle
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: data.color.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Text(
              data.subtitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: data.color,
                fontFamily: null,
                letterSpacing: 0.5,
              ),
            ),
          ).animate(target: isActive ? 1 : 0)
            .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: 200.ms)
            .fadeIn(duration: 400.ms, delay: 200.ms),
          
          const SizedBox(height: 24),
          
          // Main Title
          Text(
            data.title,
            style: TextStyle(
              fontSize: size.height < 700 ? 28 : 32,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1A1A),
              fontFamily: null,
              letterSpacing: -0.5,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ).animate(target: isActive ? 1 : 0)
            .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: 400.ms)
            .fadeIn(duration: 400.ms, delay: 400.ms),
          
          SizedBox(height: size.height < 700 ? 20 : 32),
          
          // Description
          Text(
            data.description,
            style: TextStyle(
              fontSize: size.height < 700 ? 16 : 18,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
              fontFamily: null,
              height: 1.6,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ).animate(target: isActive ? 1 : 0)
            .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: 600.ms)
            .fadeIn(duration: 400.ms, delay: 600.ms),
          
          SizedBox(height: size.height < 700 ? 32 : 48),
          
          // Features List
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: data.features.asMap().entries.map((entry) {
                final index = entry.key;
                final feature = entry.value;
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300 + (index * 100).toInt()),
                  margin: EdgeInsets.only(bottom: index < data.features.length - 1 ? 12 : 0),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: data.color.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: data.color.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: data.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 18,
                          color: data.color,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          feature,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF374151),
                            fontFamily: null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate(target: isActive ? 1 : 0)
                  .slideX(begin: 0.3, end: 0, duration: 400.ms, delay: Duration(milliseconds: 800 + (index * 100).toInt()))
                  .fadeIn(duration: 300.ms, delay: Duration(milliseconds: 800 + (index * 100).toInt()));
              }).toList(),
            ),
          ).animate(target: isActive ? 1 : 0)
            .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: 800.ms)
            .fadeIn(duration: 400.ms, delay: 800.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




















