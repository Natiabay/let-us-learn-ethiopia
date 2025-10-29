import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/auth/providers/auth_provider.dart';
import 'package:tourist_assistive_app/features/subscription/providers/subscription_provider.dart';
import 'package:tourist_assistive_app/features/auth/screens/professional_auth_screen.dart';
import 'package:tourist_assistive_app/features/auth/screens/signup_screen.dart';
import 'package:tourist_assistive_app/features/auth/screens/forgot_password_screen.dart';
import 'package:tourist_assistive_app/features/auth/screens/email_sent_screen.dart';
import 'package:tourist_assistive_app/features/auth/screens/reset_password_screen.dart';
import 'package:tourist_assistive_app/features/auth/screens/password_reset_success_screen.dart';
import 'package:tourist_assistive_app/features/onboarding/screens/onboarding_screen.dart';
import 'package:tourist_assistive_app/features/payment/screens/payment_method_screen.dart';
import 'package:tourist_assistive_app/features/payment/screens/payment_status_screen.dart';
import 'package:tourist_assistive_app/features/payment/screens/payment_dashboard_screen.dart';
import 'package:tourist_assistive_app/features/home/screens/main_screen.dart';
import 'package:tourist_assistive_app/features/home/screens/home_dashboard.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/dashboard/duolingo_dashboard.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/lessons/lesson_screen.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/fidel/fidel_dashboard.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/progress/progress_dashboard.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/onboarding/welcome_screen.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/onboarding/language_selection_screen.dart' as duolingo;
import 'package:tourist_assistive_app/features/duolingo_learn/screens/onboarding/proficiency_screen.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/onboarding/learning_goals_screen.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/screens/onboarding/preferences_screen.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/providers/lesson_provider.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/providers/onboarding_provider.dart';
import 'package:tourist_assistive_app/features/language/screens/enhanced_amharic_lesson_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/universal_amharic_lessons_screen.dart';
import 'package:tourist_assistive_app/features/language/widgets/multi_language_selector.dart';
import 'package:tourist_assistive_app/features/language/screens/english_amharic_dictionary_screen.dart';
import 'package:tourist_assistive_app/features/locations/screens/location_detail_screen_enhanced.dart';
import 'package:tourist_assistive_app/features/locations/screens/locations_screen.dart';
import 'package:tourist_assistive_app/features/chat/screens/modern_chat_screen.dart';
import 'package:tourist_assistive_app/features/profile/screens/profile_screen.dart';
import 'package:tourist_assistive_app/features/profile/screens/edit_profile_screen.dart';
import 'package:tourist_assistive_app/features/profile/screens/favorite_locations_screen.dart';
import 'package:tourist_assistive_app/features/profile/screens/learning_progress_screen.dart';
import 'package:tourist_assistive_app/features/profile/screens/subscription_screen.dart';
import 'package:tourist_assistive_app/features/profile/screens/notifications_screen.dart';
import 'package:tourist_assistive_app/features/profile/screens/help_support_screen.dart';
import 'package:tourist_assistive_app/features/contact/screens/contact_us_screen.dart';
import 'package:tourist_assistive_app/features/about/screens/about_us_screen.dart';
import 'package:tourist_assistive_app/features/admin/screens/admin_dashboard_screen_wrapper.dart';
import 'package:tourist_assistive_app/features/feedback/screens/feedback_screen.dart';

