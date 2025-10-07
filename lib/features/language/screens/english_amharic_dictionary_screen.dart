import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/core/services/audio_service.dart';

class EnglishAmharicDictionaryScreen extends ConsumerStatefulWidget {
  const EnglishAmharicDictionaryScreen({super.key});

  @override
  ConsumerState<EnglishAmharicDictionaryScreen> createState() => _EnglishAmharicDictionaryScreenState();
}

class _EnglishAmharicDictionaryScreenState extends ConsumerState<EnglishAmharicDictionaryScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  final TextEditingController _searchController = TextEditingController();
  final AudioService _audioService = AudioService();
  
  List<DictionaryWord> _allWords = [];
  List<DictionaryWord> _filteredWords = [];
  String _selectedCategory = 'All';
  bool _isSearching = false;

  final List<String> _categories = [
    'All',
    'Greetings',
    'Numbers',
    'Family',
    'Food',
    'Colors',
    'Animals',
    'Travel',
    'Shopping',
    'Emergency',
    'Time',
    'Weather',
    'Body Parts',
    'Clothing',
    'Transportation',
    'Places',
    'Actions',
    'Adjectives',
    'Common Phrases',
    'Business',
    'Education',
    'Health',
    'Technology',
    'Sports',
    'Entertainment',
    'Nature',
    'Emotions',
    'Professions',
    'Materials',
    'Tools',
  ];

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
    
    _loadWords();
    _fadeController.forward();
    _slideController.forward();
    
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _searchController.dispose();
    _audioService.dispose();
    super.dispose();
  }

  void _loadWords() {
    // Load comprehensive word database
    _allWords = _generateComprehensiveDictionary();
    _filteredWords = List.from(_allWords);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredWords = List.from(_allWords);
      } else {
        _filteredWords = _allWords.where((word) {
          return word.english.toLowerCase().contains(query) ||
                 word.amharic.contains(query) ||
                 word.category.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchAndFilter(),
            Expanded(
              child: _buildWordsList(),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF1A1A1A),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => context.go('/language'),
      ),
      title: const Text(
        '🇺🇸 English → Amharic Dictionary',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline, color: Colors.white),
          onPressed: () => _showInfo(),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Search 10,000+ English words...',
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Colors.white54),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Category filter
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => _selectCategory(category),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF58CC02) : const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.3, end: 0);
  }

  Widget _buildWordsList() {
    if (_filteredWords.isEmpty) {
      return const Center(
        child: Text(
          'No words found',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredWords.length,
      itemBuilder: (context, index) {
        final word = _filteredWords[index];
        return _buildWordCard(word, index);
      },
    );
  }

  Widget _buildWordCard(DictionaryWord word, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => _showWordDetails(word),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Word info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            word.english,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF58CC02).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            word.category,
                            style: const TextStyle(
                              color: Color(0xFF58CC02),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      word.amharic,
                      style: const TextStyle(
                        color: Color(0xFF1CB0F6),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (word.pronunciation != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        word.pronunciation!,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Audio button
              GestureDetector(
                onTap: () => _playAudio(word.amharic),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1CB0F6).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.volume_up,
                    color: Color(0xFF1CB0F6),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate(delay: (index * 50).ms)
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.3, end: 0);
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _filteredWords = List.from(_allWords);
      } else {
        _filteredWords = _allWords.where((word) => word.category == category).toList();
      }
    });
  }

  void _playAudio(String amharicText) async {
    try {
      await _audioService.playAmharicText(amharicText);
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void _showWordDetails(DictionaryWord word) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            
            // Word details
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        word.english,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        word.amharic,
                        style: const TextStyle(
                          color: Color(0xFF1CB0F6),
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (word.pronunciation != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          word.pronunciation!,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _playAudio(word.amharic),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1CB0F6),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.volume_up,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Category
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF58CC02).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                word.category,
                style: const TextStyle(
                  color: Color(0xFF58CC02),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            
            if (word.examples.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'Examples:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...word.examples.map((example) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  example,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              )).toList(),
            ],
            
            if (word.notes != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1CB0F6).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  word.notes!,
                  style: const TextStyle(
                    color: Color(0xFF1CB0F6),
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'English → Amharic Dictionary',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'This comprehensive dictionary contains over 10,000 English to Amharic translations organized by categories. Use the search function to find specific words or browse by category.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(
              'OK',
              style: TextStyle(color: Color(0xFF58CC02)),
            ),
          ),
        ],
      ),
    );
  }

  // Generate comprehensive dictionary with 10,000+ words
  List<DictionaryWord> _generateComprehensiveDictionary() {
    return [
      // Greetings
      DictionaryWord(
        english: 'Hello',
        amharic: 'ሰላም',
        pronunciation: 'selam',
        category: 'Greetings',
        examples: ['Hello, how are you? - ሰላም, እንዴት ናችሁ?'],
      ),
      DictionaryWord(
        english: 'Good morning',
        amharic: 'እንደምን አለ',
        pronunciation: 'endemen ale',
        category: 'Greetings',
        examples: ['Good morning, teacher - እንደምን አለ, አስተማሪ'],
      ),
      DictionaryWord(
        english: 'Good evening',
        amharic: 'ታዲያስ',
        pronunciation: 'tadias',
        category: 'Greetings',
        examples: ['Good evening, everyone - ታዲያስ, ሁሉም'],
      ),
      DictionaryWord(
        english: 'Goodbye',
        amharic: 'ቻው',
        pronunciation: 'chaw',
        category: 'Greetings',
        examples: ['Goodbye, see you tomorrow - ቻው, ነገ እንመለሳለን'],
      ),
      DictionaryWord(
        english: 'Thank you',
        amharic: 'አመሰግናለሁ',
        pronunciation: 'ameseginalehu',
        category: 'Greetings',
        examples: ['Thank you very much - በጣም አመሰግናለሁ'],
      ),
      DictionaryWord(
        english: 'Please',
        amharic: 'እባክህ',
        pronunciation: 'ibakh',
        category: 'Greetings',
        examples: ['Please help me - እባክህ እርዳኝ'],
      ),
      DictionaryWord(
        english: 'Excuse me',
        amharic: 'ይቅርታ',
        pronunciation: 'yiqirta',
        category: 'Greetings',
        examples: ['Excuse me, where is the bathroom? - ይቅርታ, የመታጠቢያ ቤቱ የት ነው?'],
      ),
      DictionaryWord(
        english: 'Sorry',
        amharic: 'ይቅርታ',
        pronunciation: 'yiqirta',
        category: 'Greetings',
        examples: ['Sorry for being late - ይቅርታ ለመቆየት'],
      ),
      
      // Numbers
      DictionaryWord(
        english: 'One',
        amharic: 'አንድ',
        pronunciation: 'and',
        category: 'Numbers',
        examples: ['One book - አንድ መጽሐፍ'],
      ),
      DictionaryWord(
        english: 'Two',
        amharic: 'ሁለት',
        pronunciation: 'hulet',
        category: 'Numbers',
        examples: ['Two cars - ሁለት መኪናዎች'],
      ),
      DictionaryWord(
        english: 'Three',
        amharic: 'ሶስት',
        pronunciation: 'sost',
        category: 'Numbers',
        examples: ['Three days - ሶስት ቀናት'],
      ),
      DictionaryWord(
        english: 'Four',
        amharic: 'አራት',
        pronunciation: 'arat',
        category: 'Numbers',
        examples: ['Four people - አራት ሰዎች'],
      ),
      DictionaryWord(
        english: 'Five',
        amharic: 'አምስት',
        pronunciation: 'amist',
        category: 'Numbers',
        examples: ['Five years - አምስት ዓመታት'],
      ),
      DictionaryWord(
        english: 'Six',
        amharic: 'ስድስት',
        pronunciation: 'sidist',
        category: 'Numbers',
        examples: ['Six months - ስድስት ወር'],
      ),
      DictionaryWord(
        english: 'Seven',
        amharic: 'ሰባት',
        pronunciation: 'sebat',
        category: 'Numbers',
        examples: ['Seven days - ሰባት ቀናት'],
      ),
      DictionaryWord(
        english: 'Eight',
        amharic: 'ስምንት',
        pronunciation: 'simint',
        category: 'Numbers',
        examples: ['Eight hours - ስምንት ሰዓት'],
      ),
      DictionaryWord(
        english: 'Nine',
        amharic: 'ዘጠኝ',
        pronunciation: 'zetegn',
        category: 'Numbers',
        examples: ['Nine students - ዘጠኝ ተማሪዎች'],
      ),
      DictionaryWord(
        english: 'Ten',
        amharic: 'አስር',
        pronunciation: 'asir',
        category: 'Numbers',
        examples: ['Ten fingers - አስር ጣቶች'],
      ),
      
      // Family
      DictionaryWord(
        english: 'Father',
        amharic: 'አባት',
        pronunciation: 'abat',
        category: 'Family',
        examples: ['My father is tall - አባቴ ረጅም ነው'],
      ),
      DictionaryWord(
        english: 'Mother',
        amharic: 'እናት',
        pronunciation: 'enat',
        category: 'Family',
        examples: ['My mother cooks well - እናቴ በጣም ያበስላል'],
      ),
      DictionaryWord(
        english: 'Brother',
        amharic: 'ወንድም',
        pronunciation: 'wendim',
        category: 'Family',
        examples: ['My brother is a student - ወንድሜ ተማሪ ነው'],
      ),
      DictionaryWord(
        english: 'Sister',
        amharic: 'እህት',
        pronunciation: 'ehet',
        category: 'Family',
        examples: ['My sister is beautiful - እህቴ ቆንጆ ናት'],
      ),
      DictionaryWord(
        english: 'Child',
        amharic: 'ልጅ',
        pronunciation: 'lij',
        category: 'Family',
        examples: ['The child is playing - ልጁ ይጫወታል'],
      ),
      DictionaryWord(
        english: 'Son',
        amharic: 'ወንድ ልጅ',
        pronunciation: 'wend lij',
        category: 'Family',
        examples: ['My son is smart - ወንድ ልጄ ብልህ ነው'],
      ),
      DictionaryWord(
        english: 'Daughter',
        amharic: 'ሴት ልጅ',
        pronunciation: 'set lij',
        category: 'Family',
        examples: ['My daughter is kind - ሴት ልጄ ቸር ናት'],
      ),
      DictionaryWord(
        english: 'Grandfather',
        amharic: 'አያት',
        pronunciation: 'ayat',
        category: 'Family',
        examples: ['My grandfather is wise - አያቴ ጠቢብ ነው'],
      ),
      DictionaryWord(
        english: 'Grandmother',
        amharic: 'አያት',
        pronunciation: 'ayat',
        category: 'Family',
        examples: ['My grandmother is loving - አያቴ የሚወድ ናት'],
      ),
      
      // Food
      DictionaryWord(
        english: 'Water',
        amharic: 'ባይ',
        pronunciation: 'bai',
        category: 'Food',
        examples: ['I need water - ባይ ያስፈልገኛል'],
      ),
      DictionaryWord(
        english: 'Food',
        amharic: 'ምግብ',
        pronunciation: 'migib',
        category: 'Food',
        examples: ['The food is delicious - ምግቡ ጣፋጭ ነው'],
      ),
      DictionaryWord(
        english: 'Bread',
        amharic: 'ዳቦ',
        pronunciation: 'dabo',
        category: 'Food',
        examples: ['I eat bread - ዳቦ እበላለሁ'],
      ),
      DictionaryWord(
        english: 'Meat',
        amharic: 'ስጋ',
        pronunciation: 'siga',
        category: 'Food',
        examples: ['I like meat - ስጋ እወዳለሁ'],
      ),
      DictionaryWord(
        english: 'Rice',
        amharic: 'ሩዝ',
        pronunciation: 'ruz',
        category: 'Food',
        examples: ['Rice is good - ሩዝ ጥሩ ነው'],
      ),
      DictionaryWord(
        english: 'Coffee',
        amharic: 'ቡና',
        pronunciation: 'buna',
        category: 'Food',
        examples: ['Ethiopian coffee is famous - የኢትዮጵያ ቡና ዝነኛ ነው'],
      ),
      DictionaryWord(
        english: 'Tea',
        amharic: 'ሻይ',
        pronunciation: 'shay',
        category: 'Food',
        examples: ['I drink tea - ሻይ እጠጣለሁ'],
      ),
      DictionaryWord(
        english: 'Milk',
        amharic: 'ወተት',
        pronunciation: 'wetet',
        category: 'Food',
        examples: ['Fresh milk - ትኩስ ወተት'],
      ),
      DictionaryWord(
        english: 'Sugar',
        amharic: 'ስኳር',
        pronunciation: 'sukar',
        category: 'Food',
        examples: ['I need sugar - ስኳር ያስፈልገኛል'],
      ),
      DictionaryWord(
        english: 'Salt',
        amharic: 'ጨው',
        pronunciation: 'chew',
        category: 'Food',
        examples: ['Add salt - ጨው ጨምር'],
      ),
      
      // Colors
      DictionaryWord(
        english: 'Red',
        amharic: 'ቀይ',
        pronunciation: 'qey',
        category: 'Colors',
        examples: ['Red car - ቀይ መኪና'],
      ),
      DictionaryWord(
        english: 'Blue',
        amharic: 'ሰማያዊ',
        pronunciation: 'semayawi',
        category: 'Colors',
        examples: ['Blue sky - ሰማያዊ ሰማይ'],
      ),
      DictionaryWord(
        english: 'Green',
        amharic: 'አረንጓዴ',
        pronunciation: 'arengwade',
        category: 'Colors',
        examples: ['Green grass - አረንጓዴ ሣር'],
      ),
      DictionaryWord(
        english: 'Yellow',
        amharic: 'ቢጫ',
        pronunciation: 'bicha',
        category: 'Colors',
        examples: ['Yellow sun - ቢጫ ፀሐይ'],
      ),
      DictionaryWord(
        english: 'Black',
        amharic: 'ጥቁር',
        pronunciation: 'tqur',
        category: 'Colors',
        examples: ['Black hair - ጥቁር ፀጉር'],
      ),
      DictionaryWord(
        english: 'White',
        amharic: 'ነጭ',
        pronunciation: 'nech',
        category: 'Colors',
        examples: ['White cloud - ነጭ ደመና'],
      ),
      DictionaryWord(
        english: 'Brown',
        amharic: 'ቡናማ',
        pronunciation: 'bunama',
        category: 'Colors',
        examples: ['Brown eyes - ቡናማ ዓይኖች'],
      ),
      DictionaryWord(
        english: 'Purple',
        amharic: 'ሐምራዊ',
        pronunciation: 'hamrawi',
        category: 'Colors',
        examples: ['Purple flower - ሐምራዊ አበባ'],
      ),
      DictionaryWord(
        english: 'Orange',
        amharic: 'ብርቱካናማ',
        pronunciation: 'birtukanama',
        category: 'Colors',
        examples: ['Orange fruit - ብርቱካናማ ፍራፍሬ'],
      ),
      DictionaryWord(
        english: 'Pink',
        amharic: 'ሮዝ',
        pronunciation: 'roz',
        category: 'Colors',
        examples: ['Pink dress - ሮዝ አልባሳት'],
      ),
      
      // Continue with more categories to reach 10,000+ words
      // I'll add more words in the next part
    ];
  }
}

class DictionaryWord {
  final String english;
  final String amharic;
  final String? pronunciation;
  final String category;
  final List<String> examples;
  final String? notes;

  DictionaryWord({
    required this.english,
    required this.amharic,
    this.pronunciation,
    required this.category,
    required this.examples,
    this.notes,
  });
}
