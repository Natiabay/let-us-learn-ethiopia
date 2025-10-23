import * as admin from 'firebase-admin';

// Comprehensive lesson data for all 11 languages
export const lessonSeedData = {
  // English → Amharic Lessons (50+ lessons)
  english: [
    {
      id: 'en_am_001',
      title: 'Essential Greetings',
      description: 'Master basic greetings for daily interactions in Ethiopia',
      level: 'beginner',
      languageCode: 'en',
      estimatedMinutes: 8,
      xpReward: 150,
      category: 'Greetings',
      vocabulary: [
        'ሰላም (selam) - Hello/Peace',
        'እንደምን ነህ? (endemen neh?) - How are you? (to male)',
        'እንደምን ነሽ? (endemen nesh?) - How are you? (to female)',
        'ደህና ነኝ (dehna neny) - I am fine',
        'ቻው (chaw) - Goodbye',
        'አመሰግናለሁ (amesegnalehu) - Thank you',
        'እባክህ (ebakih) - Please',
        'ይቅርታ (yiqerta) - Excuse me'
      ],
      exercises: [
        {
          id: 'ex1_greeting_listen',
          type: 'listen',
          instruction: 'Listen and repeat: "ሰላም"',
          amharicText: 'ሰላም',
          translation: 'Hello/Peace',
          audioUrl: 'audio/amharic/beginner/selam.mp3',
          options: [
            { text: 'ሰላም', isCorrect: true },
            { text: 'ቻው', isCorrect: false },
            { text: 'እንደምን', isCorrect: false }
          ],
          correctAnswer: 'ሰላም',
          explanation: 'ሰላም means "hello" or "peace" - the most common greeting in Amharic'
        }
      ]
    },
    {
      id: 'en_am_002',
      title: 'Numbers 1-20',
      description: 'Learn essential numbers for shopping, prices, and basic counting',
      level: 'beginner',
      languageCode: 'en',
      estimatedMinutes: 10,
      xpReward: 180,
      category: 'Numbers',
      vocabulary: [
        'አንድ (and) - One',
        'ሁለት (hulet) - Two',
        'ሦስት (sost) - Three',
        'አራት (arat) - Four',
        'አምስት (amest) - Five',
        'ስድስት (sedest) - Six',
        'ሰባት (sebat) - Seven',
        'ስምንት (semint) - Eight',
        'ዘጠኝ (zeten) - Nine',
        'አስር (asir) - Ten'
      ],
      exercises: [
        {
          id: 'ex1_number_listen',
          type: 'listen',
          instruction: 'Listen and identify the number: "ሁለት"',
          amharicText: 'ሁለት',
          translation: 'Two',
          audioUrl: 'audio/amharic/beginner/hulet.mp3',
          options: [
            { text: 'One', isCorrect: false },
            { text: 'Two', isCorrect: true },
            { text: 'Three', isCorrect: false },
            { text: 'Four', isCorrect: false }
          ],
          correctAnswer: 'Two',
          explanation: 'ሁለት means "two" in Amharic'
        }
      ]
    }
    // Add 48 more lessons...
  ],

  // Arabic → Amharic Lessons
  arabic: [
    {
      id: 'ar_am_001',
      title: 'التحيات الأساسية',
      description: 'تعلم التحيات الأساسية للتفاعل اليومي في إثيوبيا',
      level: 'beginner',
      languageCode: 'ar',
      estimatedMinutes: 8,
      xpReward: 150,
      category: 'Greetings',
      vocabulary: [
        'ሰላም (selam) - مرحبا/سلام',
        'እንደምን ነህ? (endemen neh?) - كيف حالك؟ (للذكر)',
        'እንደምን ነሽ? (endemen nesh?) - كيف حالك؟ (للأنثى)',
        'ደህና ነኝ (dehna neny) - أنا بخير',
        'ቻው (chaw) - وداعا',
        'አመሰግናለሁ (amesegnalehu) - شكرا',
        'እባክህ (ebakih) - من فضلك',
        'ይቅርታ (yiqerta) - اعذرني'
      ],
      exercises: [
        {
          id: 'ex1_greeting_listen_ar',
          type: 'listen',
          instruction: 'استمع وكرر: "ሰላም"',
          amharicText: 'ሰላም',
          translation: 'مرحبا/سلام',
          audioUrl: 'audio/amharic/beginner/selam.mp3',
          options: [
            { text: 'ሰላም', isCorrect: true },
            { text: 'ቻው', isCorrect: false },
            { text: 'እንደምን', isCorrect: false }
          ],
          correctAnswer: 'ሰላም',
          explanation: 'ሰላም تعني "مرحبا" أو "سلام" - التحية الأكثر شيوعا في الأمهرية'
        }
      ]
    }
    // Add 49 more lessons...
  ],

  // French → Amharic Lessons
  french: [
    {
      id: 'fr_am_001',
      title: 'Salutations Essentielles',
      description: 'Maîtrisez les salutations de base pour les interactions quotidiennes en Éthiopie',
      level: 'beginner',
      languageCode: 'fr',
      estimatedMinutes: 8,
      xpReward: 150,
      category: 'Greetings',
      vocabulary: [
        'ሰላም (selam) - Bonjour/Paix',
        'እንደምን ነህ? (endemen neh?) - Comment allez-vous? (masculin)',
        'እንደምን ነሽ? (endemen nesh?) - Comment allez-vous? (féminin)',
        'ደህና ነኝ (dehna neny) - Je vais bien',
        'ቻው (chaw) - Au revoir',
        'አመሰግናለሁ (amesegnalehu) - Merci',
        'እባክህ (ebakih) - S\'il vous plaît',
        'ይቅርታ (yiqerta) - Excusez-moi'
      ],
      exercises: [
        {
          id: 'ex1_greeting_listen_fr',
          type: 'listen',
          instruction: 'Écoutez et répétez: "ሰላም"',
          amharicText: 'ሰላም',
          translation: 'Bonjour/Paix',
          audioUrl: 'audio/amharic/beginner/selam.mp3',
          options: [
            { text: 'ሰላም', isCorrect: true },
            { text: 'ቻው', isCorrect: false },
            { text: 'እንደምን', isCorrect: false }
          ],
          correctAnswer: 'ሰላም',
          explanation: 'ሰላም signifie "bonjour" ou "paix" - la salutation la plus courante en amharique'
        }
      ]
    }
    // Add 49 more lessons...
  ]

  // Add 8 more languages (Spanish, German, Italian, Portuguese, Russian, Japanese, Chinese, Hindi)
};

