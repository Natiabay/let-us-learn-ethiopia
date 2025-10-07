/// Comprehensive Ethiopia Tourist Database
/// Extensive database covering all aspects of Ethiopian tourism
class ComprehensiveEthiopiaDatabase {
  
  // Major Cities and Regions
  static const Map<String, Map<String, dynamic>> cities = {
    'Addis Ababa': {
      'description': 'Capital city and largest city of Ethiopia, known as the "New Flower"',
      'population': '5.2 million',
      'elevation': '2,355m above sea level',
      'climate': 'Subtropical highland climate',
      'bestTimeToVisit': 'October to March',
      'airport': 'Bole International Airport (ADD)',
      'majorAttractions': [
        'National Museum of Ethiopia',
        'Mercato (Africa\'s largest open-air market)',
        'Entoto Mountain',
        'Holy Trinity Cathedral',
        'Ethnological Museum',
        'Red Terror Martyrs Memorial Museum',
        'Unity Park',
        'Addis Ababa Museum',
        'St. George Cathedral',
        'Menelik II Square'
      ],
      'restaurants': [
        'Yod Abyssinia Cultural Restaurant',
        'Habesha Restaurant',
        'Kategna Restaurant',
        'Fendika Cultural Center',
        'Tomoca Coffee',
        'Kaldi\'s Coffee',
        'Sishu Restaurant',
        'Dashen Traditional Restaurant'
      ],
      'hotels': [
        'Sheraton Addis',
        'Hilton Addis Ababa',
        'Radisson Blu Hotel',
        'Golden Tulip Hotel',
        'Jupiter International Hotel',
        'Capital Hotel and Spa',
        'Harmony Hotel',
        'Addis Regency Hotel'
      ],
      'shopping': [
        'Mercato Market',
        'Shiro Meda Market',
        'Piazza District',
        'Bole Road Shopping Centers',
        'Edna Mall',
        'Dembel City Center',
        'Getu Commercial Center'
      ],
      'nightlife': [
        'Fendika Cultural Center',
        'Jazzamba Lounge',
        'Club Illusion',
        'Club Deep',
        'Sky Lounge',
        'Club H2O',
        'Club Oxygen'
      ]
    },
    'Lalibela': {
      'description': 'Famous for its rock-hewn churches, a UNESCO World Heritage Site',
      'population': '15,000',
      'elevation': '2,500m above sea level',
      'climate': 'Cool highland climate',
      'bestTimeToVisit': 'October to April',
      'airport': 'Lalibela Airport (LLI)',
      'majorAttractions': [
        'Rock-Hewn Churches (11 churches)',
        'Bete Giyorgis (Church of St. George)',
        'Bete Medhane Alem',
        'Bete Maryam',
        'Bete Amanuel',
        'Bete Abba Libanos',
        'Bete Gabriel-Rufael',
        'Asheton Maryam Monastery',
        'Na\'akuto La\'ab Monastery',
        'Yemrehanna Kristos Church'
      ],
      'restaurants': [
        'Ben Abeba Restaurant',
        'Seven Olives Hotel Restaurant',
        'Roha Hotel Restaurant',
        'Mountain View Hotel Restaurant',
        'Lalibela Lodge Restaurant'
      ],
      'hotels': [
        'Mountain View Hotel',
        'Roha Hotel',
        'Seven Olives Hotel',
        'Lalibela Lodge',
        'Maribela Hotel',
        'Panoramic View Hotel'
      ]
    },
    'Gondar': {
      'description': 'Former capital of Ethiopia, known as the "Camelot of Africa"',
      'population': '400,000',
      'elevation': '2,133m above sea level',
      'climate': 'Temperate highland climate',
      'bestTimeToVisit': 'October to March',
      'airport': 'Gondar Airport (GDQ)',
      'majorAttractions': [
        'Fasil Ghebbi (Royal Enclosure)',
        'Fasilides Castle',
        'Debre Berhan Selassie Church',
        'Bath of Fasilides',
        'Kuskuam Complex',
        'Gondar Castle',
        'Ras Gimb Palace',
        'Empress Mentewab\'s Palace',
        'Qusquam Church',
        'Gondar University'
      ],
      'restaurants': [
        'Four Sisters Restaurant',
        'Goha Hotel Restaurant',
        'Taye Hotel Restaurant',
        'L-Shape Hotel Restaurant',
        'Gondar Hotel Restaurant'
      ],
      'hotels': [
        'Goha Hotel',
        'Taye Hotel',
        'L-Shape Hotel',
        'Gondar Hotel',
        'Fasil Lodge',
        'Landmark Hotel'
      ]
    },
    'Bahir Dar': {
      'description': 'City on the shores of Lake Tana, source of the Blue Nile',
      'population': '300,000',
      'elevation': '1,800m above sea level',
      'climate': 'Tropical savanna climate',
      'bestTimeToVisit': 'October to March',
      'airport': 'Bahir Dar Airport (BJR)',
      'majorAttractions': [
        'Lake Tana',
        'Blue Nile Falls (Tis Abay)',
        'Ura Kidane Mehret Monastery',
        'Kebran Gabriel Monastery',
        'Azwa Maryam Monastery',
        'Narga Selassie Monastery',
        'Daga Island Monastery',
        'Tana Hayk (Lake Tana)',
        'Blue Nile River',
        'Bahir Dar University'
      ],
      'restaurants': [
        'Wude Coffee House',
        'Kuriftu Resort Restaurant',
        'Blue Nile Hotel Restaurant',
        'Tana Hotel Restaurant',
        'Papyrus Hotel Restaurant'
      ],
      'hotels': [
        'Kuriftu Resort & Spa',
        'Blue Nile Hotel',
        'Tana Hotel',
        'Papyrus Hotel',
        'Jacaranda Hotel',
        'Abay Minch Lodge'
      ]
    },
    'Axum': {
      'description': 'Ancient capital of the Aksumite Empire, UNESCO World Heritage Site',
      'population': '100,000',
      'elevation': '2,131m above sea level',
      'climate': 'Semi-arid climate',
      'bestTimeToVisit': 'October to March',
      'airport': 'Axum Airport (AXU)',
      'majorAttractions': [
        'Obelisk of Axum',
        'St. Mary of Zion Church',
        'Axum Archaeological Museum',
        'Tomb of Kaleb',
        'Tomb of Gebre Meskel',
        'Queen of Sheba\'s Palace',
        'Axum Stelae Field',
        'Ezana Stone',
        'Yeha Temple',
        'Dongur Palace'
      ],
      'restaurants': [
        'Yeha Hotel Restaurant',
        'Remhai Hotel Restaurant',
        'Sabean Hotel Restaurant',
        'Axum Hotel Restaurant'
      ],
      'hotels': [
        'Yeha Hotel',
        'Remhai Hotel',
        'Sabean Hotel',
        'Axum Hotel',
        'Consolar International Hotel'
      ]
    },
    'Harar': {
      'description': 'Ancient walled city, center of Islamic culture in Ethiopia',
      'population': '150,000',
      'elevation': '1,885m above sea level',
      'climate': 'Hot semi-arid climate',
      'bestTimeToVisit': 'October to March',
      'airport': 'Dire Dawa Airport (DIR)',
      'majorAttractions': [
        'Harar Jugol (Old Walled City)',
        'Hyena Feeding Ceremony',
        'Harar Museum',
        'Rimbaud House',
        'Sherif Harar City Museum',
        'Jugol Wall',
        'Harar Gates',
        'Medhane Alem Cathedral',
        'Harar Coffee Museum',
        'Arthur Rimbaud Museum'
      ],
      'restaurants': [
        'Fresh Touch Restaurant',
        'Belayneh Hotel Restaurant',
        'Ras Hotel Restaurant',
        'Tewodros Hotel Restaurant'
      ],
      'hotels': [
        'Belayneh Hotel',
        'Ras Hotel',
        'Tewodros Hotel',
        'Heritage Plaza Hotel',
        'Wonderland Hotel'
      ]
    },
    'Dire Dawa': {
      'description': 'Commercial hub and railway city',
      'population': '500,000',
      'elevation': '1,200m above sea level',
      'climate': 'Hot semi-arid climate',
      'bestTimeToVisit': 'October to March',
      'airport': 'Dire Dawa Airport (DIR)',
      'majorAttractions': [
        'Dire Dawa Railway Station',
        'Kefira Market',
        'Dire Dawa Museum',
        'Dire Dawa University',
        'French Quarter',
        'Greek Quarter',
        'Armenian Quarter',
        'Dire Dawa Stadium'
      ],
      'restaurants': [
        'Samrat Restaurant',
        'Dire Dawa Hotel Restaurant',
        'Ras Hotel Restaurant',
        'Tewodros Hotel Restaurant'
      ],
      'hotels': [
        'Dire Dawa Hotel',
        'Ras Hotel',
        'Tewodros Hotel',
        'Samrat Hotel',
        'Belayneh Hotel'
      ]
    }
  };

