import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/onboarding/models/onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _backgroundController;
  late AnimationController _floatingController;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Let us learn Ethiopia',
      subtitle: 'ኢትዮጵያን እንማር',
      description: 'Your comprehensive guide to exploring the beautiful country of Ethiopia. Discover amazing places, learn the language, and get instant help.',
      image: Icons.public_rounded,
      color: const Color(0xFF58CC02),
      logoPath: 'assets/images/Logo.png',
      gradient: const LinearGradient(
        colors: [Color(0xFF58CC02), Color(0xFF1CB0F6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      features: ['🏛️ Historical Sites', '🗺️ Interactive Maps', '📱 Offline Access'],
    ),
    OnboardingData(
      title: 'Learn Amharic',
      subtitle: 'አማርኛ ይማሩ',
      description: 'Master the local language with our interactive lessons. Practice speaking, listening, and writing Amharic like a native.',
      image: Icons.school_rounded,
      color: const Color(0xFF1CB0F6),
      logoPath: 'assets/images/ethio_assist_logo.png',
      gradient: const LinearGradient(
        colors: [Color(0xFF1CB0F6), Color(0xFFCE82FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      features: ['🎯 Interactive Lessons', '🎤 Voice Practice', '📚 Cultural Context'],
    ),
    OnboardingData(
      title: 'Explore Amazing Places',
      subtitle: 'አስደናቂ ቦታዎችን ያስሱ',
      description: 'Discover hidden gems, historical sites, and popular tourist destinations. Get detailed information and directions.',
      image: Icons.location_on_rounded,
      color: const Color(0xFFCE82FF),
      logoPath: 'assets/images/ethio_assist_logo.png',
      gradient: const LinearGradient(
        colors: [Color(0xFFCE82FF), Color(0xFFFF6B6B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      features: ['🏔️ National Parks', '🏰 Ancient Castles', '🌋 Natural Wonders'],
    ),
    OnboardingData(
      title: 'Get Instant Help',
      subtitle: 'ወዲያውኑ እርዳታ ያግኙ',
      description: 'Chat with our AI assistant anytime. Get answers about culture, directions, emergency contacts, and local tips.',
      image: Icons.chat_bubble_rounded,
      color: const Color(0xFFFF6B6B),
      logoPath: 'assets/images/ethio_assist_logo.png',
      gradient: const LinearGradient(
        colors: [Color(0xFFFF6B6B), Color(0xFF58CC02)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      features: ['🤖 AI Assistant', '🚨 Emergency Help', '💬 24/7 Support'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _backgroundController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentData = _pages[_currentPage];
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              currentData.gradient.colors.first.withValues(alpha: 0.9),
              currentData.gradient.colors.last.withValues(alpha: 0.7),
              const Color(0xFF1A1A1A),
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated Background Elements
            _buildAnimatedBackground(),
            
            // Main Content
            SafeArea(
              child: Column(
                children: [
                  // Top Section with Skip and Progress
                  _buildTopSection(),
                  
                  // Main Content
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: _pages.length,
                      itemBuilder: (context, index) {
                        return _buildOnboardingPage(_pages[index], index);
                      },
                    ),
                  ),
                  
                  // Bottom Section with Navigation
                  _buildBottomSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Stack(
      children: [
        // Floating Circles
        ...List.generate(8, (index) {
          final size = 50.0 + (index * 20.0);
          final left = (index * 50.0) % MediaQuery.of(context).size.width;
          final top = (index * 100.0) % MediaQuery.of(context).size.height;
          
          return Positioned(
            left: left,
            top: top,
            child: AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatingController.value * 20),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.1),
                          Colors.white.withValues(alpha: 0.05),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),
        
        // Geometric Shapes
        Positioned(
          top: 100,
          right: -50,
          child: AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _backgroundController.value * 2 * 3.14159,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        
        Positioned(
          bottom: 150,
          left: -30,
          child: AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, child) {
              return Transform.rotate(
                angle: -_backgroundController.value * 2 * 3.14159,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip Button
          TextButton(
            onPressed: () => context.go('/auth'),
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          // Progress Indicator
          Row(
            children: List.generate(_pages.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index 
                      ? Colors.white 
                      : Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data, int index) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo and Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.2),
                  Colors.white.withValues(alpha: 0.1),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: data.logoPath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      data.logoPath!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          data.image,
                          size: 60,
                          color: Colors.white,
                        );
                      },
                    ),
                  )
                : Icon(
                    data.image,
                    size: 60,
                    color: Colors.white,
                  ),
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
          
          const SizedBox(height: 40),
          
          // Title
          Text(
            data.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 8),
          
          // Subtitle (Amharic)
          Text(
            data.subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: 'NotoSansEthiopic',
            ),
            textAlign: TextAlign.center,
          ).animate(delay: 400.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 24),
          
          // Description
          Text(
            data.description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 16,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ).animate(delay: 600.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 40),
          
          // Features
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Column(
              children: data.features.map((feature) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ).animate(delay: 800.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
        ],
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Next/Get Started Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: _pages[_currentPage].color,
                elevation: 8,
                shadowColor: Colors.black.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                if (_currentPage < _pages.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  context.go('/auth');
                }
              },
              child: Text(
                _currentPage < _pages.length - 1 ? 'Next' : 'Get Started',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ).animate(delay: 1000.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 16),
          
          // Previous Button (if not first page)
          if (_currentPage > 0)
            TextButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                'Previous',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ).animate(delay: 1200.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }
}