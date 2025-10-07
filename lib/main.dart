import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tourist_assistive_app/core/app_router.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/core/services/firebase_service.dart';
import 'package:tourist_assistive_app/core/config/environment_config.dart';
import 'package:tourist_assistive_app/core/services/auto_setup_service.dart';
import 'package:tourist_assistive_app/core/services/automated_google_maps_service.dart';
import 'package:tourist_assistive_app/features/language/providers/language_provider.dart';
import 'package:tourist_assistive_app/features/auth/services/auth_service.dart';

void main() async {
  // Ensure Flutter is properly initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with comprehensive error handling
  print('🚀 Initializing Tourist Assistive App...');
  
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
  
  bool firebaseInitialized = false;
  try {
    firebaseInitialized = await FirebaseService.initialize();
    
    if (firebaseInitialized) {
      print('✅ Firebase initialized successfully');
      // Initialize app settings
      await FirebaseService.initializeAppSettings();
    } else {
      print('⚠️  Firebase initialization had issues, but app will continue');
      print('   Error: ${FirebaseService.initializationError}');
    }
  } catch (e) {
    print('⚠️  Firebase initialization failed, continuing without Firebase: $e');
  }
  
  // Initialize additional services
  print('🔧 Initializing additional services...');
  await AutomatedGoogleMapsService.initialize();
  // await GoogleSpeechService.initialize();  // Temporarily disabled
  print('✅ Additional services initialized');
  
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
  
  // Start the app
  runApp(const ProviderScope(child: TouristAssistiveApp()));
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
    // Auto setup disabled for now to prevent blank page issues
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _initializeAutoSetup();
    // });
  }

  // Future<void> _initializeAutoSetup() async {
  //   try {
  //     // Wait for the app to be fully initialized
  //     await Future.delayed(const Duration(seconds: 1));
  //     if (mounted) {
  //       final autoSetupService = ref.read(autoSetupServiceProvider);
  //       await autoSetupService.initialize(context);
  //     }
  //   } catch (e) {
  //     print('Auto setup initialization failed: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final currentLanguage = ref.watch(languageProvider);
    
    return MaterialApp.router(
      title: 'Tourist Assistive App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
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
          child: child!,
        );
      },
    );
  }
}