  // National Parks and Natural Attractions
  static const Map<String, Map<String, dynamic>> nationalParks = {
    'Simien Mountains National Park': {
      'description': 'UNESCO World Heritage Site with dramatic mountain landscapes',
      'location': 'Northern Ethiopia',
      'size': '412 km²',
      'elevation': '1,900m - 4,533m',
      'bestTimeToVisit': 'October to March',
      'wildlife': [
        'Ethiopian Wolf',
        'Gelada Baboon',
        'Walia Ibex',
        'Ethiopian Highland Hare',
        'Cape Eagle Owl',
        'Lammergeier (Bearded Vulture)',
        'Thick-billed Raven',
        'White-collared Pigeon'
      ],
      'activities': [
        'Trekking and Hiking',
        'Wildlife Watching',
        'Photography',
        'Camping',
        'Bird Watching',
        'Mountain Climbing'
      ],
      'accommodation': [
        'Simien Lodge',
        'Limalimo Lodge',
        'Sankaber Camp',
        'Geech Camp',
        'Chennek Camp'
      ]
    },
    'Bale Mountains National Park': {
      'description': 'Highland park with unique Afro-alpine ecosystem',
      'location': 'Southeastern Ethiopia',
      'size': '2,150 km²',
      'elevation': '1,500m - 4,377m',
      'bestTimeToVisit': 'October to March',
      'wildlife': [
        'Ethiopian Wolf',
        'Mountain Nyala',
        'Bale Monkey',
        'Giant Mole Rat',
        'Menelik\'s Bushbuck',
        'Bohor Reedbuck',
        'Warthog',
        'Spotted Hyena'
      ],
      'activities': [
        'Trekking',
        'Wildlife Watching',
        'Bird Watching',
        'Photography',
        'Camping',
        'Horseback Riding'
      ],
      'accommodation': [
        'Bale Mountain Lodge',
        'Wabe Shebelle Hotel',
        'Goba Wabe Shebelle Hotel',
        'Dinsho Lodge'
      ]
    },
    'Awash National Park': {
      'description': 'Savanna park with hot springs and diverse wildlife',
      'location': 'Central Ethiopia',
      'size': '756 km²',
      'elevation': '700m - 2,007m',
      'bestTimeToVisit': 'October to March',
      'wildlife': [
        'Oryx',
        'Kudu',
        'Warthog',
        'Baboon',
        'Hyena',
        'Leopard',
        'Lion',
        'Cheetah'
      ],
      'activities': [
        'Game Drives',
        'Hot Spring Bathing',
        'Bird Watching',
        'Photography',
        'Camping',
        'Hiking'
      ],
      'accommodation': [
        'Awash Falls Lodge',
        'Kuriftu Resort',
        'Awash National Park Lodge'
      ]
    },
    'Mago National Park': {
      'description': 'Remote park in the Omo Valley',
      'location': 'Southwestern Ethiopia',
      'size': '2,162 km²',
      'elevation': '450m - 2,528m',
      'bestTimeToVisit': 'October to March',
      'wildlife': [
        'Elephant',
        'Buffalo',
        'Lion',
        'Leopard',
        'Cheetah',
        'Giraffe',
        'Zebra',
        'Hippopotamus'
      ],
      'activities': [
        'Game Drives',
        'Cultural Tours',
        'Photography',
        'Camping',
        'Bird Watching'
      ],
      'accommodation': [
        'Mago National Park Lodge',
        'Jinka Resort',
        'Turmi Lodge'
      ]
    }
  };

