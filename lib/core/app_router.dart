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
import 'package:tourist_assistive_app/features/language/screens/language_learning_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/duolingo_lesson_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/english_amharic_lessons_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/multilingual_amharic_lessons_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/language_selection_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/mandarin_amharic_lessons_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/french_amharic_lessons_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/german_amharic_lessons_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/spanish_amharic_lessons_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/arabic_amharic_lessons_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/portuguese_amharic_lessons_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/russian_amharic_lessons_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/japanese_amharic_lessons_screen.dart';
import 'package:tourist_assistive_app/features/language/screens/english_amharic_dictionary_screen.dart';
import 'package:tourist_assistive_app/features/locations/screens/locations_screen.dart';
import 'package:tourist_assistive_app/features/locations/screens/location_detail_screen.dart';
import 'package:tourist_assistive_app/features/locations/screens/location_detail_screen_enhanced.dart';
import 'package:tourist_assistive_app/features/locations/screens/modern_locations_screen.dart';
import 'package:tourist_assistive_app/features/chat/screens/advanced_chatbot_screen.dart';
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
  final authState = ref.watch(authProvider);
  final trialStatus = ref.watch(trialStatusProvider);
  // final hasLimitedAccess = ref.watch(limitedAccessProvider);
  
  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final isLoggedIn = authState.user != null;
      
      // Handle AsyncValue for trial status
      final trialData = trialStatus.when(
        data: (data) => data,
        loading: () => {'hasAccess': false, 'needsPayment': false, 'loading': true},
        error: (_, __) => {'hasAccess': false, 'needsPayment': false, 'loading': false},
      );
      
      final hasAccess = trialData['hasAccess'] ?? false;
      final needsPayment = trialData['needsPayment'] ?? false;
      final isLoading = trialData['loading'] ?? false;
      
      // Debug: Router redirect logic
      print('🔄 Router redirect check:');
      print('   Location: ${state.matchedLocation}');
      print('   isLoggedIn: $isLoggedIn');
      print('   hasAccess: $hasAccess');
      print('   needsPayment: $needsPayment');
      print('   isLoading: $isLoading');
      
      final isOnboarding = state.matchedLocation == '/onboarding';
      final isAuth = state.matchedLocation == '/auth';
      final isAdmin = state.matchedLocation.startsWith('/admin');
      // final isPayment = state.matchedLocation == '/payment';
      final isHome = state.matchedLocation.startsWith('/home');
      final isLanguage = state.matchedLocation.startsWith('/language');
      
      // Enhanced admin route access control
      if (isAdmin) {
        if (isLoggedIn && authState.user != null) {
          // Enhanced admin verification
          final userEmail = authState.user!.email?.toLowerCase().trim() ?? '';
          final adminEmail = 'kiru72fekadu@gmail.com'.toLowerCase().trim();
          final isAdminByEmail = userEmail == adminEmail;
          final isAdminByFlag = authState.user!.isAdmin;
          
          print('🔍 Enhanced admin access check:');
          print('  - User email: "$userEmail"');
          print('  - Admin email: "$adminEmail"');
          print('  - Email match: $isAdminByEmail');
          print('  - Flag match: $isAdminByFlag');
          print('  - Is logged in: $isLoggedIn');
          
          if (isAdminByEmail || isAdminByFlag) {
            print('✅ Admin access granted for: ${authState.user?.email}');
            print('✅ Admin verification successful');
            return null;
          } else {
            print('⛔ Admin access denied - email/flag mismatch');
            print('🔍 Redirecting to home');
            return '/home';
          }
        } else {
          print('⛔ Admin access denied - not logged in');
          print('🔍 Redirecting to home');
          return '/home';
        }
      }
      
      // If loading subscription data, don't redirect yet
      if (isLoading && isLoggedIn) {
        return null;
      }
      
      // If not logged in and not on auth/onboarding, redirect to onboarding
      if (!isLoggedIn && !isAuth && !isOnboarding) {
        return '/onboarding';
      }
      
      // ✅✅✅ COMPLETE UNRESTRICTED ACCESS - ALL FEATURES UNLOCKED ✅✅✅
      // No payment checks, no access restrictions, no trial limitations
      // EVERYTHING is FREE and ACCESSIBLE
      if (isLoggedIn) {
        print('✅ FULL ACCESS MODE: All features unlocked - lessons, chat, places, profile');
        
        // For root path, redirect to home
        if (state.matchedLocation == '/') {
          return '/home';
        }
        
        // ✅ GRANT COMPLETE ACCESS TO ALL ROUTES - NO RESTRICTIONS
        return null;
      }
      
      // If logged in but on auth/onboarding, redirect to home
      if (isLoggedIn && (isAuth || isOnboarding)) {
        return '/home';
      }
      
      return null;
    },
    routes: [
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
      GoRoute(
        path: '/language',
        builder: (context, state) => const LanguageLearningScreen(),
        routes: [
          GoRoute(
            path: 'amharic/lesson/:lessonId',
            builder: (context, state) {
              return DuolingoLessonScreen(
                lessonId: state.pathParameters['lessonId']!,
              );
            },
          ),
          GoRoute(
            path: 'selection',
            builder: (context, state) => const LanguageSelectionScreen(),
          ),
          GoRoute(
            path: 'amharic',
            builder: (context, state) => const EnglishAmharicLessonsScreen(),
          ),
          GoRoute(
            path: 'english-amharic',
            builder: (context, state) => const EnglishAmharicLessonsScreen(),
          ),
          GoRoute(
            path: 'multilingual-amharic/:languageCode',
            builder: (context, state) {
              final languageCode = state.pathParameters['languageCode']!;
              return MultilingualAmharicLessonsScreen(sourceLanguage: languageCode);
            },
          ),
          GoRoute(
            path: 'mandarin',
            builder: (context, state) => const MandarinAmharicLessonsScreen(),
          ),
          GoRoute(
            path: 'french',
            builder: (context, state) => const FrenchAmharicLessonsScreen(),
          ),
          GoRoute(
            path: 'german',
            builder: (context, state) => const GermanAmharicLessonsScreen(),
          ),
          GoRoute(
            path: 'spanish',
            builder: (context, state) => const SpanishAmharicLessonsScreen(),
          ),
          GoRoute(
            path: 'arabic',
            builder: (context, state) => const ArabicAmharicLessonsScreen(),
          ),
          GoRoute(
            path: 'portuguese',
            builder: (context, state) => const PortugueseAmharicLessonsScreen(),
          ),
          GoRoute(
            path: 'russian',
            builder: (context, state) => const RussianAmharicLessonsScreen(),
          ),
          GoRoute(
            path: 'japanese',
            builder: (context, state) => const JapaneseAmharicLessonsScreen(),
          ),
          GoRoute(
            path: 'dictionary',
            builder: (context, state) => const EnglishAmharicDictionaryScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/locations',
        builder: (context, state) => const ModernLocationsScreen(),
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

// Helper methods for language data
String _getLanguageName(String languageCode) {
  switch (languageCode) {
    case 'en': return 'English';
    case 'zh': return 'Mandarin';
    case 'fr': return 'French';
    case 'de': return 'German';
    case 'es': return 'Spanish';
    case 'ar': return 'Arabic';
    case 'pt': return 'Portuguese';
    case 'ru': return 'Russian';
    case 'ja': return 'Japanese';
    default: return 'English';
  }
}

String _getNativeName(String languageCode) {
  switch (languageCode) {
    case 'en': return 'English';
    case 'zh': return '中文';
    case 'fr': return 'Français';
    case 'de': return 'Deutsch';
    case 'es': return 'Español';
    case 'ar': return 'العربية';
    case 'pt': return 'Português';
    case 'ru': return 'Русский';
    case 'ja': return '日本語';
    default: return 'English';
  }
}

String _getFlag(String languageCode) {
  switch (languageCode) {
    case 'en': return '🇺🇸';
    case 'zh': return '🇨🇳';
    case 'fr': return '🇫🇷';
    case 'de': return '🇩🇪';
    case 'es': return '🇪🇸';
    case 'ar': return '🇸🇦';
    case 'pt': return '🇵🇹';
    case 'ru': return '🇷🇺';
    case 'ja': return '🇯🇵';
    default: return '🇺🇸';
  }
}

Color _getColor(String languageCode) {
  switch (languageCode) {
    case 'en': return const Color(0xFF1CB0F6);
    case 'zh': return const Color(0xFFCE82FF);
    case 'fr': return const Color(0xFF1CB0F6);
    case 'de': return const Color(0xFFCE82FF);
    case 'es': return const Color(0xFF1CB0F6);
    case 'ar': return const Color(0xFFCE82FF);
    case 'pt': return const Color(0xFF1CB0F6);
    case 'ru': return const Color(0xFFCE82FF);
    case 'ja': return const Color(0xFF1CB0F6);
    default: return const Color(0xFF1CB0F6);
  }
}