// Provider to track if user chose limited access
final limitedAccessProvider = StateProvider<bool>((ref) => false);

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final authState = ref.watch(authProvider);
      final isAuthenticated = authState.isAuthenticated;
      final isAuthenticating = authState.isLoading;

      print('🔄 Router redirect called for: ${state.matchedLocation}');
      print('   Is Authenticated: $isAuthenticated, Is Loading: $isAuthenticating');

      // If still loading auth state, don't redirect yet
      if (isAuthenticating) {
        return null; // Keep current location or show a loading screen
      }

      // If authenticated, redirect to home dashboard
      if (isAuthenticated) {
        if (state.matchedLocation == '/' || 
            state.matchedLocation == '/onboarding' || 
            state.matchedLocation == '/auth') {
          print('✅ Authenticated, redirecting to /home');
          return '/home';
        }
        // Allow language setup routes only if user hasn't completed onboarding
        if (state.matchedLocation.startsWith('/language/setup')) {
          final isOnboardingComplete = ref.read(isOnboardingCompleteProvider);
          if (isOnboardingComplete) {
            print('✅ Onboarding complete, redirecting to /home');
            return '/home';
          }
        }
        return null; // Allow navigation to other routes if authenticated
      } else {
        // If not authenticated, redirect to main onboarding
        if (state.matchedLocation != '/onboarding' && 
            state.matchedLocation != '/auth') {
          print('❌ Not authenticated, redirecting to /onboarding');
          return '/onboarding';
        }
        return null; // Allow navigation to onboarding and auth
      }
    },
    routes: [
      // Root route - will be handled by redirect logic
      GoRoute(
        path: '/',
        redirect: (context, state) => '/onboarding', // Default redirect, actual logic in main redirect
      ),
      // 🔐 AUTHENTICATION ONBOARDING - For user registration/login
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const ProfessionalAuthScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/auth/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/auth/email-sent',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return EmailSentScreen(email: email);
        },
      ),
      GoRoute(
        path: '/auth/reset-password',
        builder: (context, state) {
          final token = state.uri.queryParameters['token'];
          return ResetPasswordScreen(token: token);
        },
      ),
      GoRoute(
        path: '/auth/password-reset-success',
        builder: (context, state) => const PasswordResetSuccessScreen(),
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) => const PaymentDashboardScreen(),
        routes: [
          GoRoute(
            path: 'method',
            builder: (context, state) {
              final plan = state.uri.queryParameters['plan'];
              return PaymentMethodScreen(selectedPlan: plan);
            },
          ),
          GoRoute(
            path: 'status/:transactionId',
            builder: (context, state) => PaymentStatusScreen(
              transactionId: state.pathParameters['transactionId']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MainScreen(child: HomeDashboard()),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) {
          print('✅ Admin route accessed');
          return const AdminDashboardScreenWrapper();
        },
      ),
      GoRoute(
        path: '/feedback',
        builder: (context, state) => const FeedbackScreen(),
      ),
      // Duolingo routes
      GoRoute(
        path: '/duolingo',
        builder: (context, state) => const DuolingoDashboard(),
        routes: [
          GoRoute(
            path: 'lessons/:lessonId',
            builder: (context, state) {
              final lessonId = state.pathParameters['lessonId']!;
              final lesson = ref.read(lessonByIdProvider(lessonId));
              if (lesson != null) {
                return LessonScreen(lesson: lesson);
              } else {
                return Scaffold(
                  body: Center(
                    child: Text('Lesson not found: $lessonId'),
                  ),
                );
              }
            },
          ),
          GoRoute(
            path: 'fidel',
            builder: (context, state) => const FidelDashboard(),
          ),
        ],
      ),
      GoRoute(
        path: '/language',
        builder: (context, state) => const DuolingoDashboard(),
        routes: [
          // Duolingo lesson routes
          GoRoute(
            path: 'lessons/:lessonId',
            builder: (context, state) {
              final lessonId = state.pathParameters['lessonId']!;
              final lesson = ref.read(lessonByIdProvider(lessonId));
              if (lesson != null) {
                return LessonScreen(lesson: lesson);
              } else {
                return Scaffold(
                  body: Center(
                    child: Text('Lesson not found: $lessonId'),
                  ),
                );
              }
            },
          ),
          GoRoute(
            path: 'fidel',
            builder: (context, state) => const FidelDashboard(),
          ),
          GoRoute(
            path: 'progress',
            builder: (context, state) => const ProgressDashboard(),
          ),
          // 📚 LEARNING SETUP - For lesson preferences and setup
          GoRoute(
            path: 'setup/welcome',
            builder: (context, state) => const WelcomeScreen(),
          ),
          GoRoute(
            path: 'setup/language',
            builder: (context, state) => const duolingo.LanguageSelectionScreen(),
          ),
          GoRoute(
            path: 'setup/proficiency',
            builder: (context, state) => const ProficiencyScreen(),
          ),
          GoRoute(
            path: 'setup/goals',
            builder: (context, state) => const LearningGoalsScreen(),
          ),
          GoRoute(
            path: 'setup/preferences',
            builder: (context, state) => const PreferencesScreen(),
          ),
          // Duolingo lesson routes
          GoRoute(
            path: 'lessons/:lessonId',
            builder: (context, state) {
              final lessonId = state.pathParameters['lessonId']!;
              final lesson = ref.read(lessonByIdProvider(lessonId));
              if (lesson != null) {
                return LessonScreen(lesson: lesson);
              } else {
                return const Scaffold(
                  body: Center(
                    child: Text('Lesson not found'),
                  ),
                );
              }
            },
          ),
          GoRoute(
            path: 'fidel',
            builder: (context, state) => const FidelDashboard(),
          ),
          GoRoute(
            path: 'amharic/lesson/:lessonId',
            builder: (context, state) {
              return EnhancedAmharicLessonScreen(
                lessonId: state.pathParameters['lessonId']!,
              );
            },
          ),
          // Language selector - shows 10 languages with flags
          GoRoute(
            path: 'selection',
            builder: (context, state) => const MultiLanguageSelector(),
          ),
          // Universal Amharic lessons route - works for all 10 languages
          GoRoute(
            path: 'amharic/lessons',
            builder: (context, state) {
              final languageCode = state.uri.queryParameters['lang'] ?? 'en';
              return UniversalAmharicLessonsScreen(languageCode: languageCode);
            },
          ),
          // Legacy routes - redirect to universal route
          GoRoute(
            path: 'amharic',
            redirect: (context, state) => '/language/amharic/lessons?lang=en',
          ),
          GoRoute(
            path: 'english-amharic',
            redirect: (context, state) => '/language/amharic/lessons?lang=en',
          ),
          GoRoute(
            path: 'english',
            redirect: (context, state) => '/language/amharic/lessons?lang=en',
          ),
          GoRoute(
            path: 'mandarin',
            redirect: (context, state) => '/language/amharic/lessons?lang=zh',
          ),
          GoRoute(
            path: 'french',
            redirect: (context, state) => '/language/amharic/lessons?lang=fr',
          ),
          GoRoute(
            path: 'german',
            redirect: (context, state) => '/language/amharic/lessons?lang=de',
          ),
          GoRoute(
            path: 'spanish',
            redirect: (context, state) => '/language/amharic/lessons?lang=es',
          ),
          GoRoute(
            path: 'arabic',
            redirect: (context, state) => '/language/amharic/lessons?lang=ar',
          ),
          GoRoute(
            path: 'portuguese',
            redirect: (context, state) => '/language/amharic/lessons?lang=pt',
          ),
          GoRoute(
            path: 'russian',
            redirect: (context, state) => '/language/amharic/lessons?lang=ru',
          ),
          GoRoute(
            path: 'japanese',
            redirect: (context, state) => '/language/amharic/lessons?lang=ja',
          ),
          GoRoute(
            path: 'hindi',
            redirect: (context, state) => '/language/amharic/lessons?lang=hi',
          ),
          GoRoute(
            path: 'dictionary',
            builder: (context, state) => const EnglishAmharicDictionaryScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/locations',
        builder: (context, state) => const MainScreen(child: LocationsScreen()),
        routes: [
          GoRoute(
            path: 'detail/:locationId',
            builder: (context, state) => LocationDetailScreenEnhanced(
              locationId: state.pathParameters['locationId']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/chatbot',
        builder: (context, state) {
          print('✅ Building ModernChatScreen with RAG system');
          return const ModernChatScreen();
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) => const EditProfileScreen(),
          ),
          GoRoute(
            path: 'favorites',
            builder: (context, state) => const FavoriteLocationsScreen(),
          ),
          GoRoute(
            path: 'progress',
            builder: (context, state) => const LearningProgressScreen(),
          ),
          GoRoute(
            path: 'subscription',
            builder: (context, state) => const SubscriptionScreen(),
          ),
          GoRoute(
            path: 'notifications',
            builder: (context, state) => const NotificationsScreen(),
          ),
          GoRoute(
            path: 'help',
            builder: (context, state) => const HelpSupportScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/payment-status',
        builder: (context, state) => const PaymentStatusScreen(transactionId: 'current'),
      ),
      GoRoute(
        path: '/contact-us',
        builder: (context, state) => const ContactUsScreen(),
      ),
      GoRoute(
        path: '/about-us',
        builder: (context, state) => const AboutUsScreen(),
      ),
    ],
  );
});