  // Traditional Ethiopian Food
  static const Map<String, Map<String, dynamic>> traditionalFoods = {
    'Injera': {
      'description': 'Sourdough flatbread made from teff flour, the national staple',
      'ingredients': ['Teff flour', 'Water', 'Salt'],
      'preparation': 'Fermented for 2-3 days, cooked on large clay griddle',
      'serving': 'Served with various stews and vegetables',
      'nutritionalValue': 'High in iron, calcium, and protein',
      'culturalSignificance': 'Central to Ethiopian cuisine and culture'
    },
    'Doro Wat': {
      'description': 'Spicy chicken stew, considered the national dish',
      'ingredients': ['Chicken', 'Berbere spice', 'Onions', 'Garlic', 'Ginger', 'Niter Kibbeh'],
      'preparation': 'Slow-cooked with berbere spice blend',
      'serving': 'Traditionally served with injera and hard-boiled eggs',
      'spiceLevel': 'Very spicy',
      'occasions': 'Special occasions and holidays'
    },
    'Kitfo': {
      'description': 'Minced raw beef seasoned with spices',
      'ingredients': ['Raw beef', 'Mitmita spice', 'Niter Kibbeh', 'Cottage cheese'],
      'preparation': 'Finely minced and seasoned',
      'serving': 'Served with injera and ayib (cottage cheese)',
      'variations': 'Can be lightly cooked (leb leb) or fully raw',
      'culturalNote': 'Popular among the Gurage people'
    },
    'Tibs': {
      'description': 'Sautéed meat with vegetables and spices',
      'ingredients': ['Beef/Lamb', 'Onions', 'Peppers', 'Garlic', 'Ginger', 'Berbere'],
      'preparation': 'Quickly sautéed in niter kibbeh',
      'variations': ['Tibs Firfir', 'Tibs Sega', 'Tibs Beg'],
      'serving': 'Served with injera or bread',
      'popularity': 'Very popular in restaurants'
    },
    'Shiro': {
      'description': 'Chickpea or bean flour stew',
      'ingredients': ['Chickpea flour', 'Onions', 'Garlic', 'Berbere', 'Niter Kibbeh'],
      'preparation': 'Cooked into a thick stew',
      'variations': ['Shiro Tegabino', 'Shiro Wot'],
      'serving': 'Served with injera',
      'dietary': 'Vegetarian and vegan friendly'
    },
    'Misir Wat': {
      'description': 'Spicy red lentil stew',
      'ingredients': ['Red lentils', 'Berbere', 'Onions', 'Garlic', 'Ginger', 'Niter Kibbeh'],
      'preparation': 'Slow-cooked until lentils are soft',
      'serving': 'Served with injera',
      'dietary': 'Vegetarian and vegan',
      'nutritionalValue': 'High in protein and fiber'
    },
    'Gomen': {
      'description': 'Collard greens cooked with spices',
      'ingredients': ['Collard greens', 'Onions', 'Garlic', 'Ginger', 'Turmeric'],
      'preparation': 'Sautéed with aromatics',
      'serving': 'Served as a side dish with injera',
      'dietary': 'Vegetarian and vegan',
      'healthBenefits': 'High in vitamins A, C, and K'
    },
    'Ayib': {
      'description': 'Traditional Ethiopian cottage cheese',
      'ingredients': ['Milk', 'Lemon juice or vinegar'],
      'preparation': 'Curdled milk, drained and pressed',
      'serving': 'Often served with kitfo or as a side',
      'texture': 'Soft and crumbly',
      'flavor': 'Mild and slightly tangy'
    }
  };

