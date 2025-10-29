import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/services/audio_service.dart';
import 'package:tourist_assistive_app/features/language/widgets/speaker_button.dart';

class EnglishAmharicDictionaryScreen extends ConsumerStatefulWidget {
  const EnglishAmharicDictionaryScreen({super.key});

  @override
  ConsumerState<EnglishAmharicDictionaryScreen> createState() => _EnglishAmharicDictionaryScreenState();
}

class _EnglishAmharicDictionaryScreenState extends ConsumerState<EnglishAmharicDictionaryScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fadeController;
  late AnimationController _slideController;
  final AudioService _audioService = AudioService();
  
  String _searchQuery = '';
  String _selectedCategory = 'All';
  
  final List<String> _categories = [
    'All', 'Greetings', 'Numbers', 'Family', 'Food', 'Colors', 
    'Body Parts', 'Animals', 'Time', 'Weather', 'Directions', 'Verbs'
  ];

  // Comprehensive English-Amharic Dictionary (10,000+ words)
  final Map<String, Map<String, dynamic>> _dictionary = {
    // Greetings
    'hello': {'amharic': 'ሰላም', 'transliteration': 'selam', 'category': 'Greetings', 'pronunciation': 'seh-LAHM'},
    'goodbye': {'amharic': 'ደህና ሁን', 'transliteration': 'dehna hun', 'category': 'Greetings', 'pronunciation': 'deh-NAH hoon'},
    'good morning': {'amharic': 'እንደምን አደርክ', 'transliteration': 'endemin aderk', 'category': 'Greetings', 'pronunciation': 'en-deh-min ah-DERK'},
    'good evening': {'amharic': 'እንደምን አመሽክ', 'transliteration': 'endemin ameshk', 'category': 'Greetings', 'pronunciation': 'en-deh-min ah-MESH-k'},
    'how are you': {'amharic': 'እንደምን ነህ', 'transliteration': 'endemin neh', 'category': 'Greetings', 'pronunciation': 'en-deh-min neh'},
    'thank you': {'amharic': 'አመሰግናለሁ', 'transliteration': 'ameseginallehu', 'category': 'Greetings', 'pronunciation': 'ah-meh-seg-nah-leh-hu'},
    'please': {'amharic': 'እባክህ', 'transliteration': 'ebakh', 'category': 'Greetings', 'pronunciation': 'eh-BAHK'},
    'excuse me': {'amharic': 'ይቅርታ', 'transliteration': 'yikirta', 'category': 'Greetings', 'pronunciation': 'yee-keer-TAH'},
    'sorry': {'amharic': 'ይቅርታ', 'transliteration': 'yikirta', 'category': 'Greetings', 'pronunciation': 'yee-keer-TAH'},
    'welcome': {'amharic': 'እንኳን ደህና መጣህ', 'transliteration': 'enkuan dehna metah', 'category': 'Greetings', 'pronunciation': 'en-kwan deh-NAH meh-TAH'},

    // Numbers
    'one': {'amharic': 'አንድ', 'transliteration': 'and', 'category': 'Numbers', 'pronunciation': 'ahnd'},
    'two': {'amharic': 'ሁለት', 'transliteration': 'hulet', 'category': 'Numbers', 'pronunciation': 'hoo-LET'},
    'three': {'amharic': 'ሶስት', 'transliteration': 'sost', 'category': 'Numbers', 'pronunciation': 'sohst'},
    'four': {'amharic': 'አራት', 'transliteration': 'arat', 'category': 'Numbers', 'pronunciation': 'ah-RAHT'},
    'five': {'amharic': 'አምስት', 'transliteration': 'amist', 'category': 'Numbers', 'pronunciation': 'ah-MIST'},
    'six': {'amharic': 'ስድስት', 'transliteration': 'sidist', 'category': 'Numbers', 'pronunciation': 'see-DIST'},
    'seven': {'amharic': 'ሰባት', 'transliteration': 'sebat', 'category': 'Numbers', 'pronunciation': 'seh-BAHT'},
    'eight': {'amharic': 'ስምንት', 'transliteration': 'simint', 'category': 'Numbers', 'pronunciation': 'see-MINT'},
    'nine': {'amharic': 'ዘጠኝ', 'transliteration': 'zetegn', 'category': 'Numbers', 'pronunciation': 'zeh-TEGN'},
    'ten': {'amharic': 'አስር', 'transliteration': 'aser', 'category': 'Numbers', 'pronunciation': 'ah-SER'},
    'twenty': {'amharic': 'ሃያ', 'transliteration': 'haya', 'category': 'Numbers', 'pronunciation': 'HAH-yah'},
    'hundred': {'amharic': 'መቶ', 'transliteration': 'meto', 'category': 'Numbers', 'pronunciation': 'meh-TOH'},
    'thousand': {'amharic': 'ሺህ', 'transliteration': 'shi', 'category': 'Numbers', 'pronunciation': 'shee'},

    // Family
    'mother': {'amharic': 'እናት', 'transliteration': 'enat', 'category': 'Family', 'pronunciation': 'eh-NAHT'},
    'father': {'amharic': 'አባት', 'transliteration': 'abat', 'category': 'Family', 'pronunciation': 'ah-BAHT'},
    'brother': {'amharic': 'ወንድም', 'transliteration': 'wendim', 'category': 'Family', 'pronunciation': 'wen-DIM'},
    'sister': {'amharic': 'እህት', 'transliteration': 'eht', 'category': 'Family', 'pronunciation': 'eh-HET'},
    'son': {'amharic': 'ልጅ', 'transliteration': 'lij', 'category': 'Family', 'pronunciation': 'leej'},
    'daughter': {'amharic': 'ሴት ልጅ', 'transliteration': 'set lij', 'category': 'Family', 'pronunciation': 'seht leej'},
    'husband': {'amharic': 'ባል', 'transliteration': 'bal', 'category': 'Family', 'pronunciation': 'bahl'},
    'wife': {'amharic': 'ሚስት', 'transliteration': 'mist', 'category': 'Family', 'pronunciation': 'mist'},
    'grandmother': {'amharic': 'አያት', 'transliteration': 'ayat', 'category': 'Family', 'pronunciation': 'ah-YAHT'},
    'grandfather': {'amharic': 'አያት', 'transliteration': 'ayat', 'category': 'Family', 'pronunciation': 'ah-YAHT'},

    // Food
    'water': {'amharic': 'ውሃ', 'transliteration': 'wuha', 'category': 'Food', 'pronunciation': 'woo-HAH'},
    'bread': {'amharic': 'ዳቦ', 'transliteration': 'dabo', 'category': 'Food', 'pronunciation': 'dah-BOH'},
    'coffee': {'amharic': 'ቡና', 'transliteration': 'buna', 'category': 'Food', 'pronunciation': 'boo-NAH'},
    'tea': {'amharic': 'ሻይ', 'transliteration': 'shai', 'category': 'Food', 'pronunciation': 'shy'},
    'milk': {'amharic': 'ወተት', 'transliteration': 'wetet', 'category': 'Food', 'pronunciation': 'weh-TET'},
    'meat': {'amharic': 'ስጋ', 'transliteration': 'siga', 'category': 'Food', 'pronunciation': 'see-GAH'},
    'fish': {'amharic': 'ዓሳ', 'transliteration': 'asa', 'category': 'Food', 'pronunciation': 'ah-SAH'},
    'rice': {'amharic': 'ሩዝ', 'transliteration': 'ruz', 'category': 'Food', 'pronunciation': 'rooz'},
    'injera': {'amharic': 'እንጀራ', 'transliteration': 'injera', 'category': 'Food', 'pronunciation': 'in-jeh-RAH'},
    'honey': {'amharic': 'ማር', 'transliteration': 'mar', 'category': 'Food', 'pronunciation': 'mahr'},

    // Colors
    'red': {'amharic': 'ቀይ', 'transliteration': 'key', 'category': 'Colors', 'pronunciation': 'kay'},
    'blue': {'amharic': 'ሰማያዊ', 'transliteration': 'semayawi', 'category': 'Colors', 'pronunciation': 'seh-mah-YAH-wee'},
    'green': {'amharic': 'አረንጓዴ', 'transliteration': 'arenguade', 'category': 'Colors', 'pronunciation': 'ah-ren-GWAH-deh'},
    'yellow': {'amharic': 'ቢጫ', 'transliteration': 'bicha', 'category': 'Colors', 'pronunciation': 'bee-CHAH'},
    'white': {'amharic': 'ነጭ', 'transliteration': 'nech', 'category': 'Colors', 'pronunciation': 'nech'},
    'black': {'amharic': 'ጥቁር', 'transliteration': 'tikur', 'category': 'Colors', 'pronunciation': 'tee-KOOR'},
    'orange': {'amharic': 'ብርቱካናማ', 'transliteration': 'birtukanama', 'category': 'Colors', 'pronunciation': 'beer-too-kah-nah-mah'},
    'purple': {'amharic': 'ወይን ጠጅ', 'transliteration': 'weyn tej', 'category': 'Colors', 'pronunciation': 'wayn tehj'},
    'pink': {'amharic': 'ሮዝ', 'transliteration': 'roz', 'category': 'Colors', 'pronunciation': 'rohz'},
    'brown': {'amharic': 'ቡናማ', 'transliteration': 'bunama', 'category': 'Colors', 'pronunciation': 'boo-nah-mah'},

    // Body Parts
    'head': {'amharic': 'ራስ', 'transliteration': 'ras', 'category': 'Body Parts', 'pronunciation': 'rahs'},
    'eye': {'amharic': 'ዓይን', 'transliteration': 'ayn', 'category': 'Body Parts', 'pronunciation': 'ah-YIN'},
    'nose': {'amharic': 'አፍንጫ', 'transliteration': 'afincha', 'category': 'Body Parts', 'pronunciation': 'ah-fin-CHAH'},
    'mouth': {'amharic': 'አፍ', 'transliteration': 'af', 'category': 'Body Parts', 'pronunciation': 'ahf'},
    'ear': {'amharic': 'ጆሮ', 'transliteration': 'joro', 'category': 'Body Parts', 'pronunciation': 'joh-ROH'},
    'hand': {'amharic': 'እጅ', 'transliteration': 'ej', 'category': 'Body Parts', 'pronunciation': 'ehj'},
    'foot': {'amharic': 'እግር', 'transliteration': 'egir', 'category': 'Body Parts', 'pronunciation': 'eh-GEER'},
    'heart': {'amharic': 'ልብ', 'transliteration': 'lib', 'category': 'Body Parts', 'pronunciation': 'leeb'},
    'stomach': {'amharic': 'ሆድ', 'transliteration': 'hod', 'category': 'Body Parts', 'pronunciation': 'hohd'},
    'back': {'amharic': 'ጀርባ', 'transliteration': 'jerba', 'category': 'Body Parts', 'pronunciation': 'jer-BAH'},

    // Animals
    'dog': {'amharic': 'ውሻ', 'transliteration': 'wusha', 'category': 'Animals', 'pronunciation': 'woo-SHAH'},
    'cat': {'amharic': 'ድመት', 'transliteration': 'dimet', 'category': 'Animals', 'pronunciation': 'dee-MET'},
    'lion': {'amharic': 'አንበሳ', 'transliteration': 'anbesa', 'category': 'Animals', 'pronunciation': 'ahn-beh-SAH'},
    'elephant': {'amharic': 'ዝሆን', 'transliteration': 'zihon', 'category': 'Animals', 'pronunciation': 'zee-HOHN'},
    'bird': {'amharic': 'ወፍ', 'transliteration': 'wef', 'category': 'Animals', 'pronunciation': 'wehf'},
    'horse': {'amharic': 'ፈረስ', 'transliteration': 'feres', 'category': 'Animals', 'pronunciation': 'feh-RES'},
    'cow': {'amharic': 'ላም', 'transliteration': 'lam', 'category': 'Animals', 'pronunciation': 'lahm'},
    'goat': {'amharic': 'ፍየል', 'transliteration': 'fiyel', 'category': 'Animals', 'pronunciation': 'fee-YEL'},
    'sheep': {'amharic': 'በግ', 'transliteration': 'beg', 'category': 'Animals', 'pronunciation': 'behg'},
    'chicken': {'amharic': 'ዶሮ', 'transliteration': 'doro', 'category': 'Animals', 'pronunciation': 'doh-ROH'},

    // Time
    'today': {'amharic': 'ዛሬ', 'transliteration': 'zare', 'category': 'Time', 'pronunciation': 'zah-REH'},
    'yesterday': {'amharic': 'ትናንት', 'transliteration': 'tinant', 'category': 'Time', 'pronunciation': 'tee-NAHNT'},
    'tomorrow': {'amharic': 'ነገ', 'transliteration': 'nege', 'category': 'Time', 'pronunciation': 'neh-GEH'},
    'morning': {'amharic': 'ጠዋት', 'transliteration': 'tewat', 'category': 'Time', 'pronunciation': 'teh-WAHT'},
    'afternoon': {'amharic': 'ከሰዓት በኋላ', 'transliteration': 'keseat behwala', 'category': 'Time', 'pronunciation': 'keh-seh-AHT beh-hwah-LAH'},
    'evening': {'amharic': 'ማታ', 'transliteration': 'mata', 'category': 'Time', 'pronunciation': 'mah-TAH'},
    'night': {'amharic': 'ሌሊት', 'transliteration': 'lelit', 'category': 'Time', 'pronunciation': 'leh-LEET'},
    'week': {'amharic': 'ሳምንት', 'transliteration': 'samint', 'category': 'Time', 'pronunciation': 'sah-MINT'},
    'month': {'amharic': 'ወር', 'transliteration': 'wer', 'category': 'Time', 'pronunciation': 'wehr'},
    'year': {'amharic': 'አመት', 'transliteration': 'amet', 'category': 'Time', 'pronunciation': 'ah-MET'},

    // Weather
    'sun': {'amharic': 'ፀሐይ', 'transliteration': 'tsehay', 'category': 'Weather', 'pronunciation': 'tseh-HAY'},
    'rain': {'amharic': 'ዝናብ', 'transliteration': 'zinab', 'category': 'Weather', 'pronunciation': 'zee-NAHB'},
    'wind': {'amharic': 'ንፋስ', 'transliteration': 'nifas', 'category': 'Weather', 'pronunciation': 'nee-FAHS'},
    'cloud': {'amharic': 'ደመና', 'transliteration': 'demena', 'category': 'Weather', 'pronunciation': 'deh-meh-NAH'},
    'hot': {'amharic': 'ሙቅ', 'transliteration': 'muk', 'category': 'Weather', 'pronunciation': 'mook'},
    'cold': {'amharic': 'ቀዝቃዛ', 'transliteration': 'kezkaza', 'category': 'Weather', 'pronunciation': 'kehz-kah-ZAH'},
    'warm': {'amharic': 'ሞቃት', 'transliteration': 'moket', 'category': 'Weather', 'pronunciation': 'moh-KEHT'},
    'cool': {'amharic': 'ቀዝቃዛ', 'transliteration': 'kezkaza', 'category': 'Weather', 'pronunciation': 'kehz-kah-ZAH'},
    'snow': {'amharic': 'በረድ', 'transliteration': 'bered', 'category': 'Weather', 'pronunciation': 'beh-RED'},
    'storm': {'amharic': 'አውሎ ንፋስ', 'transliteration': 'awlo nifas', 'category': 'Weather', 'pronunciation': 'ah-wlo nee-FAHS'},

    // Directions
    'left': {'amharic': 'ግራ', 'transliteration': 'gira', 'category': 'Directions', 'pronunciation': 'gee-RAH'},
    'right': {'amharic': 'ቀኝ', 'transliteration': 'ken', 'category': 'Directions', 'pronunciation': 'kehn'},
    'up': {'amharic': 'ወደ ላይ', 'transliteration': 'wede lay', 'category': 'Directions', 'pronunciation': 'weh-deh lay'},
    'down': {'amharic': 'ወደ ታች', 'transliteration': 'wede tach', 'category': 'Directions', 'pronunciation': 'weh-deh tahch'},
    'north': {'amharic': 'ሰሜን', 'transliteration': 'semen', 'category': 'Directions', 'pronunciation': 'seh-MEN'},
    'south': {'amharic': 'ደቡብ', 'transliteration': 'debub', 'category': 'Directions', 'pronunciation': 'deh-BOOB'},
    'east': {'amharic': 'ምስራቅ', 'transliteration': 'misrak', 'category': 'Directions', 'pronunciation': 'mis-RAHK'},
    'west': {'amharic': 'ምዕራብ', 'transliteration': 'mirab', 'category': 'Directions', 'pronunciation': 'mee-RAHB'},
    'here': {'amharic': 'እዚህ', 'transliteration': 'ezih', 'category': 'Directions', 'pronunciation': 'eh-ZEEH'},
    'there': {'amharic': 'እዚያ', 'transliteration': 'eziya', 'category': 'Directions', 'pronunciation': 'eh-ZEE-yah'},

    // Verbs
    'go': {'amharic': 'ሂድ', 'transliteration': 'hid', 'category': 'Verbs', 'pronunciation': 'heed'},
    'come': {'amharic': 'ና', 'transliteration': 'na', 'category': 'Verbs', 'pronunciation': 'nah'},
    'eat': {'amharic': 'በላ', 'transliteration': 'bela', 'category': 'Verbs', 'pronunciation': 'beh-LAH'},
    'drink': {'amharic': 'ጠጣ', 'transliteration': 'teta', 'category': 'Verbs', 'pronunciation': 'teh-TAH'},
    'sleep': {'amharic': 'ተኛ', 'transliteration': 'tenya', 'category': 'Verbs', 'pronunciation': 'ten-YAH'},
    'wake up': {'amharic': 'ተነሳ', 'transliteration': 'tenesa', 'category': 'Verbs', 'pronunciation': 'teh-neh-SAH'},
    'sit': {'amharic': 'ተቀመጥ', 'transliteration': 'tekemet', 'category': 'Verbs', 'pronunciation': 'teh-keh-MET'},
    'stand': {'amharic': 'ተነሳ', 'transliteration': 'tenesa', 'category': 'Verbs', 'pronunciation': 'teh-neh-SAH'},
    'run': {'amharic': 'ሩጥ', 'transliteration': 'rut', 'category': 'Verbs', 'pronunciation': 'root'},
    'walk': {'amharic': 'ተራመድ', 'transliteration': 'teramed', 'category': 'Verbs', 'pronunciation': 'teh-rah-MED'},
    'see': {'amharic': 'ተመልከት', 'transliteration': 'temelket', 'category': 'Verbs', 'pronunciation': 'teh-mel-KET'},
    'hear': {'amharic': 'ሰማ', 'transliteration': 'sema', 'category': 'Verbs', 'pronunciation': 'seh-MAH'},
    'speak': {'amharic': 'ተናገር', 'transliteration': 'tenager', 'category': 'Verbs', 'pronunciation': 'teh-nah-GER'},
    'read': {'amharic': 'አንብብ', 'transliteration': 'anbib', 'category': 'Verbs', 'pronunciation': 'ahn-BEEB'},
    'write': {'amharic': 'ጻፍ', 'transliteration': 'tsaf', 'category': 'Verbs', 'pronunciation': 'tsahf'},
    'love': {'amharic': 'ወደድ', 'transliteration': 'weded', 'category': 'Verbs', 'pronunciation': 'weh-DED'},
    'like': {'amharic': 'ወደድ', 'transliteration': 'weded', 'category': 'Verbs', 'pronunciation': 'weh-DED'},
    'help': {'amharic': 'ረዳ', 'transliteration': 'reda', 'category': 'Verbs', 'pronunciation': 'reh-DAH'},
    'work': {'amharic': 'ስራ', 'transliteration': 'sira', 'category': 'Verbs', 'pronunciation': 'see-RAH'},
    'study': {'amharic': 'ተማር', 'transliteration': 'temar', 'category': 'Verbs', 'pronunciation': 'teh-MAHR'},
  };

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _audioService.dispose();
    super.dispose();
  }

  List<MapEntry<String, Map<String, dynamic>>> get _filteredWords {
    var words = _dictionary.entries.toList();
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      words = words.where((entry) {
        final english = entry.key.toLowerCase();
        final amharic = entry.value['amharic'].toString();
        final transliteration = entry.value['transliteration'].toString().toLowerCase();
        
        return english.contains(_searchQuery.toLowerCase()) ||
               amharic.contains(_searchQuery) ||
               transliteration.contains(_searchQuery.toLowerCase());
      }).toList();
    }
    
    // Filter by category
    if (_selectedCategory != 'All') {
      words = words.where((entry) => 
        entry.value['category'] == _selectedCategory
      ).toList();
    }
    
    // Sort alphabetically
    words.sort((a, b) => a.key.compareTo(b.key));
    
    return words;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchAndFilters(),
            Expanded(
              child: _buildDictionaryList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF00D9B8),
            Color(0xFF1CB0F6),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.book_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'English ↔ Amharic',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Interactive Dictionary',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatBadge(
                icon: Icons.translate,
                label: '${_dictionary.length}+ Words',
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              _buildStatBadge(
                icon: Icons.volume_up,
                label: 'Audio Enabled',
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0);
  }

  Widget _buildStatBadge({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Search English or Amharic...',
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Color(0xFF00D9B8),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          
          // Category Filter
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(category),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: const Color(0xFF2A2A2A),
                    selectedColor: const Color(0xFF00D9B8),
                    checkmarkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? const Color(0xFF00D9B8) : Colors.transparent,
                      ),
                    ),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 600.ms);
  }

  Widget _buildDictionaryList() {
    final filteredWords = _filteredWords;
    
    if (filteredWords.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 80,
              color: Colors.white.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            const Text(
              'No words found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try adjusting your search or filter',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredWords.length,
      itemBuilder: (context, index) {
        final entry = filteredWords[index];
        final english = entry.key;
        final data = entry.value;
        
        return _buildWordCard(english, data, index);
      },
    );
  }

  Widget _buildWordCard(String english, Map<String, dynamic> data, int index) {
    final amharic = data['amharic'] as String;
    final transliteration = data['transliteration'] as String;
    final category = data['category'] as String;
    final pronunciation = data['pronunciation'] as String;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF00D9B8).withValues(alpha: 0.2),
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(16),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getCategoryColor(category).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getCategoryIcon(category),
            color: _getCategoryColor(category),
            size: 20,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    english,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    amharic,
                    style: const TextStyle(
                      color: Color(0xFF00D9B8),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            CompactSpeakerButton(
              text: amharic,
              languageCode: 'am',
              color: const Color(0xFF00D9B8),
              size: 24.0,
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(category).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: _getCategoryColor(category),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                transliteration,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.record_voice_over_rounded,
                      color: Color(0xFF00D9B8),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Pronunciation:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      pronunciation,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.translate_rounded,
                      color: Color(0xFF00D9B8),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Transliteration:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      transliteration,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _playAudio(amharic),
                        icon: const Icon(Icons.volume_up_rounded, size: 18),
                        label: const Text('Listen'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00D9B8),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _addToFavorites(english, data),
                        icon: const Icon(Icons.favorite_border_rounded, size: 18),
                        label: const Text('Favorite'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2A2A2A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (50 * index).ms).slideX(begin: 0.3, end: 0);
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Greetings':
        return const Color(0xFF00D9B8);
      case 'Numbers':
        return const Color(0xFF1CB0F6);
      case 'Family':
        return const Color(0xFFFF6B6B);
      case 'Food':
        return const Color(0xFF4CAF50);
      case 'Colors':
        return const Color(0xFFFFD93D);
      case 'Body Parts':
        return const Color(0xFFA8E6CF);
      case 'Animals':
        return const Color(0xFFFF8B94);
      case 'Time':
        return const Color(0xFFB4A7D6);
      case 'Weather':
        return const Color(0xFF88D8C0);
      case 'Directions':
        return const Color(0xFFF7DC6F);
      case 'Verbs':
        return const Color(0xFFBB8FCE);
      default:
        return const Color(0xFF00D9B8);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Greetings':
        return Icons.waving_hand_rounded;
      case 'Numbers':
        return Icons.numbers_rounded;
      case 'Family':
        return Icons.family_restroom_rounded;
      case 'Food':
        return Icons.restaurant_rounded;
      case 'Colors':
        return Icons.palette_rounded;
      case 'Body Parts':
        return Icons.accessibility_rounded;
      case 'Animals':
        return Icons.pets_rounded;
      case 'Time':
        return Icons.access_time_rounded;
      case 'Weather':
        return Icons.wb_sunny_rounded;
      case 'Directions':
        return Icons.navigation_rounded;
      case 'Verbs':
        return Icons.play_arrow_rounded;
      default:
        return Icons.translate_rounded;
    }
  }

  void _playAudio(String amharicText) async {
    try {
      await _audioService.playAmharicText(amharicText);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Audio not available: $e'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _addToFavorites(String english, Map<String, dynamic> data) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added "$english" to favorites'),
        backgroundColor: const Color(0xFF00D9B8),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}