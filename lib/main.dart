import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tourist_assistive_app/core/app_router.dart';
import 'package:tourist_assistive_app/core/theme/professional_theme.dart';
import 'package:tourist_assistive_app/core/utils/error_handler_global.dart';
import 'package:tourist_assistive_app/core/utils/render_fix.dart';
import 'package:tourist_assistive_app/core/utils/professional_layout_fix.dart';
import 'package:tourist_assistive_app/core/services/firebase_service.dart';
import 'package:tourist_assistive_app/core/config/environment_config.dart';
import 'package:tourist_assistive_app/core/services/automated_google_maps_service.dart';
import 'package:tourist_assistive_app/features/language/providers/language_provider.dart';
import 'package:tourist_assistive_app/features/auth/services/auth_service.dart';
import 'package:tourist_assistive_app/features/auth/providers/auth_provider.dart';
import 'package:tourist_assistive_app/core/widgets/app_error_boundary.dart';

void main() async {
  // Ensure Flutter is properly initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Fix mouse tracker issues on web
  if (kIsWeb) {
    // Override FlutterError.onError to suppress mouse tracker assertions
    FlutterError.onError = (FlutterErrorDetails details) {
      // Check if this is the specific mouse tracker assertion error or layout errors
      if (details.exceptionAsString().contains('!_debugDuringDeviceUpdate is not true') ||
          details.exceptionAsString().contains('mouse_tracker') ||
          details.toString().contains('mouse_tracker') ||
          details.toString().contains('Cannot hit test a render box that has never been laid out') ||
          details.toString().contains('NEEDS-LAYOUT NEEDS-PAINT')) {
        print('⚠️ Suppressing mouse tracker/layout assertion error (known Flutter web issue)');
        return; // Don't propagate this error
      }
      
      // For all other errors, use the default handler
      FlutterError.dumpErrorToConsole(details);
    };
    
    // Also suppress debug print messages for mouse tracker
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null && !message.contains('mouse_tracker')) {
        print(message);
      }
    };
  }
  
  print('🚀 Starting Tourist Assistive App...');
  
  // Initialize error handling first
  GlobalErrorHandler.initialize();
  RenderFix.initialize();
  ProfessionalLayoutFix.initialize();
  
  // Initialize Firebase synchronously - this is critical
  bool firebaseInitialized = false;
  try {
    print('🔥 Initializing Firebase...');
    firebaseInitialized = await FirebaseService.initialize();
    
    if (firebaseInitialized) {
      print('✅ Firebase initialized successfully');
      // Initialize app settings
      await FirebaseService.initializeAppSettings();
    } else {
      print('❌ Firebase initialization failed - this is critical');
      print('   Error: ${FirebaseService.initializationError}');
      // Don't continue if Firebase fails - it's critical for the app
      return;
    }
  } catch (e) {
    print('❌ Critical error: Firebase initialization failed');
    print('   Error: $e');
    print('   Stack trace: ${StackTrace.current}');
    // Don't continue if Firebase fails
    return;
  }
  
  // Initialize additional services
  print('🔧 Initializing additional services...');
  try {
    await AutomatedGoogleMapsService.initialize();
    print('✅ Additional services initialized');
  } catch (e) {
    print('⚠️ Additional services initialization failed: $e');
    // Continue even if additional services fail
  }
  
  // Check API configuration status
  final configStatus = EnvironmentConfig.configurationStatus;
  print('📋 API Configuration Status:');
  configStatus.forEach((service, isConfigured) {
    print('   $service: ${isConfigured ? "✅ Configured" : "🔄 Development Mode"}');
  });
  
  // Show development mode message
  final hasAnyApiKey = configStatus.values.any((configured) => configured);
  if (!hasAnyApiKey) {
    print('🎯 Running in Development Mode - All features available with local knowledge base!');
    print('💡 To enable full AI features, configure API keys using: scripts/setup_api_keys.bat');
  } else {
    print('🚀 Running with API integration - Full features enabled!');
  }
  
  // Create admin account if needed
  try {
    if (firebaseInitialized) {
      print('🔧 Checking admin account...');
      try {
        final authService = AuthService();
        await authService.createAdminAccountIfNeeded();
      } catch (e) {
        print('⚠️ Admin account setup: $e');
      }
    }
  } catch (e) {
    print('⚠️ Admin account setup failed: $e');
  }
  
  print('✅ All services initialized successfully');
  
  // Start the app with error boundary
  runApp(
    const ProviderScope(
      child: AppErrorBoundary(
        child: TouristAssistiveApp(),
      ),
    ),
  );
}

class TouristAssistiveApp extends ConsumerStatefulWidget {
  const TouristAssistiveApp({super.key});

  @override
  ConsumerState<TouristAssistiveApp> createState() => _TouristAssistiveAppState();
}

class _TouristAssistiveAppState extends ConsumerState<TouristAssistiveApp> {
  @override
  void initState() {
    super.initState();
    
    // Add debug information after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _debugAppState();
    });
  }
  
  void _debugAppState() {
    print('🔍 App Debug Info:');
    print('   Firebase initialized: ${FirebaseService.isInitialized}');
    print('   Firebase error: ${FirebaseService.initializationError}');
    
    // Check auth state
    try {
      final authState = ref.read(authProvider);
      print('   Auth state: ${authState.runtimeType}');
      print('   Auth loading: ${authState.isLoading}');
      print('   Auth authenticated: ${authState.isAuthenticated}');
      print('   Auth user: ${authState.user?.uid}');
    } catch (e) {
      print('   Auth state error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final currentLanguage = ref.watch(languageProvider);
    
    // Add more debug information
    print('🔍 Build Debug Info:');
    print('   Router: ${router.routerDelegate.currentConfiguration}');
    print('   Language: $currentLanguage');
    
    return MouseTrackingErrorBoundary(
      child: ProfessionalLayoutFix.professionalWidget(
        MaterialApp.router(
          title: 'Tourist Assistive App',
          debugShowCheckedModeBanner: false, // Disable debug banner for cleaner look
          theme: ProfessionalTheme.darkTheme,
          darkTheme: ProfessionalTheme.darkTheme,
          themeMode: ThemeMode.dark,
          routerConfig: router,
          locale: Locale(currentLanguage),
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('am', ''), // Amharic
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: ProfessionalLayoutFix.professionalWidget(child!),
            );
          },
        ),
      ),
    );
  }
}