  // Ethiopian Coffee Culture
  static const Map<String, dynamic> coffeeCulture = {
    'ceremony': {
      'duration': '2-3 hours',
      'rounds': 3,
      'roundNames': ['Abol (First)', 'Tona (Second)', 'Baraka (Third)'],
      'significance': 'Symbol of friendship, hospitality, and community',
      'equipment': [
        'Jebena (Clay coffee pot)',
        'Roasting pan',
        'Mortar and pestle',
        'Small cups (cini)',
        'Incense burner',
        'Popcorn maker'
      ],
      'process': [
        'Green bean roasting (5-10 minutes)',
        'Grinding with mortar and pestle',
        'Brewing in jebena (15-20 minutes)',
        'Serving three rounds',
        'Accompanied by popcorn and bread'
      ]
    },
    'coffeeRegions': {
      'Yirgacheffe': {
        'flavor': 'Floral, citrusy, light body',
        'elevation': '1,700-2,200m',
        'processing': 'Washed',
        'characteristics': 'Bright acidity, tea-like body'
      },
      'Sidamo': {
        'flavor': 'Wine-like, full body',
        'elevation': '1,500-2,200m',
        'processing': 'Washed and natural',
        'characteristics': 'Complex flavor profile'
      },
      'Harrar': {
        'flavor': 'Winey, blueberry notes',
        'elevation': '1,500-2,000m',
        'processing': 'Natural (dry)',
        'characteristics': 'Fruity, wine-like acidity'
      },
      'Limu': {
        'flavor': 'Balanced, medium body',
        'elevation': '1,100-1,900m',
        'processing': 'Washed',
        'characteristics': 'Clean, balanced flavor'
      },
      'Jimma': {
        'flavor': 'Earthy, full body',
        'elevation': '1,400-1,800m',
        'processing': 'Natural',
        'characteristics': 'Rich, earthy notes'
      }
    },
    'modernCoffeeScene': {
      'specialtyShops': [
        'Tomoca Coffee (Addis Ababa)',
        'Kaldi\'s Coffee',
        'Mokarar Coffee',
        'Garden of Coffee',
        'Kaldis Coffee House'
      ],
      'coffeeFarms': [
        'Hambela Coffee Farm',
        'Yirgacheffe Coffee Farm',
        'Sidamo Coffee Farm',
        'Harrar Coffee Farm'
      ],
      'coffeeFestivals': [
        'Ethiopian Coffee Festival',
        'Yirgacheffe Coffee Festival',
        'Sidamo Coffee Festival'
      ]
    }
  };

