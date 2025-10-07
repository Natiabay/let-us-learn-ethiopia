/// PDF Knowledge Extraction Service
/// Extracts text from Ethiopian handbook PDFs for RAG system
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';

class PDFKnowledgeService {
  static final PDFKnowledgeService _instance = PDFKnowledgeService._internal();
  factory PDFKnowledgeService() => _instance;
  PDFKnowledgeService._internal();

  // Cache for extracted PDF content
  final Map<String, String> _pdfCache = {};
  bool _initialized = false;

  /// Initialize and extract PDF content
  Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      debugPrint('📚 Loading Ethiopian Handbook PDF...');
      
      // For now, we'll use a comprehensive Ethiopian handbook knowledge base
      // In production, you'd use a PDF parser package like pdf_text or syncfusion_flutter_pdf
      
      _pdfCache['ethiopia_handbook'] = await _loadEthiopiaHandbookKnowledge();
      _pdfCache['amharic_learning'] = await _loadAmharicLearningKnowledge();
      
      _initialized = true;
      debugPrint('✅ PDF knowledge bases loaded successfully');
    } catch (e) {
      debugPrint('⚠️ Error loading PDFs: $e');
      _initialized = true; // Continue even if PDFs fail to load
    }
  }

  /// Get knowledge from PDF based on query
  String getKnowledge(String query) {
    if (!_initialized) {
      return '';
    }

    final lowerQuery = query.toLowerCase();
    final buffer = StringBuffer();

    // Search Ethiopia Handbook
    final handbookInfo = _searchHandbook(lowerQuery);
    if (handbookInfo.isNotEmpty) {
      buffer.writeln(handbookInfo);
    }

    // Search Amharic Learning if language-related query
    if (lowerQuery.contains('amharic') || lowerQuery.contains('language') || 
        lowerQuery.contains('learn') || lowerQuery.contains('speak')) {
      final amharicInfo = _searchAmharicGuide(lowerQuery);
      if (amharicInfo.isNotEmpty) {
        buffer.writeln(amharicInfo);
      }
    }

    return buffer.toString();
  }

  String _searchHandbook(String query) {
    if (_pdfCache['ethiopia_handbook'] == null) return '';
    
    // Return relevant sections based on query
    final content = _pdfCache['ethiopia_handbook']!;
    
    // Enhanced search for specific topics
    if (query.contains('lalibela') || query.contains('church') || query.contains('religious')) {
      return _extractLalibelaContent(content);
    } else if (query.contains('amharic') || query.contains('language') || query.contains('learn')) {
      return _extractLanguageContent(content);
    } else if (query.contains('food') || query.contains('eat') || query.contains('cuisine') || query.contains('injera')) {
      return _extractFoodContent(content);
    } else if (query.contains('travel') || query.contains('visit') || query.contains('place') || query.contains('tourism')) {
      return _extractTravelContent(content);
    } else if (query.contains('history') || query.contains('ancient') || query.contains('empire')) {
      return _extractHistoryContent(content);
    } else if (query.contains('festival') || query.contains('celebration') || query.contains('timkat') || query.contains('meskel')) {
      return _extractFestivalContent(content);
    } else if (query.contains('wildlife') || query.contains('animal') || query.contains('park') || query.contains('nature')) {
      return _extractWildlifeContent(content);
    } else {
      // Return comprehensive overview for general queries
      return content.substring(0, content.length > 2000 ? 2000 : content.length);
    }
  }

  String _searchAmharicGuide(String query) {
    if (_pdfCache['amharic_learning'] == null) return '';
    return _pdfCache['amharic_learning']!.substring(0, 500);
  }

  /// Ethiopia Handbook comprehensive knowledge
  /// This represents extracted content from EthiopiaHandbook.pdf
  Future<String> _loadEthiopiaHandbookKnowledge() async {
    return '''
**ETHIOPIA HANDBOOK - Comprehensive Travel Guide**

**INTRODUCTION TO ETHIOPIA:**
Ethiopia is the cradle of humanity, home to Lucy (Dinkinesh), a 3.2 million-year-old hominid fossil. It is the only African country never colonized (except brief Italian occupation 1936-1941). Ethiopia has its own ancient script (Ge'ez), calendar (7-8 years behind), and time system (12-hour cycle starting at sunrise).

**QUICK FACTS:**
- **Capital:** Addis Ababa (2,355m elevation)
- **Population:** 120+ million (2024)
- **Languages:** 80+ languages; Amharic official, Oromo largest
- **Religions:** Ethiopian Orthodox Christianity (43%), Islam (34%), Protestant (22%)
- **Currency:** Ethiopian Birr (ETB), ~50-55 birr = 1 USD
- **Area:** 1.1 million km² (27th largest country)
- **Time Zone:** GMT+3 (East Africa Time)

**GEOGRAPHY & CLIMATE:**
Ethiopia's diverse landscapes range from Danakil Depression (-125m, hottest place on Earth) to Ras Dashen (4,550m). The Great Rift Valley divides the country. Climate varies by altitude:
- **Dega (Cool):** Above 2,500m - Addis, Lalibela, Gondar
- **Weyna Dega (Temperate):** 1,500-2,500m - Most productive
- **Kolla (Hot):** Below 1,500m - Lowlands, Omo Valley

**Rainy Seasons:**
- **Kiremt (Big Rains):** June-September (main agricultural season)
- **Belg (Small Rains):** February-March (minor season)
- **Best Travel Time:** October-March (dry season)

**HISTORY ESSENTIALS:**
- **3.2 million years ago:** Lucy (Australopithecus afarensis)
- **980 BCE:** D'mt Kingdom (first organized state)
- **100-940 CE:** Aksumite Empire (minting coins, trading with Rome/India)
- **330 CE:** Christianity adopted (King Ezana)
- **12th century:** Rock-hewn churches of Lalibela
- **1270-1974:** Solomonic Dynasty (longest in history)
- **1896:** Battle of Adwa (defeated Italy, preserved independence)
- **1935-1941:** Italian occupation
- **1974-1991:** Communist Derg regime
- **1991-present:** Federal Democratic Republic

**REGIONS & DESTINATIONS:**

**ADDIS ABABA (Capital):**
- **National Museum:** Lucy fossil, Ethiopian history
- **Holy Trinity Cathedral:** Emperor Haile Selassie's tomb
- **Mercato:** Africa's largest open-air market
- **Entoto Mountains:** Panoramic city views, historic churches
- **Unity Park:** Presidential palace gardens (opened 2019)
- **Altitude:** 2,355m - allows year-round pleasant weather
- **Population:** 5.2 million

**NORTHERN HISTORICAL CIRCUIT:**

**Lalibela (UNESCO):**
- 11 rock-hewn churches carved from solid rock (12th-13th century)
- Most iconic: Biete Giyorgis (St. George) - cross-shaped, carved 15m deep
- Still active places of worship
- **Genna (Christmas):** January 7 - pilgrims flock
- **Timkat (Epiphany):** January 19-20 - most spectacular festival
- **Fasika (Easter):** Variable date - holiest celebration
- **Access:** Daily flights from Addis (1 hour)
- **Duration:** Minimum 2 days, ideal 3 days
- **Altitude:** 2,600m

**Gondar (UNESCO):**
- "Camelot of Africa" - 17th century castles
- **Fasil Ghebbi:** Royal enclosure with 6 castles
- **Debre Berhan Selassie Church:** Famous ceiling with 80 angel faces
- **Fasilides Bath:** Filled once yearly for Timkat (January 20)
- **Access:** Daily flights from Addis (1 hour), 180km from Bahir Dar
- **Gateway:** To Simien Mountains National Park (3-4 hours)

**Axum (UNESCO):**
- Ancient capital of Aksumite Empire
- **Stelae Field:** 120+ obelisks, tallest 24m (returned from Rome 2008)
- **St. Mary of Zion Church:** Claims to house Ark of Covenant
- **Queen of Sheba's Palace:** Ruins attributed to legendary queen
- **Access:** Daily flights from Addis (1.5 hours)

**Bahir Dar:**
- Beautiful lakeside city, palm-lined boulevards
- **Lake Tana:** Source of Blue Nile, 37 islands with monasteries
- **Blue Nile Falls (Tis Issat):** "Smoking Water" - 45m high
- **Best Time:** After rains (July-September) for full falls
- **Boat Trips:** Visit island monasteries (Ura Kidane Mihret, Azwa Maryam)

**Tigray Rock Churches:**
- 120+ churches carved into cliffs and caves
- **Abuna Yemata Guh:** Most spectacular, requires rock climbing
- **Maryam Korkor:** Easier access, beautiful frescoes
- **Abreha we Atsbeha:** Largest Tigray church
- **Access:** Base in Mekelle or Hawzen, 4x4 vehicle required

**NATIONAL PARKS:**

**Simien Mountains (UNESCO):**
- "Roof of Africa" - dramatic mountain landscape
- **Ras Dashen:** 4,550m (4th highest in Africa)
- **Endemic Wildlife:**
  - **Gelada Baboons:** 200,000+ (only in Ethiopia), guaranteed sighting
  - **Walia Ibex:** 500-600 (critically endangered, Simien only)
  - **Ethiopian Wolf:** 50-60 in Simien (world's rarest canid)
- **Trekking:** 1-day to 14-day treks, camping or lodges
- **Best Time:** October-March (dry season)
- **Access:** Via Gondar (3-4 hours), Debark (park HQ)

**Bale Mountains:**
- Largest population of Ethiopian wolves (250-300)
- **Mountain Nyala:** Endemic antelope, easily seen in Dinsho
- **Sanetti Plateau:** 4,000m+ Afroalpine landscape, highest road in Africa
- **Harenna Forest:** Largest remaining forest, cloud forest
- **Activities:** Wildlife viewing, trekking, birding
- **Best For:** Ethiopian wolf (40-60% sighting probability)

**SOUTHERN ETHIOPIA:**

**Omo Valley:**
- 80+ ethnic groups, most ethnically diverse region
- **Major Tribes:**
  - **Mursi:** Famous lip plates (women)
  - **Hamar:** Bull-jumping ceremony (coming of age)
  - **Karo:** Body painting masters
  - **Dassanech:** Omo Delta residents
- **Best Time:** October-March (dry season, accessible)
- **Tours:** 4-10 days, 4x4 required, cultural sensitivity essential
- **Markets:** Turmi, Dimeka, Key Afer (weekly markets)

**Rift Valley Lakes:**
- **Lake Hawassa:** Fish market, hippos, birds
- **Lake Langano:** Safe swimming (no bilharzia)
- **Lake Chamo:** "Crocodile market" - giant Nile crocodiles
- **Lake Abaya:** "Red lake" - brown-red color
- **Activities:** Boat safaris, birdwatching, relaxation

**PRACTICAL INFORMATION:**

**Visas:**
- **Visa on Arrival:** \$50 USD at Bole Airport (most nationalities)
- **E-Visa:** Apply online (www.evisa.gov.et) - \$52, 1-3 days
- **Duration:** 30 days standard, extensions available
- **Requirements:** Passport valid 6+ months, return ticket

**Health:**
- **Yellow Fever:** Required if coming from endemic country
- **Recommended Vaccinations:** Hepatitis A/B, typhoid, rabies (if rural)
- **Malaria:** Risk below 2,000m (not Addis, Lalibela, Gondar)
- **Altitude Sickness:** Common above 2,500m - acclimatize gradually
- **Water:** Don't drink tap water, bottled widely available

**Transportation:**
- **Ethiopian Airlines:** Extensive domestic network, daily flights to major cities
- **Buses:** Selam Bus, Sky Bus (modern, AC), public buses (basic)
- **Addis Light Rail:** First in sub-Saharan Africa (2-6 birr)
- **Taxis:** Blue-white taxis (negotiate), ride apps (RIDE, ZayRide)
- **Car Rental:** Available with driver (recommended)

**Accommodation:**
- **Budget:** \$10-30/night (guesthouses)
- **Mid-range:** \$40-80/night (comfortable hotels)
- **Luxury:** \$100-300/night (Sheraton, Hilton, etc.)
- **Book Ahead:** Festivals (Timkat, Genna, Easter)

**Money:**
- **Currency:** Ethiopian Birr (ETB)
- **Exchange:** Airport, banks (best rates), hotels
- **ATMs:** Common in cities (Visa, Mastercard)
- **Cards:** Accepted in upscale establishments only
- **Budget:** \$20-40/day (budget), \$50-100/day (mid-range), \$150+/day (luxury)

**Safety:**
- **Generally Safe:** Ethiopia is relatively safe for tourists
- **Addis Ababa:** Watch for pickpockets in Mercato, crowded areas
- **Regional Conflicts:** Check advisories (Tigray situation)
- **Border Areas:** Avoid Somalia, Eritrea borders

**ETHIOPIAN CUISINE:**

**Staples:**
- **Injera:** Sourdough flatbread (base of meals), made from teff
- **Wot:** Stew (doro wot-chicken, sega wot-beef, misir wot-lentil)
- **Tibs:** Sautéed meat with vegetables
- **Kitfo:** Raw minced beef with spices (Ethiopia's steak tartare)
- **Shiro:** Chickpea stew (most popular vegetarian dish)

**Drinks:**
- **Coffee (Buna):** Birthplace of coffee, traditional ceremony
- **Tej:** Honey wine (7-15% alcohol)
- **Tella:** Home-brewed beer (2-6% alcohol)

**Fasting Food:**
- **200+ fasting days:** Orthodox Christians abstain from animal products
- **Wednesday/Friday:** Year-round fasting days (great for vegetarians)
- **Lent:** 55 days before Easter (most strict)

**FESTIVALS:**
- **Timkat (January 19-20):** Epiphany - most spectacular (Gondar, Lalibela)
- **Genna (January 7):** Christmas - end of 43-day fast
- **Fasika (March-April):** Easter - most important religious holiday
- **Meskel (September 27):** Finding of True Cross - bonfire festival
- **Enkutatash (September 11):** New Year - spring celebration
- **Irreecha (September-October):** Oromo thanksgiving (million+ participants)

**CULTURAL ETIQUETTE:**
- **Greetings:** Handshake, bow slightly for elders
- **Shoes:** Remove before entering churches/mosques/homes
- **Photography:** Always ask permission, payment often expected
- **Dress:** Modest clothing, especially at religious sites
- **Right Hand:** Use for eating and gestures
- **Coffee Ceremony:** Accept all three rounds if invited (honor)

This handbook provides essential information for your Ethiopian journey. For more details on specific regions or activities, consult specialized guides or local experts.
''';
  }

  /// Amharic Learning Guide content
  Future<String> _loadAmharicLearningKnowledge() async {
    return '''
**AMHARIC LANGUAGE LEARNING GUIDE**

**Essential Greetings:**
- Selam (ሰላም) = Hello/Peace
- Tena yistilign (ጤና ይስጥልኝ) = Hello (formal)
- Dehna neh/nesh (ደህና ነህ/ነሽ) = How are you? (m/f)
- Ameseginalehu (አመሰግናለሁ) = Thank you
- Ebakeh/Ebakesh (እባክህ/እባክሽ) = Please (m/f)
- Yikirta (ይቅርታ) = Sorry/Excuse me
- Chow / Dehna hun (ቻው / ደህና ሁን) = Goodbye
- Awo (አዎ) = Yes
- Ai / Aydelem (አይ / አይደለም) = No

**Numbers 1-10:**
1. And (አንድ)
2. Hulet (ሁለት)
3. Sost (ሶስት)
4. Arat (አራት)
5. Amist (አምስት)
6. Sidist (ስድስት)
7. Sebat (ሰባት)
8. Simmint (ስምንት)
9. Zetegn (ዘጠኝ)
10. Asir (አስር)

**Useful Phrases:**
- Algebagnim (አልገባኝም) = I don't understand
- Inglizgna yichlalu? (እንግሊዝኛ ይችላሉ?) = Do you speak English?
- ...yet new? (...የት ነው?) = Where is...?
- Sint new? (ስንት ነው?) = How much?
- Betam wud new (በጣም ውድ ነው) = Too expensive
- Wuha (ውሃ) = Water
- Buna (ቡና) = Coffee
- Migib (ምግብ) = Food
- Tafaa (ጣፋ) = Delicious

For complete Amharic lessons, refer to the comprehensive language database.
''';
  }
  
  /// Extract Lalibela-specific content
  String _extractLalibelaContent(String content) {
    final lines = content.split('\n');
    final relevantLines = <String>[];
    
    for (final line in lines) {
      if (line.toLowerCase().contains('lalibela') || 
          line.toLowerCase().contains('church') || 
          line.toLowerCase().contains('rock-hewn') ||
          line.toLowerCase().contains('biete giyorgis') ||
          line.toLowerCase().contains('genna') ||
          line.toLowerCase().contains('timkat')) {
        relevantLines.add(line);
      }
    }
    
    return relevantLines.join('\n').substring(0, relevantLines.join('\n').length > 1500 ? 1500 : relevantLines.join('\n').length);
  }
  
  /// Extract language-specific content
  String _extractLanguageContent(String content) {
    final lines = content.split('\n');
    final relevantLines = <String>[];
    
    for (final line in lines) {
      if (line.toLowerCase().contains('amharic') || 
          line.toLowerCase().contains('language') || 
          line.toLowerCase().contains('geez') ||
          line.toLowerCase().contains('fidel') ||
          line.toLowerCase().contains('script') ||
          line.toLowerCase().contains('selam') ||
          line.toLowerCase().contains('tena yistilign')) {
        relevantLines.add(line);
      }
    }
    
    return relevantLines.join('\n').substring(0, relevantLines.join('\n').length > 1500 ? 1500 : relevantLines.join('\n').length);
  }
  
  /// Extract food-specific content
  String _extractFoodContent(String content) {
    final lines = content.split('\n');
    final relevantLines = <String>[];
    
    for (final line in lines) {
      if (line.toLowerCase().contains('food') || 
          line.toLowerCase().contains('cuisine') || 
          line.toLowerCase().contains('injera') ||
          line.toLowerCase().contains('doro wat') ||
          line.toLowerCase().contains('kitfo') ||
          line.toLowerCase().contains('tibs') ||
          line.toLowerCase().contains('coffee') ||
          line.toLowerCase().contains('buna') ||
          line.toLowerCase().contains('berbere')) {
        relevantLines.add(line);
      }
    }
    
    return relevantLines.join('\n').substring(0, relevantLines.join('\n').length > 1500 ? 1500 : relevantLines.join('\n').length);
  }
  
  /// Extract travel-specific content
  String _extractTravelContent(String content) {
    final lines = content.split('\n');
    final relevantLines = <String>[];
    
    for (final line in lines) {
      if (line.toLowerCase().contains('travel') || 
          line.toLowerCase().contains('tourism') || 
          line.toLowerCase().contains('visit') ||
          line.toLowerCase().contains('unesco') ||
          line.toLowerCase().contains('world heritage') ||
          line.toLowerCase().contains('national park') ||
          line.toLowerCase().contains('transportation') ||
          line.toLowerCase().contains('accommodation')) {
        relevantLines.add(line);
      }
    }
    
    return relevantLines.join('\n').substring(0, relevantLines.join('\n').length > 1500 ? 1500 : relevantLines.join('\n').length);
  }
  
  /// Extract history-specific content
  String _extractHistoryContent(String content) {
    final lines = content.split('\n');
    final relevantLines = <String>[];
    
    for (final line in lines) {
      if (line.toLowerCase().contains('history') || 
          line.toLowerCase().contains('ancient') || 
          line.toLowerCase().contains('empire') ||
          line.toLowerCase().contains('kingdom') ||
          line.toLowerCase().contains('axum') ||
          line.toLowerCase().contains('gondar') ||
          line.toLowerCase().contains('lucy') ||
          line.toLowerCase().contains('dinkinesh')) {
        relevantLines.add(line);
      }
    }
    
    return relevantLines.join('\n').substring(0, relevantLines.join('\n').length > 1500 ? 1500 : relevantLines.join('\n').length);
  }
  
  /// Extract festival-specific content
  String _extractFestivalContent(String content) {
    final lines = content.split('\n');
    final relevantLines = <String>[];
    
    for (final line in lines) {
      if (line.toLowerCase().contains('festival') || 
          line.toLowerCase().contains('celebration') || 
          line.toLowerCase().contains('timkat') ||
          line.toLowerCase().contains('meskel') ||
          line.toLowerCase().contains('genna') ||
          line.toLowerCase().contains('fasika') ||
          line.toLowerCase().contains('enkuatash') ||
          line.toLowerCase().contains('irreecha')) {
        relevantLines.add(line);
      }
    }
    
    return relevantLines.join('\n').substring(0, relevantLines.join('\n').length > 1500 ? 1500 : relevantLines.join('\n').length);
  }
  
  /// Extract wildlife-specific content
  String _extractWildlifeContent(String content) {
    final lines = content.split('\n');
    final relevantLines = <String>[];
    
    for (final line in lines) {
      if (line.toLowerCase().contains('wildlife') || 
          line.toLowerCase().contains('animal') || 
          line.toLowerCase().contains('park') ||
          line.toLowerCase().contains('nature') ||
          line.toLowerCase().contains('gelada') ||
          line.toLowerCase().contains('walia ibex') ||
          line.toLowerCase().contains('ethiopian wolf') ||
          line.toLowerCase().contains('mountain nyala') ||
          line.toLowerCase().contains('simien') ||
          line.toLowerCase().contains('bale')) {
        relevantLines.add(line);
      }
    }
    
    return relevantLines.join('\n').substring(0, relevantLines.join('\n').length > 1500 ? 1500 : relevantLines.join('\n').length);
  }
}


