#!/usr/bin/env python3
"""
🌟 Expanded Lessons Generator
Generates comprehensive Duolingo-style lessons for all categories
Each category gets 15 lessons (10 Beginner, 3 Intermediate, 2 Advanced)
"""

CATEGORIES = [
    {
        "name": "Food",
        "part": 3,
        "icon": "🍽️",
        "topics": [
            # Beginner (10)
            {"id": 1, "title": "Ethiopian Dishes", "difficulty": "beginner"},
            {"id": 2, "title": "Drinks & Beverages", "difficulty": "beginner"},
            {"id": 3, "title": "Vegetables & Fruits", "difficulty": "beginner"},
            {"id": 4, "title": "Meat & Protein", "difficulty": "beginner"},
            {"id": 5, "title": "Spices & Flavors", "difficulty": "beginner"},
            {"id": 6, "title": "Restaurant Ordering", "difficulty": "beginner"},
            {"id": 7, "title": "Coffee Ceremony", "difficulty": "beginner"},
            {"id": 8, "title": "Street Food", "difficulty": "beginner"},
            {"id": 9, "title": "Breakfast Items", "difficulty": "beginner"},
            {"id": 10, "title": "Desserts & Sweets", "difficulty": "beginner"},
            # Intermediate (3)
            {"id": 11, "title": "Food Preparation", "difficulty": "intermediate"},
            {"id": 12, "title": "Dietary Preferences", "difficulty": "intermediate"},
            {"id": 13, "title": "Ethiopian Fasting Food", "difficulty": "intermediate"},
            # Advanced (2)
            {"id": 14, "title": "Traditional Cooking Methods", "difficulty": "advanced"},
            {"id": 15, "title": "Food Culture & Traditions", "difficulty": "advanced"},
        ]
    },
    {
        "name": "Family",
        "part": 4,
        "icon": "👨‍👩‍👧‍👦",
        "topics": [
            # Beginner (10)
            {"id": 1, "title": "Immediate Family", "difficulty": "beginner"},
            {"id": 2, "title": "Extended Family", "difficulty": "beginner"},
            {"id": 3, "title": "Relationships", "difficulty": "beginner"},
            {"id": 4, "title": "Ages & Generations", "difficulty": "beginner"},
            {"id": 5, "title": "Family Activities", "difficulty": "beginner"},
            {"id": 6, "title": "Family Events", "difficulty": "beginner"},
            {"id": 7, "title": "Children & Parenting", "difficulty": "beginner"},
            {"id": 8, "title": "Siblings & Cousins", "difficulty": "beginner"},
            {"id": 9, "title": "Grandparents", "difficulty": "beginner"},
            {"id": 10, "title": "In-Laws & Marriage", "difficulty": "beginner"},
            # Intermediate (3)
            {"id": 11, "title": "Family Roles & Responsibilities", "difficulty": "intermediate"},
            {"id": 12, "title": "Family History", "difficulty": "intermediate"},
            {"id": 13, "title": "Family Values", "difficulty": "intermediate"},
            # Advanced (2)
            {"id": 14, "title": "Complex Family Structures", "difficulty": "advanced"},
            {"id": 15, "title": "Family Traditions & Heritage", "difficulty": "advanced"},
        ]
    },
    {
        "name": "Directions",
        "part": 5,
        "icon": "🧭",
        "topics": [
            # Beginner (10)
            {"id": 1, "title": "Basic Directions", "difficulty": "beginner"},
            {"id": 2, "title": "Common Places", "difficulty": "beginner"},
            {"id": 3, "title": "Asking for Directions", "difficulty": "beginner"},
            {"id": 4, "title": "Distance & Location", "difficulty": "beginner"},
            {"id": 5, "title": "Landmarks", "difficulty": "beginner"},
            {"id": 6, "title": "Streets & Roads", "difficulty": "beginner"},
            {"id": 7, "title": "Buildings & Locations", "difficulty": "beginner"},
            {"id": 8, "title": "Maps & Navigation", "difficulty": "beginner"},
            {"id": 9, "title": "Inside Buildings", "difficulty": "beginner"},
            {"id": 10, "title": "Finding Your Way", "difficulty": "beginner"},
            # Intermediate (3)
            {"id": 11, "title": "Complex Directions", "difficulty": "intermediate"},
            {"id": 12, "title": "Public Transportation Routes", "difficulty": "intermediate"},
            {"id": 13, "title": "Getting Lost", "difficulty": "intermediate"},
            # Advanced (2)
            {"id": 14, "title": "Detailed Navigation", "difficulty": "advanced"},
            {"id": 15, "title": "Regional Directions", "difficulty": "advanced"},
        ]
    },
    {
        "name": "Time",
        "part": 6,
        "icon": "⏰",
        "topics": [
            # Beginner (10)
            {"id": 1, "title": "Telling Time - Hours", "difficulty": "beginner"},
            {"id": 2, "title": "Telling Time - Minutes", "difficulty": "beginner"},
            {"id": 3, "title": "Days of the Week", "difficulty": "beginner"},
            {"id": 4, "title": "Months of the Year", "difficulty": "beginner"},
            {"id": 5, "title": "Seasons", "difficulty": "beginner"},
            {"id": 6, "title": "Yesterday, Today, Tomorrow", "difficulty": "beginner"},
            {"id": 7, "title": "Morning, Afternoon, Evening", "difficulty": "beginner"},
            {"id": 8, "title": "Making Appointments", "difficulty": "beginner"},
            {"id": 9, "title": "Schedules & Routines", "difficulty": "beginner"},
            {"id": 10, "title": "Frequency - Always, Sometimes, Never", "difficulty": "beginner"},
            # Intermediate (3)
            {"id": 11, "title": "Ethiopian Time System", "difficulty": "intermediate"},
            {"id": 12, "title": "Duration & Time Periods", "difficulty": "intermediate"},
            {"id": 13, "title": "Past, Present, Future", "difficulty": "intermediate"},
            # Advanced (2)
            {"id": 14, "title": "Complex Time Expressions", "difficulty": "advanced"},
            {"id": 15, "title": "Ethiopian Calendar System", "difficulty": "advanced"},
        ]
    },
    {
        "name": "Colors",
        "part": 7,
        "icon": "🎨",
        "topics": [
            # Beginner (10)
            {"id": 1, "title": "Primary Colors", "difficulty": "beginner"},
            {"id": 2, "title": "Secondary Colors", "difficulty": "beginner"},
            {"id": 3, "title": "Light & Dark Shades", "difficulty": "beginner"},
            {"id": 4, "title": "Describing Clothes", "difficulty": "beginner"},
            {"id": 5, "title": "Nature Colors", "difficulty": "beginner"},
            {"id": 6, "title": "Common Objects & Colors", "difficulty": "beginner"},
            {"id": 7, "title": "Ethiopian Flag Colors", "difficulty": "beginner"},
            {"id": 8, "title": "Preferences & Likes", "difficulty": "beginner"},
            {"id": 9, "title": "Shopping for Colors", "difficulty": "beginner"},
            {"id": 10, "title": "Color Combinations", "difficulty": "beginner"},
            # Intermediate (3)
            {"id": 11, "title": "Color Descriptions", "difficulty": "intermediate"},
            {"id": 12, "title": "Cultural Color Meanings", "difficulty": "intermediate"},
            {"id": 13, "title": "Patterns & Designs", "difficulty": "intermediate"},
            # Advanced (2)
            {"id": 14, "title": "Complex Color Vocabulary", "difficulty": "advanced"},
            {"id": 15, "title": "Colors in Art & Culture", "difficulty": "advanced"},
        ]
    },
    {
        "name": "Transportation",
        "part": 8,
        "icon": "🚗",
        "topics": [
            # Beginner (10)
            {"id": 1, "title": "Types of Vehicles", "difficulty": "beginner"},
            {"id": 2, "title": "Taking a Taxi", "difficulty": "beginner"},
            {"id": 3, "title": "Public Buses", "difficulty": "beginner"},
            {"id": 4, "title": "Airport & Flying", "difficulty": "beginner"},
            {"id": 5, "title": "Train & Railway", "difficulty": "beginner"},
            {"id": 6, "title": "Walking & Pedestrian", "difficulty": "beginner"},
            {"id": 7, "title": "Bicycle & Motorcycle", "difficulty": "beginner"},
            {"id": 8, "title": "Car Rental", "difficulty": "beginner"},
            {"id": 9, "title": "Traffic & Roads", "difficulty": "beginner"},
            {"id": 10, "title": "Asking for Rides", "difficulty": "beginner"},
            # Intermediate (3)
            {"id": 11, "title": "Transportation Problems", "difficulty": "intermediate"},
            {"id": 12, "title": "Tickets & Fares", "difficulty": "intermediate"},
            {"id": 13, "title": "Travel Planning", "difficulty": "intermediate"},
            # Advanced (2)
            {"id": 14, "title": "Complex Transportation Scenarios", "difficulty": "advanced"},
            {"id": 15, "title": "Ethiopian Transportation System", "difficulty": "advanced"},
        ]
    },
    {
        "name": "Accommodation",
        "part": 9,
        "icon": "🏨",
        "topics": [
            # Beginner (10)
            {"id": 1, "title": "Hotel Check-in", "difficulty": "beginner"},
            {"id": 2, "title": "Room Types", "difficulty": "beginner"},
            {"id": 3, "title": "Hotel Amenities", "difficulty": "beginner"},
            {"id": 4, "title": "Room Service", "difficulty": "beginner"},
            {"id": 5, "title": "Problems & Complaints", "difficulty": "beginner"},
            {"id": 6, "title": "Check-out", "difficulty": "beginner"},
            {"id": 7, "title": "Making Reservations", "difficulty": "beginner"},
            {"id": 8, "title": "Hotel Facilities", "difficulty": "beginner"},
            {"id": 9, "title": "Staying with Family", "difficulty": "beginner"},
            {"id": 10, "title": "Payment & Bills", "difficulty": "beginner"},
            # Intermediate (3)
            {"id": 11, "title": "Special Requests", "difficulty": "intermediate"},
            {"id": 12, "title": "Long-term Stays", "difficulty": "intermediate"},
            {"id": 13, "title": "Traditional Lodging", "difficulty": "intermediate"},
            # Advanced (2)
            {"id": 14, "title": "Complex Accommodation Issues", "difficulty": "advanced"},
            {"id": 15, "title": "Ethiopian Hospitality Customs", "difficulty": "advanced"},
        ]
    },
    {
        "name": "Emergency",
        "part": 10,
        "icon": "🆘",
        "topics": [
            # Beginner (10)
            {"id": 1, "title": "Calling for Help", "difficulty": "beginner"},
            {"id": 2, "title": "Medical Emergency", "difficulty": "beginner"},
            {"id": 3, "title": "Police & Security", "difficulty": "beginner"},
            {"id": 4, "title": "Fire Emergency", "difficulty": "beginner"},
            {"id": 5, "title": "Accidents", "difficulty": "beginner"},
            {"id": 6, "title": "Lost Items", "difficulty": "beginner"},
            {"id": 7, "title": "Body Parts & Injuries", "difficulty": "beginner"},
            {"id": 8, "title": "Hospital & Clinic", "difficulty": "beginner"},
            {"id": 9, "title": "Pharmacy & Medicine", "difficulty": "beginner"},
            {"id": 10, "title": "Emergency Contacts", "difficulty": "beginner"},
            # Intermediate (3)
            {"id": 11, "title": "Describing Emergencies", "difficulty": "intermediate"},
            {"id": 12, "title": "Insurance & Documentation", "difficulty": "intermediate"},
            {"id": 13, "title": "Natural Disasters", "difficulty": "intermediate"},
            # Advanced (2)
            {"id": 14, "title": "Complex Emergency Situations", "difficulty": "advanced"},
            {"id": 15, "title": "Legal & Consular Help", "difficulty": "advanced"},
        ]
    },
    {
        "name": "Shopping",
        "part": 11,
        "icon": "🛍️",
        "topics": [
            # Beginner (10)
            {"id": 1, "title": "Market Basics", "difficulty": "beginner"},
            {"id": 2, "title": "Bargaining & Prices", "difficulty": "beginner"},
            {"id": 3, "title": "Clothing & Sizes", "difficulty": "beginner"},
            {"id": 4, "title": "Souvenirs & Gifts", "difficulty": "beginner"},
            {"id": 5, "title": "Electronics", "difficulty": "beginner"},
            {"id": 6, "title": "Food Shopping", "difficulty": "beginner"},
            {"id": 7, "title": "Traditional Crafts", "difficulty": "beginner"},
            {"id": 8, "title": "Payment Methods", "difficulty": "beginner"},
            {"id": 9, "title": "Returns & Exchanges", "difficulty": "beginner"},
            {"id": 10, "title": "Shopping Vocabulary", "difficulty": "beginner"},
            # Intermediate (3)
            {"id": 11, "title": "Quality & Materials", "difficulty": "intermediate"},
            {"id": 12, "title": "Traditional Markets", "difficulty": "intermediate"},
            {"id": 13, "title": "Modern Shopping Malls", "difficulty": "intermediate"},
            # Advanced (2)
            {"id": 14, "title": "Complex Transactions", "difficulty": "advanced"},
            {"id": 15, "title": "Ethiopian Market Culture", "difficulty": "advanced"},
        ]
    },
    {
        "name": "Weather",
        "part": 12,
        "icon": "🌤️",
        "topics": [
            # Beginner (10)
            {"id": 1, "title": "Weather Basics", "difficulty": "beginner"},
            {"id": 2, "title": "Seasons in Ethiopia", "difficulty": "beginner"},
            {"id": 3, "title": "Temperature", "difficulty": "beginner"},
            {"id": 4, "title": "Rain & Storms", "difficulty": "beginner"},
            {"id": 5, "title": "Sun & Clouds", "difficulty": "beginner"},
            {"id": 6, "title": "Wind", "difficulty": "beginner"},
            {"id": 7, "title": "Weather Forecast", "difficulty": "beginner"},
            {"id": 8, "title": "Dressing for Weather", "difficulty": "beginner"},
            {"id": 9, "title": "Climate Zones", "difficulty": "beginner"},
            {"id": 10, "title": "Weather Activities", "difficulty": "beginner"},
            # Intermediate (3)
            {"id": 11, "title": "Weather Patterns", "difficulty": "intermediate"},
            {"id": 12, "title": "Regional Climate", "difficulty": "intermediate"},
            {"id": 13, "title": "Weather Impact on Travel", "difficulty": "intermediate"},
            # Advanced (2)
            {"id": 14, "title": "Climate Change Discussion", "difficulty": "advanced"},
            {"id": 15, "title": "Traditional Weather Knowledge", "difficulty": "advanced"},
        ]
    },
]