  // Cultural Festivals and Events
  static const Map<String, Map<String, dynamic>> festivals = {
    'Timkat (Epiphany)': {
      'date': 'January 19-20',
      'description': 'Orthodox Christian celebration of Jesus\' baptism',
      'location': 'Throughout Ethiopia, especially Gondar and Lalibela',
      'activities': [
        'Religious processions',
        'Water blessing ceremonies',
        'Traditional music and dance',
        'Colorful parades',
        'Community feasts'
      ],
      'significance': 'One of the most important religious festivals',
      'duration': '3 days',
      'bestPlacesToExperience': ['Gondar', 'Lalibela', 'Addis Ababa', 'Axum']
    },
    'Meskel (Finding of the True Cross)': {
      'date': 'September 27',
      'description': 'Orthodox Christian festival celebrating the discovery of the True Cross',
      'location': 'Throughout Ethiopia, especially Addis Ababa',
      'activities': [
        'Bonfire lighting ceremony',
        'Religious processions',
        'Traditional songs and dances',
        'Community gatherings',
        'Feasting'
      ],
      'significance': 'Marks the discovery of the cross by St. Helena',
      'duration': '1 day',
      'bestPlacesToExperience': ['Addis Ababa', 'Gondar', 'Lalibela']
    },
    'Enkutatash (New Year)': {
      'date': 'September 11',
      'description': 'Ethiopian New Year celebration',
      'location': 'Throughout Ethiopia',
      'activities': [
        'Family gatherings',
        'Traditional meals',
        'Gift giving',
        'Religious services',
        'Community celebrations'
      ],
      'significance': 'Marks the beginning of the Ethiopian year',
      'duration': '1 day',
      'traditions': ['Yellow daisies (adey abeba)', 'Traditional clothing', 'Special foods']
    },
    'Irreecha (Thanksgiving)': {
      'date': 'October (varies)',
      'description': 'Oromo thanksgiving festival',
      'location': 'Bishoftu, Oromia region',
      'activities': [
        'Thanksgiving prayers',
        'Traditional Oromo ceremonies',
        'Music and dance performances',
        'Community gatherings',
        'Cultural displays'
      ],
      'significance': 'Thanksgiving for the end of rainy season',
      'duration': '1 day',
      'bestPlacesToExperience': ['Bishoftu', 'Addis Ababa']
    },
    'Fasika (Easter)': {
      'date': 'Varies (Orthodox calendar)',
      'description': 'Orthodox Christian Easter celebration',
      'location': 'Throughout Ethiopia',
      'activities': [
        'Religious services',
        'Fasting period (55 days)',
        'Traditional foods',
        'Family gatherings',
        'Community celebrations'
      ],
      'significance': 'Most important Orthodox Christian holiday',
      'duration': '1 day (after 55-day fast)',
      'traditions': ['Doro wat', 'Injera', 'Traditional clothing']
    }
  };

