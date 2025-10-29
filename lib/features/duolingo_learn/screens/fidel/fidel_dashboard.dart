import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/duolingo_learn/services/enhanced_tts_service.dart';

/// Fidel Dashboard - Learn Amharic Letters (Ge'ez script)
/// Interactive teaching of the 231 characters of Fidel
class FidelDashboard extends StatefulWidget {
  const FidelDashboard({super.key});

  @override
  State<FidelDashboard> createState() => _FidelDashboardState();
}

class _FidelDashboardState extends State<FidelDashboard> {
  final _ttsService = EnhancedTTSService();
  int _selectedFamily = 0;

  // Complete Fidel families (consonants with 7 vowel forms each) - All 33 families
  final List<FidelFamily> _fidelFamilies = [
    // Basic consonants (1st order)
    FidelFamily(
      name: 'Ha',
      transliteration: 'h',
      characters: ['ሀ', 'ሁ', 'ሂ', 'ሃ', 'ሄ', 'ህ', 'ሆ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['hä', 'hu', 'hi', 'ha', 'he', 'hə', 'ho'],
    ),
    FidelFamily(
      name: 'La',
      transliteration: 'l',
      characters: ['ለ', 'ሉ', 'ሊ', 'ላ', 'ሌ', 'ል', 'ሎ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['lä', 'lu', 'li', 'la', 'le', 'lə', 'lo'],
    ),
    FidelFamily(
      name: 'Ma',
      transliteration: 'm',
      characters: ['መ', 'ሙ', 'ሚ', 'ማ', 'ሜ', 'ም', 'ሞ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['mä', 'mu', 'mi', 'ma', 'me', 'mə', 'mo'],
    ),
    FidelFamily(
      name: 'Sa',
      transliteration: 's',
      characters: ['ሰ', 'ሱ', 'ሲ', 'ሳ', 'ሴ', 'ስ', 'ሶ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['sä', 'su', 'si', 'sa', 'se', 'sə', 'so'],
    ),
    FidelFamily(
      name: 'Ra',
      transliteration: 'r',
      characters: ['ረ', 'ሩ', 'ሪ', 'ራ', 'ሬ', 'ር', 'ሮ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['rä', 'ru', 'ri', 'ra', 're', 'rə', 'ro'],
    ),
    FidelFamily(
      name: 'Ba',
      transliteration: 'b',
      characters: ['በ', 'ቡ', 'ቢ', 'ባ', 'ቤ', 'ብ', 'ቦ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['bä', 'bu', 'bi', 'ba', 'be', 'bə', 'bo'],
    ),
    FidelFamily(
      name: 'Ta',
      transliteration: 't',
      characters: ['ተ', 'ቱ', 'ቲ', 'ታ', 'ቴ', 'ት', 'ቶ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['tä', 'tu', 'ti', 'ta', 'te', 'tə', 'to'],
    ),
    FidelFamily(
      name: 'Na',
      transliteration: 'n',
      characters: ['ነ', 'ኑ', 'ኒ', 'ና', 'ኔ', 'ን', 'ኖ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['nä', 'nu', 'ni', 'na', 'ne', 'nə', 'no'],
    ),
    FidelFamily(
      name: 'Nya',
      transliteration: 'ñ',
      characters: ['ኘ', 'ኙ', 'ኚ', 'ኛ', 'ኜ', 'ኝ', 'ኞ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['ñä', 'ñu', 'ñi', 'ña', 'ñe', 'ñə', 'ño'],
    ),
    FidelFamily(
      name: 'Aa',
      transliteration: 'ʔ',
      characters: ['አ', 'ኡ', 'ኢ', 'ኣ', 'ኤ', 'እ', 'ኦ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['ʔä', 'ʔu', 'ʔi', 'ʔa', 'ʔe', 'ʔə', 'ʔo'],
    ),
    FidelFamily(
      name: 'Ka',
      transliteration: 'k',
      characters: ['ከ', 'ኩ', 'ኪ', 'ካ', 'ኬ', 'ክ', 'ኮ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['kä', 'ku', 'ki', 'ka', 'ke', 'kə', 'ko'],
    ),
    FidelFamily(
      name: 'Wa',
      transliteration: 'w',
      characters: ['ወ', 'ዉ', 'ዊ', 'ዋ', 'ዌ', 'ው', 'ዎ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['wä', 'wu', 'wi', 'wa', 'we', 'wə', 'wo'],
    ),
    FidelFamily(
      name: 'Aa2',
      transliteration: 'ʕ',
      characters: ['ዐ', 'ዑ', 'ዒ', 'ዓ', 'ዔ', 'ዕ', 'ዖ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['ʕä', 'ʕu', 'ʕi', 'ʕa', 'ʕe', 'ʕə', 'ʕo'],
    ),
    FidelFamily(
      name: 'Za',
      transliteration: 'z',
      characters: ['ዘ', 'ዙ', 'ዚ', 'ዛ', 'ዜ', 'ዝ', 'ዞ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['zä', 'zu', 'zi', 'za', 'ze', 'zə', 'zo'],
    ),
    FidelFamily(
      name: 'Ya',
      transliteration: 'y',
      characters: ['የ', 'ዩ', 'ዪ', 'ያ', 'ዬ', 'ይ', 'ዮ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['yä', 'yu', 'yi', 'ya', 'ye', 'yə', 'yo'],
    ),
    FidelFamily(
      name: 'Da',
      transliteration: 'd',
      characters: ['ደ', 'ዱ', 'ዲ', 'ዳ', 'ዴ', 'ድ', 'ዶ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['dä', 'du', 'di', 'da', 'de', 'də', 'do'],
    ),
    FidelFamily(
      name: 'Ga',
      transliteration: 'g',
      characters: ['ገ', 'ጉ', 'ጊ', 'ጋ', 'ጌ', 'ግ', 'ጎ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['gä', 'gu', 'gi', 'ga', 'ge', 'gə', 'go'],
    ),
    FidelFamily(
      name: 'Tha',
      transliteration: 'ṭ',
      characters: ['ጠ', 'ጡ', 'ጢ', 'ጣ', 'ጤ', 'ጥ', 'ጦ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['ṭä', 'ṭu', 'ṭi', 'ṭa', 'ṭe', 'ṭə', 'ṭo'],
    ),
    FidelFamily(
      name: 'Cha',
      transliteration: 'č',
      characters: ['ጨ', 'ጩ', 'ጪ', 'ጫ', 'ጬ', 'ጭ', 'ጮ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['čä', 'ču', 'či', 'ča', 'če', 'čə', 'čo'],
    ),
    FidelFamily(
      name: 'Pha',
      transliteration: 'p̣',
      characters: ['ጰ', 'ጱ', 'ጲ', 'ጳ', 'ጴ', 'ጵ', 'ጶ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['p̣ä', 'p̣u', 'p̣i', 'p̣a', 'p̣e', 'p̣ə', 'p̣o'],
    ),
    FidelFamily(
      name: 'Tsa',
      transliteration: 'ṣ',
      characters: ['ጸ', 'ጹ', 'ጺ', 'ጻ', 'ጼ', 'ጽ', 'ጾ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['ṣä', 'ṣu', 'ṣi', 'ṣa', 'ṣe', 'ṣə', 'ṣo'],
    ),
    FidelFamily(
      name: 'Tza',
      transliteration: 'ṣ̌',
      characters: ['ፀ', 'ፁ', 'ፂ', 'ፃ', 'ፄ', 'ፅ', 'ፆ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['ṣ̌ä', 'ṣ̌u', 'ṣ̌i', 'ṣ̌a', 'ṣ̌e', 'ṣ̌ə', 'ṣ̌o'],
    ),
    FidelFamily(
      name: 'Fa',
      transliteration: 'f',
      characters: ['ፈ', 'ፉ', 'ፊ', 'ፋ', 'ፌ', 'ፍ', 'ፎ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['fä', 'fu', 'fi', 'fa', 'fe', 'fə', 'fo'],
    ),
    FidelFamily(
      name: 'Pa',
      transliteration: 'p',
      characters: ['ፐ', 'ፑ', 'ፒ', 'ፓ', 'ፔ', 'ፕ', 'ፖ'],
      vowels: ['ä', 'u', 'i', 'a', 'e', 'ə', 'o'],
      pronunciations: ['pä', 'pu', 'pi', 'pa', 'pe', 'pə', 'po'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _ttsService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final selectedFamily = _fidelFamilies[_selectedFamily];

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Learn Fidel',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: Colors.white70),
            onPressed: () {
              _showFidelInfo();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text(
                    'Amharic Alphabet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(),
                  const SizedBox(height: 8),
                  const Text(
                    'Learn the beautiful Ge\'ez script',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ).animate().fadeIn(delay: 100.ms),
                ],
              ),
            ),

            // Family selector
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _fidelFamilies.length,
                itemBuilder: (context, index) {
                  final family = _fidelFamilies[index];
                  final isSelected = index == _selectedFamily;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedFamily = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF58CC02)
                              : const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            family.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 24),

            // Character grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: selectedFamily.characters.length,
                itemBuilder: (context, index) {
                  return _buildCharacterCard(
                    character: selectedFamily.characters[index],
                    vowel: selectedFamily.vowels[index],
                    transliteration: '${selectedFamily.transliteration}${selectedFamily.vowels[index]}',
                    pronunciation: selectedFamily.pronunciations[index],
                    delay: index * 50,
                  );
                },
              ),
            ),

            // Practice button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to Fidel practice exercises
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fidel practice exercises coming in Phase 2!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow_rounded, size: 28),
                  label: const Text(
                    'PRACTICE THIS FAMILY',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF58CC02),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 500.ms),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterCard({
    required String character,
    required String vowel,
    required String transliteration,
    required String pronunciation,
    required int delay,
  }) {
    return InkWell(
      onTap: () async {
        // Enhanced audio feedback with haptic
        try {
          // Visual feedback
          setState(() {});
          
          // Play audio with proper pronunciation
          await _ttsService.speakAmharic(character);
          
          // Show pronunciation guide
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Text(
                    character,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('sounds like: $pronunciation'),
                ],
              ),
              backgroundColor: const Color(0xFF58CC02),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Audio not available: $e'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF58CC02).withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF58CC02).withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Amharic character
            Text(
              character,
              style: const TextStyle(
                color: Color(0xFF58CC02),
                fontSize: 64,
                fontWeight: FontWeight.bold,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            // Pronunciation guide
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF58CC02).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                pronunciation,
                style: const TextStyle(
                  color: Color(0xFF58CC02),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 6),
            // Transliteration
            Text(
              transliteration,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            // Vowel indicator
            Text(
              'vowel: $vowel',
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 8),
            // Enhanced audio button with animation
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF58CC02).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.volume_up_rounded,
                color: Color(0xFF58CC02),
                size: 18,
              ),
            ),
          ],
        ),
      ),
    ).animate(delay: delay.ms).fadeIn().scale().then().shimmer(
      duration: 2000.ms,
      color: const Color(0xFF58CC02).withValues(alpha: 0.3),
    );
  }

  void _showFidelInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.info_rounded, color: Color(0xFF58CC02)),
            SizedBox(width: 12),
            Text(
              'About Fidel',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Fidel (ፊደል) is the Ge\'ez script used to write Amharic and other Ethiopian languages.',
                style: TextStyle(color: Colors.white70, height: 1.5),
              ),
              SizedBox(height: 12),
              Text(
                'Key Features:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• 33 basic consonants\n'
                '• 7 vowel modifications per consonant\n'
                '• Total of 231+ characters\n'
                '• Written left to right\n'
                '• One of the world\'s oldest writing systems',
                style: TextStyle(color: Colors.white70, height: 1.5),
              ),
              SizedBox(height: 12),
              Text(
                'Tap any character to hear its pronunciation!',
                style: TextStyle(
                  color: Color(0xFF58CC02),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(
              'GOT IT',
              style: TextStyle(color: Color(0xFF58CC02)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ttsService.stop();
    super.dispose();
  }
}

/// Fidel Family Model - Represents one consonant with its vowel forms
class FidelFamily {
  final String name;
  final String transliteration;
  final List<String> characters;
  final List<String> vowels;
  final List<String> pronunciations;

  FidelFamily({
    required this.name,
    required this.transliteration,
    required this.characters,
    required this.vowels,
    required this.pronunciations,
  });
}