LESSON_TEMPLATE = '''/// 🌟 EXPANDED Amharic Lessons - Part {part}: {name} (3000+ lines)
/// Professional Duolingo-style lessons with 15 comprehensive lessons
/// Distribution: 10 Beginner, 3 Intermediate, 2 Advanced
import 'package:tourist_assistive_app/features/language/models/amharic_lesson_models.dart';

class Amharic{camel_name}LessonsExpanded {{
  
  static final List<AmharicLesson> lessons = [
{lesson_calls}
  ];
  
  /// ========== BEGINNER LEVEL ==========
{beginner_methods}
  
  /// ========== INTERMEDIATE LEVEL ==========
{intermediate_methods}
  
  /// ========== ADVANCED LEVEL ==========
{advanced_methods}
}}
'''

def generate_category_file(category):
    """Generate a full expanded lesson file for a category"""
    camel_name = category["name"].replace(" ", "")
    
    # Generate lesson method calls
    lesson_calls = []
    for i in range(1, 16):
        lesson_calls.append(f"    _lesson{i}{category['topics'][i-1]['title'].replace(' ', '').replace('-', '').replace('&', 'And')}(),")
    
    # Generate lesson methods
    beginner_methods = []
    intermediate_methods = []
    advanced_methods = []
    
    for topic in category["topics"]:
        method_name = topic["title"].replace(" ", "").replace("-", "").replace("&", "And")
        lesson_id = f"{category['name'].lower()}_exp_{topic['id']:03d}"
        
        difficulty_map = {
            "beginner": ("BEGINNER", 20, "beginner_methods"),
            "intermediate": ("INTERMEDIATE", 30, "intermediate_methods"),
            "advanced": ("ADVANCED", 40, "advanced_methods")
        }
        
        diff_label, xp, method_list = difficulty_map[topic["difficulty"]]
        
        method = f'''
  /// Lesson {topic['id']}: {topic['title']} ({diff_label})
  static AmharicLesson _lesson{topic['id']}{method_name}() {{
    return AmharicLesson(
      id: '{lesson_id}',
      title: '{category['icon']} {topic['title']}',
      description: 'Master {topic['title'].lower()}',
      category: LessonCategory.{category['name'].lower()},
      difficulty: DifficultyLevel.{topic['difficulty']},
      order: {topic['id']},
      totalXP: {xp},
      exercises: [
        // TODO: Add 15-20 comprehensive exercises here
        // Exercise types: tapWhatYouHear, multipleChoice, completeTheChat,
        // translateText, fillInBlanks, listenAndRepeat, matchPairs, speakPhrase
      ],
    );
  }}
'''
        
        if topic["difficulty"] == "beginner":
            beginner_methods.append(method)
        elif topic["difficulty"] == "intermediate":
            intermediate_methods.append(method)
        else:
            advanced_methods.append(method)
    
    # Generate full file
    file_content = LESSON_TEMPLATE.format(
        part=category["part"],
        name=category["name"],
        camel_name=camel_name,
        lesson_calls="\n".join(lesson_calls),
        beginner_methods="".join(beginner_methods),
        intermediate_methods="".join(intermediate_methods),
        advanced_methods="".join(advanced_methods)
    )
    
    return file_content

def main():
    """Generate all expanded lesson files"""
    print("🌟 Generating Expanded Lessons...")
    
    for category in CATEGORIES:
        filename = f"amharic_lessons_part{category['part']}_{category['name'].lower()}_expanded.dart"
        filepath = f"../lib/features/language/data/{filename}"
        
        content = generate_category_file(category)
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        
        print(f"✅ Generated: {filename}")
    
    print("\n🎉 All expanded lesson files generated!")
    print("📝 Next steps:")
    print("   1. Fill in the exercises for each lesson (15-20 per lesson)")
    print("   2. Update comprehensive_lessons_loader.dart to import all new files")
    print("   3. Run the app and test!")

if __name__ == "__main__":
    main()