  // Transportation Information
  static const Map<String, dynamic> transportation = {
    'domesticFlights': {
      'airlines': [
        'Ethiopian Airlines',
        'ASKY Airlines',
        'Malawian Airlines'
      ],
      'majorAirports': [
        'Bole International Airport (Addis Ababa)',
        'Lalibela Airport',
        'Gondar Airport',
        'Bahir Dar Airport',
        'Axum Airport',
        'Dire Dawa Airport',
        'Arba Minch Airport',
        'Jinka Airport'
      ],
      'domesticDestinations': [
        'Addis Ababa to Lalibela',
        'Addis Ababa to Gondar',
        'Addis Ababa to Bahir Dar',
        'Addis Ababa to Axum',
        'Addis Ababa to Dire Dawa',
        'Addis Ababa to Arba Minch',
        'Addis Ababa to Jinka'
      ]
    },
    'roadTransport': {
      'busServices': [
        'Selam Bus',
        'Sky Bus',
        'Abay Bus',
        'Gonder Bus',
        'Lalibela Bus'
      ],
      'carRental': [
        'Avis Ethiopia',
        'Hertz Ethiopia',
        'Budget Ethiopia',
        'Local car rental companies'
      ],
      'roadConditions': {
        'highways': 'Generally good between major cities',
        'ruralRoads': 'Can be rough, 4WD recommended',
        'rainySeason': 'Some roads may be impassable',
        'safety': 'Drive during daylight hours only'
      }
    },
    'railway': {
      'ethioDjiboutiRailway': {
        'route': 'Addis Ababa to Djibouti',
        'duration': '12 hours',
        'frequency': 'Daily',
        'stops': ['Dire Dawa', 'Awash', 'Adama']
      }
    }
  };

  // Accommodation Options
  static const Map<String, List<String>> accommodation = {
    'luxuryHotels': [
      'Sheraton Addis (Addis Ababa)',
      'Hilton Addis Ababa',
      'Radisson Blu Hotel (Addis Ababa)',
      'Kuriftu Resort & Spa (Bahir Dar)',
      'Simien Lodge (Simien Mountains)',
      'Bale Mountain Lodge (Bale Mountains)',
      'Limalimo Lodge (Simien Mountains)'
    ],
    'midRangeHotels': [
      'Golden Tulip Hotel (Addis Ababa)',
      'Jupiter International Hotel (Addis Ababa)',
      'Capital Hotel and Spa (Addis Ababa)',
      'Harmony Hotel (Addis Ababa)',
      'Mountain View Hotel (Lalibela)',
      'Roha Hotel (Lalibela)',
      'Goha Hotel (Gondar)',
      'Taye Hotel (Gondar)',
      'Blue Nile Hotel (Bahir Dar)',
      'Tana Hotel (Bahir Dar)'
    ],
    'budgetAccommodation': [
      'Addis Regency Hotel (Addis Ababa)',
      'Seven Olives Hotel (Lalibela)',
      'L-Shape Hotel (Gondar)',
      'Papyrus Hotel (Bahir Dar)',
      'Yeha Hotel (Axum)',
      'Remhai Hotel (Axum)',
      'Belayneh Hotel (Harar)',
      'Ras Hotel (Harar)',
      'Dire Dawa Hotel (Dire Dawa)',
      'Samrat Hotel (Dire Dawa)'
    ],
    'ecoLodges': [
      'Simien Lodge',
      'Bale Mountain Lodge',
      'Limalimo Lodge',
      'Kuriftu Resort & Spa',
      'Awash Falls Lodge',
      'Mago National Park Lodge'
    ]
  };