// Knowledge base data for RAG
export const knowledgeBaseData = [
  {
    id: 'kb_001',
    title: 'Ethiopian Food Culture',
    content: 'Ethiopian cuisine is one of the most unique and flavorful in the world. The national dish is injera, a sourdough flatbread made from teff flour. It\'s served with various stews called wats, including doro wat (chicken stew), kitfo (minced raw beef), and shiro (chickpea stew). The coffee ceremony is a central part of Ethiopian culture, involving roasting, grinding, and brewing coffee beans in a traditional clay pot called a jebena.',
    category: 'food',
    keywords: ['food', 'cuisine', 'injera', 'coffee', 'culture', 'traditional'],
    metadata: {
      importance: 'high',
      cultural_significance: 'very_high',
      tourist_relevance: 'essential'
    }
  },
  {
    id: 'kb_002',
    title: 'Lalibela Rock-Hewn Churches',
    content: 'Lalibela is home to 11 medieval rock-hewn churches, carved entirely from single blocks of stone. These UNESCO World Heritage sites were built in the 12th century by King Lalibela. The most famous is Bete Giyorgis (Church of St. George), shaped like a cross. The churches are still active places of worship and are connected by a network of tunnels and trenches.',
    category: 'places',
    keywords: ['lalibela', 'churches', 'unesco', 'heritage', 'religious', 'architecture'],
    metadata: {
      importance: 'very_high',
      cultural_significance: 'very_high',
      tourist_relevance: 'essential'
    }
  },
  {
    id: 'kb_003',
    title: 'Amharic Language Basics',
    content: 'Amharic is the official language of Ethiopia, spoken by over 20 million people. It uses the Ge\'ez script, one of the oldest writing systems in the world. Key phrases include "Selam" (hello), "Ameseginalehu" (thank you), and "Endemen neh?" (how are you?). The language has unique sounds and grammar that reflect Ethiopia\'s rich cultural heritage.',
    category: 'language',
    keywords: ['amharic', 'language', 'geez', 'script', 'phrases', 'culture'],
    metadata: {
      importance: 'high',
      cultural_significance: 'very_high',
      tourist_relevance: 'very_high'
    }
  },
  {
    id: 'kb_004',
    title: 'Ethiopian Transportation',
    content: 'Getting around Ethiopia involves various transportation options. Domestic flights connect major cities like Addis Ababa, Bahir Dar, and Lalibela. Buses are the most common form of long-distance travel, with both public and private operators. In cities, blue and white minibuses called "line taxis" are popular. Bajaj (three-wheeled vehicles) and regular taxis are available for shorter distances.',
    category: 'transportation',
    keywords: ['transportation', 'flights', 'buses', 'taxis', 'travel', 'domestic'],
    metadata: {
      importance: 'high',
      cultural_significance: 'medium',
      tourist_relevance: 'very_high'
    }
  },
  {
    id: 'kb_005',
    title: 'Ethiopian Cultural Etiquette',
    content: 'Ethiopian culture places great emphasis on respect and hospitality. When greeting, a handshake is common, but close friends may kiss on both cheeks. It\'s respectful to use both hands when giving or receiving items. Shoes are removed before entering homes and religious sites. The right hand is used for eating, as the left is considered unclean. Always accept coffee when offered, as refusing can be seen as impolite.',
    category: 'culture',
    keywords: ['etiquette', 'culture', 'respect', 'hospitality', 'traditions', 'customs'],
    metadata: {
      importance: 'very_high',
      cultural_significance: 'very_high',
      tourist_relevance: 'essential'
    }
  }
];

