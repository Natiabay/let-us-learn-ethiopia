import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tourist_assistive_app/core/theme/professional_theme.dart';
import 'package:tourist_assistive_app/features/language/providers/language_provider.dart';

void main() async {
  // Ensure Flutter is properly initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Start the app
  runApp(const ProviderScope(child: DebugApp()));
}

class DebugApp extends ConsumerStatefulWidget {
  const DebugApp({super.key});

  @override
  ConsumerState<DebugApp> createState() => _DebugAppState();
}

class _DebugAppState extends ConsumerState<DebugApp> {
  @override
  Widget build(BuildContext context) {
    final currentLanguage = ref.watch(languageProvider);
    
    return MaterialApp(
      title: 'Tourist Assistive App - Debug',
      debugShowCheckedModeBanner: false,
      theme: ProfessionalTheme.darkTheme,
      darkTheme: ProfessionalTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const DebugHomePage(),
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
    );
  }
}

class DebugHomePage extends StatelessWidget {
  const DebugHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1929),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D9B8), Color(0xFF1CB0F6)],
                  ),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(
                  Icons.explore_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Tourist Assistant Ethiopia',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Debug Mode - App is Working!',
                style: TextStyle(
                  color: Color(0xFF00D9B8),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'If you can see this, the basic Flutter setup is working correctly.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Button works! App is functional.'),
                      backgroundColor: Color(0xFF00D9B8),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D9B8),
                  foregroundColor: const Color(0xFF0A1929),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Test Button',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