  // Shopping and Souvenirs
  static const Map<String, List<String>> shopping = {
    'traditionalCrafts': [
      'Handwoven textiles',
      'Silver jewelry',
      'Wooden carvings',
      'Basketry',
      'Pottery',
      'Leather goods',
      'Traditional musical instruments',
      'Religious artifacts'
    ],
    'coffeeProducts': [
      'Ethiopian coffee beans',
      'Traditional coffee pots (jebena)',
      'Coffee cups (cini)',
      'Coffee ceremony sets',
      'Coffee roasting equipment'
    ],
    'textiles': [
      'Habesha kemis (traditional dress)',
      'Shawls and scarves',
      'Table runners',
      'Cushion covers',
      'Traditional blankets'
    ],
    'jewelry': [
      'Silver crosses',
      'Traditional necklaces',
      'Earrings',
      'Bracelets',
      'Rings',
      'Anklets'
    ],
    'bestShoppingAreas': [
      'Mercato (Addis Ababa)',
      'Shiro Meda Market (Addis Ababa)',
      'Piazza District (Addis Ababa)',
      'Bole Road (Addis Ababa)',
      'Edna Mall (Addis Ababa)',
      'Dembel City Center (Addis Ababa)',
      'Getu Commercial Center (Addis Ababa)',
      'Kefira Market (Dire Dawa)',
      'Local markets in each city'
    ]
  };

  // Health and Safety Information
  static const Map<String, dynamic> healthAndSafety = {
    'vaccinations': [
      'Yellow Fever (required)',
      'Hepatitis A',
      'Hepatitis B',
      'Typhoid',
      'Meningitis',
      'Rabies',
      'Malaria prophylaxis'
    ],
    'healthPrecautions': [
      'Drink only bottled or purified water',
      'Avoid raw vegetables and fruits',
      'Eat only well-cooked food',
      'Use insect repellent',
      'Wear long sleeves and pants in malaria areas',
      'Carry first aid kit',
      'Get travel insurance'
    ],
    'emergencyContacts': {
      'police': '991',
      'ambulance': '907',
      'fire': '939',
      'touristPolice': '+251-11-551-5844',
      'usEmbassy': '+251-11-130-6000',
      'britishEmbassy': '+251-11-617-0100'
    },
    'safetyTips': [
      'Avoid traveling at night',
      'Keep valuables secure',
      'Use reputable tour operators',
      'Stay in well-lit areas',
      'Travel in groups when possible',
      'Keep copies of important documents',
      'Register with your embassy'
    ]
  };

  // Language and Communication
  static const Map<String, dynamic> language = {
    'officialLanguages': ['Amharic', 'English'],
    'regionalLanguages': [
      'Oromo',
      'Tigrinya',
      'Somali',
      'Afar',
      'Sidamo',
      'Wolaytta',
      'Gurage'
    ],
    'basicAmharicPhrases': {
      'hello': 'Selam (ሰላም)',
      'goodbye': 'Dehna hun (ደህና ሁን)',
      'thankYou': 'Ameseginalehu (አመሰግናለሁ)',
      'please': 'Ebakih (እባክህ)',
      'yes': 'Awo (አዎ)',
      'no': 'Aye (አይ)',
      'excuseMe': 'Yiqirta (ይቅርታ)',
      'sorry': 'Aznalo (አዝናለሁ)',
      'howMuch': 'Sint new (ስንት ነው)',
      'whereIs': 'Yet new (የት ነው)',
      'help': 'Tiru (ትሩ)',
      'water': 'Woha (ውሃ)',
      'food': 'Megib (መግብ)',
      'coffee': 'Buna (ቡና)',
      'beer': 'Bira (ቢራ)',
      'good': 'Tiru (ትሩ)',
      'bad': 'Metfo (መጥፎ)',
      'beautiful': 'Konjo (ኮንጆ)',
      'delicious': 'Mech (መጭ)'
    },
    'communicationTips': [
      'Learn basic Amharic phrases',
      'Use gestures and body language',
      'Carry a phrasebook',
      'Download translation apps',
      'Be patient and respectful',
      'Use English in tourist areas',
      'Learn numbers for shopping'
    ]
  };