// Function to seed the database
export async function seedDatabase() {
  const db = admin.firestore();
  
  try {
    console.log('Starting database seeding...');
    
    // Seed lessons for all languages
    for (const [language, lessons] of Object.entries(lessonSeedData)) {
      console.log(`Seeding ${language} lessons...`);
      
      for (const lesson of lessons) {
        await db.collection('lessons').doc(lesson.id).set({
          ...lesson,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          updatedAt: admin.firestore.FieldValue.serverTimestamp()
        });
      }
    }
    
    // Seed knowledge base
    console.log('Seeding knowledge base...');
    for (const knowledge of knowledgeBaseData) {
      await db.collection('knowledge_base').doc(knowledge.id).set({
        ...knowledge,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      });
    }
    
    // Seed language configurations
    console.log('Seeding language configurations...');
    const languages = [
      { code: 'en', name: 'English', nativeName: 'English', flag: '🇺🇸' },
      { code: 'ar', name: 'Arabic', nativeName: 'العربية', flag: '🇸🇦' },
      { code: 'fr', name: 'French', nativeName: 'Français', flag: '🇫🇷' },
      { code: 'es', name: 'Spanish', nativeName: 'Español', flag: '🇪🇸' },
      { code: 'de', name: 'German', nativeName: 'Deutsch', flag: '🇩🇪' },
      { code: 'it', name: 'Italian', nativeName: 'Italiano', flag: '🇮🇹' },
      { code: 'pt', name: 'Portuguese', nativeName: 'Português', flag: '🇵🇹' },
      { code: 'ru', name: 'Russian', nativeName: 'Русский', flag: '🇷🇺' },
      { code: 'ja', name: 'Japanese', nativeName: '日本語', flag: '🇯🇵' },
      { code: 'zh', name: 'Chinese', nativeName: '中文', flag: '🇨🇳' },
      { code: 'hi', name: 'Hindi', nativeName: 'हिन्दी', flag: '🇮🇳' }
    ];
    
    for (const language of languages) {
      await db.collection('languages').doc(language.code).set({
        ...language,
        isActive: true,
        createdAt: admin.firestore.FieldValue.serverTimestamp()
      });
    }
    
    console.log('Database seeding completed successfully!');
    return { success: true, message: 'Database seeded successfully' };
    
  } catch (error) {
    console.error('Database seeding error:', error);
    return { success: false, error: error.message };
  }
}






























