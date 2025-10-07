import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tourist_assistive_app/core/app_router.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/language/providers/language_provider.dart';

void main() async {
  // Ensure Flutter is properly initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  print('🚀 Initializing Tourist Assistive App (Simple Version)...');
  
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