  // Weather and Climate
  static const Map<String, dynamic> weather = {
    'climateZones': {
      'highlands': {
        'elevation': 'Above 1,500m',
        'temperature': '15-25°C',
        'rainfall': 'Heavy during rainy season',
        'cities': ['Addis Ababa', 'Lalibela', 'Gondar', 'Axum']
      },
      'lowlands': {
        'elevation': 'Below 1,500m',
        'temperature': '25-35°C',
        'rainfall': 'Variable',
        'cities': ['Dire Dawa', 'Harar', 'Bahir Dar']
      }
    },
    'seasons': {
      'drySeason': {
        'months': 'October to March',
        'characteristics': 'Sunny, warm days, cool nights',
        'bestFor': 'Travel and outdoor activities'
      },
      'rainySeason': {
        'months': 'June to September',
        'characteristics': 'Heavy rainfall, cooler temperatures',
        'considerations': 'Some roads may be impassable'
      },
      'shortRains': {
        'months': 'March to May',
        'characteristics': 'Light rainfall, pleasant weather',
        'bestFor': 'Wildlife viewing, green landscapes'
      }
    },
    'packingEssentials': [
      'Lightweight clothing for day',
      'Warm layers for evenings',
      'Rain jacket (rainy season)',
      'Comfortable walking shoes',
      'Sun hat and sunscreen',
      'Insect repellent',
      'First aid kit',
      'Water purification tablets'
    ]
  };

  // Tourist Activities and Experiences
  static const Map<String, List<String>> activities = {
    'culturalExperiences': [
      'Coffee ceremony participation',
      'Traditional music and dance shows',
      'Local market visits',
      'Religious site tours',
      'Cultural village visits',
      'Traditional cooking classes',
      'Handicraft workshops',
      'Local festival participation'
    ],
    'adventureActivities': [
      'Trekking in Simien Mountains',
      'Hiking in Bale Mountains',
      'Wildlife safaris',
      'Bird watching',
      'Mountain climbing',
      'Camping in national parks',
      'Horseback riding',
      'Cycling tours'
    ],
    'historicalTours': [
      'UNESCO World Heritage Sites',
      'Ancient city tours',
      'Museum visits',
      'Archaeological site tours',
      'Religious pilgrimage tours',
      'Castle and palace tours',
      'Traditional architecture tours',
      'Cultural heritage walks'
    ],
    'natureExperiences': [
      'National park visits',
      'Hot spring bathing',
      'Waterfall visits',
      'Lake and river tours',
      'Wildlife photography',
      'Botanical garden visits',
      'Scenic viewpoint visits',
      'Nature walks and hikes'
    ]
  };

  // Get comprehensive information about a specific topic
  static Map<String, dynamic> getInformation(String topic) {
    final lowerTopic = topic.toLowerCase();
    
    // Search through all categories
    if (cities.containsKey(lowerTopic)) {
      return cities[lowerTopic]!;
    }
    
    if (nationalParks.containsKey(lowerTopic)) {
      return nationalParks[lowerTopic]!;
    }
    
    if (traditionalFoods.containsKey(lowerTopic)) {
      return traditionalFoods[lowerTopic]!;
    }
    
    if (festivals.containsKey(lowerTopic)) {
      return festivals[lowerTopic]!;
    }
    
    // Return general information if specific topic not found
    return {
      'message': 'Comprehensive Ethiopia tourist information available',
      'categories': [
        'Cities and Regions',
        'National Parks',
        'Traditional Foods',
        'Coffee Culture',
        'Festivals and Events',
        'Transportation',
        'Accommodation',
        'Shopping',
        'Health and Safety',
        'Language',
        'Weather',
        'Activities'
      ]
    };
  }

  // Get all available topics
  static List<String> getAllTopics() {
    return [
      ...cities.keys,
      ...nationalParks.keys,
      ...traditionalFoods.keys,
      ...festivals.keys,
      'coffee culture',
      'transportation',
      'accommodation',
      'shopping',
      'health and safety',
      'language',
      'weather',
      'activities'
    ];
  }
}
