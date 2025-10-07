import '../models/comprehensive_lesson_model.dart';

/// Comprehensive lesson expansion for all languages
/// This file contains lesson generators to ensure each language has 50+ lessons
class ComprehensiveLessonExpansion {
  
  /// Generate additional lessons for English
  static List<Lesson> generateAdditionalEnglishLessons() {
    return [
      // Beginner lessons 8-20
      _createEnglishLesson('en_beginner_8', 'Body Parts', 'Learn essential body parts vocabulary', 'Body', [
        'እጅ - Hand', 'እግር - Foot/Leg', 'አይን - Eye', 'አፍ - Mouth', 'አዕምሮ - Head', 'ልብ - Heart', 'ጆሮ - Ear', 'አፍንጫ - Nose'
      ]),
      _createEnglishLesson('en_beginner_9', 'Animals', 'Learn common animal names', 'Animals', [
        'ውሻ - Dog', 'ድር - Cat', 'አህያ - Donkey', 'ግምጃ - Horse', 'ኮረብታ - Cow', 'አይጥ - Goat', 'አሳ - Fish', 'አንበሳ - Lion'
      ]),
      _createEnglishLesson('en_beginner_10', 'Clothing', 'Learn clothing vocabulary', 'Clothing', [
        'ሸሚዝ - Shirt', 'ጫማ - Shoe', 'ቦታ - Hat', 'ካባ - Coat', 'ሱሪ - Pants', 'አልባሳት - Clothes', 'ጨርቅ - Fabric', 'ልብስ - Dress'
      ]),
      _createEnglishLesson('en_beginner_11', 'Places', 'Learn common places vocabulary', 'Places', [
        'ቤት - House', 'መስጊድ - Mosque', 'ክርስቲያን - Church', 'መደብር - Shop', 'መዋኛ - Hospital', 'ትምህርት ቤት - School', 'መጽሐፍ ቤት - Library', 'መናፈሻ - Park'
      ]),
      _createEnglishLesson('en_beginner_12', 'Verbs', 'Learn essential action verbs', 'Verbs', [
        'መሄድ - To go', 'መምጣት - To come', 'መብላት - To eat', 'መጠጣት - To drink', 'መተኛት - To sleep', 'መነሳት - To wake up', 'መስራት - To work', 'መጫወት - To play'
      ]),
      _createEnglishLesson('en_beginner_13', 'Adjectives', 'Learn descriptive words', 'Adjectives', [
        'ትልቅ - Big', 'ትንሽ - Small', 'ረዥም - Long', 'አጫጭር - Short', 'ሰፊ - Wide', 'ጠባብ - Narrow', 'ከፍታ - Tall', 'ዝቅታ - Short'
      ]),
      _createEnglishLesson('en_beginner_14', 'Emotions', 'Learn emotion vocabulary', 'Emotions', [
        'ደስታ - Happy', 'ሐዘን - Sad', 'ቁጣ - Angry', 'ፍርሃት - Afraid', 'መደነቅ - Surprised', 'መጠራጠር - Worried', 'መረጋጋት - Calm', 'መደነቅ - Excited'
      ]),
      _createEnglishLesson('en_beginner_15', 'Daily Activities', 'Learn daily routine vocabulary', 'Daily', [
        'መነሳት - To wake up', 'መታጠብ - To wash', 'መብላት - To eat', 'መስራት - To work', 'መጫወት - To play', 'መተኛት - To sleep', 'መማር - To study', 'መጠጣት - To drink'
      ]),
      _createEnglishLesson('en_beginner_16', 'Household Items', 'Learn household vocabulary', 'Household', [
        'ጠረጴዛ - Table', 'ወንበር - Chair', 'አልጋ - Bed', 'መብራት - Light', 'መስኮት - Window', 'በር - Door', 'መታጠቢያ - Bathroom', 'ማድቤት - Kitchen'
      ]),
      _createEnglishLesson('en_beginner_17', 'School Supplies', 'Learn school vocabulary', 'School', [
        'መጽሐፍ - Book', 'እርሳስ - Pen', 'ጠረጴዛ - Desk', 'መምህር - Teacher', 'ተማሪ - Student', 'ክፍል - Classroom', 'መማሪያ - Lesson', 'ፈተና - Exam'
      ]),
      _createEnglishLesson('en_beginner_18', 'Sports', 'Learn sports vocabulary', 'Sports', [
        'ኳስ - Ball', 'መሮጥ - To run', 'መዝለል - To jump', 'መጫወት - To play', 'መሸነፍ - To win', 'መሸነፍ - To lose', 'መለማመድ - To practice', 'መወዳደር - To compete'
      ]),
      _createEnglishLesson('en_beginner_19', 'Music', 'Learn music vocabulary', 'Music', [
        'ሙዚቃ - Music', 'መስማት - To listen', 'መዘፈን - To sing', 'መጫወት - To play', 'መንቀል - To dance', 'መሳሪያ - Instrument', 'ገጽታ - Song', 'መስማት - Sound'
      ]),
      _createEnglishLesson('en_beginner_20', 'Nature', 'Learn nature vocabulary', 'Nature', [
        'ፀሐይ - Sun', 'ጨረቃ - Moon', 'ኮከብ - Star', 'ደመና - Cloud', 'ዝናብ - Rain', 'ንፋስ - Wind', 'ጫካ - Forest', 'ተራራ - Mountain'
      ]),
    ];
  }

  /// Generate additional lessons for Spanish
  static List<Lesson> generateAdditionalSpanishLessons() {
    return [
      _createSpanishLesson('es_beginner_4', 'Colores Básicos', 'Aprende colores básicos en amárico', 'Colores', [
        'ቀይ - Rojo', 'ሰማያዊ - Azul', 'አረንጓዴ - Verde', 'ቢጫ - Amarillo', 'ጥቁር - Negro', 'ነጭ - Blanco', 'ቡናማ - Marrón', 'ሮዝ - Rosa'
      ]),
      _createSpanishLesson('es_beginner_5', 'Comida y Bebidas', 'Vocabulario esencial de comida y bebidas', 'Comida', [
        'ውሃ - Agua', 'ዳቦ - Pan', 'ሩዝ - Arroz', 'ስጋ - Carne', 'ዓሣ - Pescado', 'ዶሮ - Pollo', 'አትክልት - Vegetales', 'ፍራፍሬ - Fruta'
      ]),
      _createSpanishLesson('es_beginner_6', 'Partes del Cuerpo', 'Aprende partes del cuerpo en amárico', 'Cuerpo', [
        'እጅ - Mano', 'እግር - Pie/Pierna', 'አይን - Ojo', 'አፍ - Boca', 'አዕምሮ - Cabeza', 'ልብ - Corazón', 'ጆሮ - Oreja', 'አፍንጫ - Nariz'
      ]),
      _createSpanishLesson('es_beginner_7', 'Animales', 'Aprende nombres de animales', 'Animales', [
        'ውሻ - Perro', 'ድር - Gato', 'አህያ - Burro', 'ግምጃ - Caballo', 'ኮረብታ - Vaca', 'አይጥ - Cabra', 'አሳ - Pescado', 'አንበሳ - León'
      ]),
      _createSpanishLesson('es_beginner_8', 'Ropa', 'Aprende vocabulario de ropa', 'Ropa', [
        'ሸሚዝ - Camisa', 'ጫማ - Zapato', 'ቦታ - Sombrero', 'ካባ - Abrigo', 'ሱሪ - Pantalones', 'አልባሳት - Ropa', 'ጨርቅ - Tela', 'ልብስ - Vestido'
      ]),
      _createSpanishLesson('es_beginner_9', 'Lugares', 'Aprende vocabulario de lugares', 'Lugares', [
        'ቤት - Casa', 'መስጊድ - Mezquita', 'ክርስቲያን - Iglesia', 'መደብር - Tienda', 'መዋኛ - Hospital', 'ትምህርት ቤት - Escuela', 'መጽሐፍ ቤት - Biblioteca', 'መናፈሻ - Parque'
      ]),
      _createSpanishLesson('es_beginner_10', 'Verbos', 'Aprende verbos esenciales', 'Verbos', [
        'መሄድ - Ir', 'መምጣት - Venir', 'መብላት - Comer', 'መጠጣት - Beber', 'መተኛት - Dormir', 'መነሳት - Despertar', 'መስራት - Trabajar', 'መጫወት - Jugar'
      ]),
      _createSpanishLesson('es_beginner_11', 'Verbos', 'Aprende verbos esenciales', 'Verbos', [
        'መሄድ - Ir', 'መምጣት - Venir', 'መብላት - Comer', 'መጠጣት - Beber', 'መተኛት - Dormir', 'መነሳት - Despertar', 'መስራት - Trabajar', 'መጫወት - Jugar'
      ]),
      _createSpanishLesson('es_beginner_12', 'Adjetivos', 'Aprende palabras descriptivas', 'Adjetivos', [
        'ትልቅ - Grande', 'ትንሽ - Pequeño', 'ረዥም - Largo', 'አጫጭር - Corto', 'ሰፊ - Ancho', 'ጠባብ - Estrecho', 'ከፍታ - Alto', 'ዝቅታ - Bajo'
      ]),
      _createSpanishLesson('es_beginner_13', 'Emociones', 'Aprende vocabulario de emociones', 'Emociones', [
        'ደስታ - Feliz', 'ሐዘን - Triste', 'ቁጣ - Enojado', 'ፍርሃት - Asustado', 'መደነቅ - Sorprendido', 'መጠራጠር - Preocupado', 'መረጋጋት - Tranquilo', 'መደነቅ - Emocionado'
      ]),
      _createSpanishLesson('es_beginner_14', 'Actividades Diarias', 'Aprende vocabulario de rutina diaria', 'Diario', [
        'መነሳት - Despertar', 'መታጠብ - Lavar', 'መብላት - Comer', 'መስራት - Trabajar', 'መጫወት - Jugar', 'መተኛት - Dormir', 'መማር - Estudiar', 'መጠጣት - Beber'
      ]),
      _createSpanishLesson('es_beginner_15', 'Artículos del Hogar', 'Aprende vocabulario del hogar', 'Hogar', [
        'ጠረጴዛ - Mesa', 'ወንበር - Silla', 'አልጋ - Cama', 'መብራት - Luz', 'መስኮት - Ventana', 'በር - Puerta', 'መታጠቢያ - Baño', 'ማድቤት - Cocina'
      ]),
      _createSpanishLesson('es_beginner_16', 'Útiles Escolares', 'Aprende vocabulario escolar', 'Escuela', [
        'መጽሐፍ - Libro', 'እርሳስ - Bolígrafo', 'ጠረጴዛ - Escritorio', 'መምህር - Maestro', 'ተማሪ - Estudiante', 'ክፍል - Aula', 'መማሪያ - Lección', 'ፈተና - Examen'
      ]),
      _createSpanishLesson('es_beginner_17', 'Deportes', 'Aprende vocabulario deportivo', 'Deportes', [
        'ኳስ - Pelota', 'መሮጥ - Correr', 'መዝለል - Saltar', 'መጫወት - Jugar', 'መሸነፍ - Ganar', 'መሸነፍ - Perder', 'መለማመድ - Practicar', 'መወዳደር - Competir'
      ]),
      _createSpanishLesson('es_beginner_18', 'Música', 'Aprende vocabulario musical', 'Música', [
        'ሙዚቃ - Música', 'መስማት - Escuchar', 'መዘፈን - Cantar', 'መጫወት - Tocar', 'መንቀል - Bailar', 'መሳሪያ - Instrumento', 'ገጽታ - Canción', 'መስማት - Sonido'
      ]),
      _createSpanishLesson('es_beginner_19', 'Naturaleza', 'Aprende vocabulario de naturaleza', 'Naturaleza', [
        'ፀሐይ - Sol', 'ጨረቃ - Luna', 'ኮከብ - Estrella', 'ደመና - Nube', 'ዝናብ - Lluvia', 'ንፋስ - Viento', 'ጫካ - Bosque', 'ተራራ - Montaña'
      ]),
      _createSpanishLesson('es_beginner_20', 'Tiempo y Fechas', 'Aprende vocabulario de tiempo', 'Tiempo', [
        'ጊዜ - Tiempo', 'ሰዓት - Hora', 'ደቂቃ - Minuto', 'ዛሬ - Hoy', 'ነገ - Mañana', 'ትላንት - Ayer', 'ጠዋት - Mañana', 'ምሽት - Noche'
      ]),
      // Add more Spanish lessons...
    ];
  }

  /// Generate additional lessons for French
  static List<Lesson> generateAdditionalFrenchLessons() {
    return [
      _createFrenchLesson('fr_beginner_3', 'Membres de la famille', 'Apprenez les termes de famille', 'Famille', [
        'አባት - Père', 'እናት - Mère', 'ወንድም - Frère', 'እህት - Sœur', 'ወንድ ልጅ - Fils', 'ሴት ልጅ - Fille', 'አያት - Grand-père', 'አክስት - Tante'
      ]),
      _createFrenchLesson('fr_beginner_4', 'Couleurs de base', 'Apprenez les couleurs de base', 'Couleurs', [
        'ቀይ - Rouge', 'ሰማያዊ - Bleu', 'አረንጓዴ - Vert', 'ቢጫ - Jaune', 'ጥቁር - Noir', 'ነጭ - Blanc', 'ቡናማ - Marron', 'ሮዝ - Rose'
      ]),
      _createFrenchLesson('fr_beginner_5', 'Nourriture et boissons', 'Vocabulaire alimentaire essentiel', 'Nourriture', [
        'ውሃ - Eau', 'ዳቦ - Pain', 'ሩዝ - Riz', 'ስጋ - Viande', 'ዓሣ - Poisson', 'ዶሮ - Poulet', 'አትክልት - Légumes', 'ፍራፍሬ - Fruit'
      ]),
      _createFrenchLesson('fr_beginner_6', 'Parties du corps', 'Apprenez les parties du corps', 'Corps', [
        'እጅ - Main', 'እግር - Pied/Jambe', 'አይን - Œil', 'አፍ - Bouche', 'አዕምሮ - Tête', 'ልብ - Cœur', 'ጆሮ - Oreille', 'አፍንጫ - Nez'
      ]),
      _createFrenchLesson('fr_beginner_7', 'Animaux', 'Apprenez les noms d\'animaux', 'Animaux', [
        'ውሻ - Chien', 'ድር - Chat', 'አህያ - Âne', 'ግምጃ - Cheval', 'ኮረብታ - Vache', 'አይጥ - Chèvre', 'አሳ - Poisson', 'አንበሳ - Lion'
      ]),
      _createFrenchLesson('fr_beginner_8', 'Vêtements', 'Apprenez le vocabulaire vestimentaire', 'Vêtements', [
        'ሸሚዝ - Chemise', 'ጫማ - Chaussure', 'ቦታ - Chapeau', 'ካባ - Manteau', 'ሱሪ - Pantalon', 'አልባሳት - Vêtements', 'ጨርቅ - Tissu', 'ልብስ - Robe'
      ]),
      _createFrenchLesson('fr_beginner_9', 'Lieux', 'Apprenez le vocabulaire des lieux', 'Lieux', [
        'ቤት - Maison', 'መስጊድ - Mosquée', 'ክርስቲያን - Église', 'መደብር - Magasin', 'መዋኛ - Hôpital', 'ትምህርት ቤት - École', 'መጽሐፍ ቤት - Bibliothèque', 'መናፈሻ - Parc'
      ]),
      _createFrenchLesson('fr_beginner_10', 'Verbes', 'Apprenez les verbes essentiels', 'Verbes', [
        'መሄድ - Aller', 'መምጣት - Venir', 'መብላት - Manger', 'መጠጣት - Boire', 'መተኛት - Dormir', 'መነሳት - Se réveiller', 'መስራት - Travailler', 'መጫወት - Jouer'
      ]),
      _createFrenchLesson('fr_beginner_11', 'Adjectifs', 'Apprenez les mots descriptifs', 'Adjectifs', [
        'ትልቅ - Grand', 'ትንሽ - Petit', 'ረዥም - Long', 'አጫጭር - Court', 'ሰፊ - Large', 'ጠባብ - Étroit', 'ከፍታ - Haut', 'ዝቅታ - Bas'
      ]),
      _createFrenchLesson('fr_beginner_12', 'Émotions', 'Apprenez le vocabulaire des émotions', 'Émotions', [
        'ደስታ - Heureux', 'ሐዘን - Triste', 'ቁጣ - En colère', 'ፍርሃት - Effrayé', 'መደነቅ - Surpris', 'መጠራጠር - Inquiet', 'መረጋጋት - Calme', 'መደነቅ - Excité'
      ]),
      _createFrenchLesson('fr_beginner_13', 'Activités quotidiennes', 'Apprenez le vocabulaire de routine', 'Quotidien', [
        'መነሳት - Se réveiller', 'መታጠብ - Se laver', 'መብላት - Manger', 'መስራት - Travailler', 'መጫወት - Jouer', 'መተኛት - Dormir', 'መማር - Étudier', 'መጠጣት - Boire'
      ]),
      _createFrenchLesson('fr_beginner_14', 'Articles ménagers', 'Apprenez le vocabulaire domestique', 'Ménage', [
        'ጠረጴዛ - Table', 'ወንበር - Chaise', 'አልጋ - Lit', 'መብራት - Lumière', 'መስኮት - Fenêtre', 'በር - Porte', 'መታጠቢያ - Salle de bain', 'ማድቤት - Cuisine'
      ]),
      _createFrenchLesson('fr_beginner_15', 'Fournitures scolaires', 'Apprenez le vocabulaire scolaire', 'École', [
        'መጽሐፍ - Livre', 'እርሳስ - Stylo', 'ጠረጴዛ - Bureau', 'መምህር - Enseignant', 'ተማሪ - Étudiant', 'ክፍል - Classe', 'መማሪያ - Leçon', 'ፈተና - Examen'
      ]),
      _createFrenchLesson('fr_beginner_16', 'Sports', 'Apprenez le vocabulaire sportif', 'Sports', [
        'ኳስ - Ballon', 'መሮጥ - Courir', 'መዝለል - Sauter', 'መጫወት - Jouer', 'መሸነፍ - Gagner', 'መሸነፍ - Perdre', 'መለማመድ - S\'entraîner', 'መወዳደር - Compétitionner'
      ]),
      _createFrenchLesson('fr_beginner_17', 'Musique', 'Apprenez le vocabulaire musical', 'Musique', [
        'ሙዚቃ - Musique', 'መስማት - Écouter', 'መዘፈን - Chanter', 'መጫወት - Jouer', 'መንቀል - Danser', 'መሳሪያ - Instrument', 'ገጽታ - Chanson', 'መስማት - Son'
      ]),
      _createFrenchLesson('fr_beginner_18', 'Nature', 'Apprenez le vocabulaire de la nature', 'Nature', [
        'ፀሐይ - Soleil', 'ጨረቃ - Lune', 'ኮከብ - Étoile', 'ደመና - Nuage', 'ዝናብ - Pluie', 'ንፋስ - Vent', 'ጫካ - Forêt', 'ተራራ - Montagne'
      ]),
      _createFrenchLesson('fr_beginner_19', 'Temps et dates', 'Apprenez le vocabulaire temporel', 'Temps', [
        'ጊዜ - Temps', 'ሰዓት - Heure', 'ደቂቃ - Minute', 'ዛሬ - Aujourd\'hui', 'ነገ - Demain', 'ትላንት - Hier', 'ጠዋት - Matin', 'ምሽት - Soir'
      ]),
      _createFrenchLesson('fr_beginner_20', 'Météo', 'Apprenez le vocabulaire météorologique', 'Météo', [
        'ፀሐይ ያለች - Ensoleillé', 'ዝናባማ - Pluvieux', 'ደመናማ - Nuageux', 'ሙቅ - Chaud', 'ቀዝቃዛ - Froid', 'ነፋሳማ - Venteux', 'ዝናብ - Pluie', 'ፀሐይ - Soleil'
      ]),
      // Add more French lessons...
    ];
  }

  /// Generate additional lessons for Arabic
  static List<Lesson> generateAdditionalArabicLessons() {
    return [
      _createArabicLesson('ar_am_beginner_5', 'الألوان الأساسية', 'تعلم الألوان الأساسية بالأمهرية', 'الألوان', [
        'ቀይ - أحمر', 'ሰማያዊ - أزرق', 'አረንጓዴ - أخضر', 'ቢጫ - أصفر', 'ጥቁር - أسود', 'ነጭ - أبيض', 'ቡናማ - بني', 'ሮዝ - وردي'
      ]),
      _createArabicLesson('ar_am_beginner_6', 'الطعام والشراب', 'مفردات الطعام والشراب الأساسية', 'الطعام', [
        'ውሃ - ماء', 'ዳቦ - خبز', 'ሩዝ - أرز', 'ስጋ - لحم', 'ዓሣ - سمك', 'ዶሮ - دجاج', 'አትክልት - خضروات', 'ፍራፍሬ - فواكه'
      ]),
      _createArabicLesson('ar_am_beginner_7', 'أجزاء الجسم', 'تعلم أجزاء الجسم بالأمهرية', 'الجسم', [
        'እጅ - يد', 'እግር - قدم/ساق', 'አይን - عين', 'አፍ - فم', 'አዕምሮ - رأس', 'ልብ - قلب', 'ጆሮ - أذن', 'አፍንጫ - أنف'
      ]),
      _createArabicLesson('ar_am_beginner_8', 'الحيوانات', 'تعلم أسماء الحيوانات', 'الحيوانات', [
        'ውሻ - كلب', 'ድር - قط', 'አህያ - حمار', 'ግምጃ - حصان', 'ኮረብታ - بقرة', 'አይጥ - ماعز', 'አሳ - سمك', 'አንበሳ - أسد'
      ]),
      _createArabicLesson('ar_am_beginner_9', 'الملابس', 'تعلم مفردات الملابس', 'الملابس', [
        'ሸሚዝ - قميص', 'ጫማ - حذاء', 'ቦታ - قبعة', 'ካባ - معطف', 'ሱሪ - بنطلون', 'አልባሳት - ملابس', 'ጨርቅ - قماش', 'ልብስ - فستان'
      ]),
      _createArabicLesson('ar_am_beginner_10', 'الأماكن', 'تعلم مفردات الأماكن', 'الأماكن', [
        'ቤት - منزل', 'መስጊድ - مسجد', 'ክርስቲያን - كنيسة', 'መደብር - متجر', 'መዋኛ - مستشفى', 'ትምህርት ቤት - مدرسة', 'መጽሐፍ ቤት - مكتبة', 'መናፈሻ - حديقة'
      ]),
      _createArabicLesson('ar_am_beginner_11', 'الأفعال', 'تعلم الأفعال الأساسية', 'الأفعال', [
        'መሄድ - الذهاب', 'መምጣት - المجيء', 'መብላት - الأكل', 'መጠጣት - الشرب', 'መተኛት - النوم', 'መነሳት - الاستيقاظ', 'መስራት - العمل', 'መጫወት - اللعب'
      ]),
      _createArabicLesson('ar_am_beginner_12', 'الصفات', 'تعلم الكلمات الوصفية', 'الصفات', [
        'ትልቅ - كبير', 'ትንሽ - صغير', 'ረዥም - طويل', 'አጫጭር - قصير', 'ሰፊ - عريض', 'ጠባብ - ضيق', 'ከፍታ - عالي', 'ዝቅታ - منخفض'
      ]),
      _createArabicLesson('ar_am_beginner_13', 'المشاعر', 'تعلم مفردات المشاعر', 'المشاعر', [
        'ደስታ - سعيد', 'ሐዘን - حزين', 'ቁጣ - غاضب', 'ፍርሃት - خائف', 'መደነቅ - متفاجئ', 'መጠራጠር - قلق', 'መረጋጋት - هادئ', 'መደነቅ - متحمس'
      ]),
      _createArabicLesson('ar_am_beginner_14', 'الأنشطة اليومية', 'تعلم مفردات الروتين اليومي', 'اليومي', [
        'መነሳት - الاستيقاظ', 'መታጠብ - الغسل', 'መብላት - الأكل', 'መስራት - العمل', 'መጫወት - اللعب', 'መተኛት - النوم', 'መማር - التعلم', 'መጠጣት - الشرب'
      ]),
      _createArabicLesson('ar_am_beginner_15', 'أدوات المنزل', 'تعلم مفردات المنزل', 'المنزل', [
        'ጠረጴዛ - طاولة', 'ወንበር - كرسي', 'አልጋ - سرير', 'መብራት - ضوء', 'መስኮት - نافذة', 'በር - باب', 'መታጠቢያ - حمام', 'ማድቤት - مطبخ'
      ]),
      _createArabicLesson('ar_am_beginner_16', 'الأدوات المدرسية', 'تعلم المفردات المدرسية', 'المدرسة', [
        'መጽሐፍ - كتاب', 'እርሳስ - قلم', 'ጠረጴዛ - مكتب', 'መምህር - معلم', 'ተማሪ - طالب', 'ክፍል - فصل', 'መማሪያ - درس', 'ፈተና - امتحان'
      ]),
      _createArabicLesson('ar_am_beginner_17', 'الرياضة', 'تعلم مفردات الرياضة', 'الرياضة', [
        'ኳስ - كرة', 'መሮጥ - الجري', 'መዝለል - القفز', 'መጫወት - اللعب', 'መሸነፍ - الفوز', 'መሸነፍ - الخسارة', 'መለማመድ - التدريب', 'መወዳደር - المنافسة'
      ]),
      _createArabicLesson('ar_am_beginner_18', 'الموسيقى', 'تعلم مفردات الموسيقى', 'الموسيقى', [
        'ሙዚቃ - موسيقى', 'መስማት - الاستماع', 'መዘፈን - الغناء', 'መጫወት - العزف', 'መንቀል - الرقص', 'መሳሪያ - آلة موسيقية', 'ገጽታ - أغنية', 'መስማት - صوت'
      ]),
      _createArabicLesson('ar_am_beginner_19', 'الطبيعة', 'تعلم مفردات الطبيعة', 'الطبيعة', [
        'ፀሐይ - شمس', 'ጨረቃ - قمر', 'ኮከብ - نجم', 'ደመና - سحابة', 'ዝናብ - مطر', 'ንፋስ - رياح', 'ጫካ - غابة', 'ተራራ - جبل'
      ]),
      _createArabicLesson('ar_am_beginner_20', 'الوقت والتواريخ', 'تعلم مفردات الوقت', 'الوقت', [
        'ጊዜ - وقت', 'ሰዓት - ساعة', 'ደቂቃ - دقيقة', 'ዛሬ - اليوم', 'ነገ - غداً', 'ትላንት - أمس', 'ጠዋት - صباح', 'ምሽት - مساء'
      ]),
      // Add more Arabic lessons...
    ];
  }

  /// Generate additional lessons for German
  static List<Lesson> generateAdditionalGermanLessons() {
    return [
      _createGermanLesson('de_beginner_3', 'Familienmitglieder', 'Lernen Sie Familienbegriffe', 'Familie', [
        'አባት - Vater', 'እናት - Mutter', 'ወንድም - Bruder', 'እህት - Schwester', 'ወንድ ልጅ - Sohn', 'ሴት ልጅ - Tochter', 'አያት - Großvater', 'አክስት - Tante'
      ]),
      _createGermanLesson('de_beginner_4', 'Grundfarben', 'Lernen Sie Grundfarben', 'Farben', [
        'ቀይ - Rot', 'ሰማያዊ - Blau', 'አረንጓዴ - Grün', 'ቢጫ - Gelb', 'ጥቁር - Schwarz', 'ነጭ - Weiß', 'ቡናማ - Braun', 'ሮዝ - Rosa'
      ]),
      _createGermanLesson('de_beginner_5', 'Essen und Trinken', 'Wesentliches Nahrungsvokabular', 'Essen', [
        'ውሃ - Wasser', 'ዳቦ - Brot', 'ሩዝ - Reis', 'ስጋ - Fleisch', 'ዓሣ - Fisch', 'ዶሮ - Huhn', 'አትክልት - Gemüse', 'ፍራፍሬ - Obst'
      ]),
      _createGermanLesson('de_beginner_6', 'Körperteile', 'Lernen Sie Körperteile', 'Körper', [
        'እጅ - Hand', 'እግር - Fuß/Bein', 'አይን - Auge', 'አፍ - Mund', 'አዕምሮ - Kopf', 'ልብ - Herz', 'ጆሮ - Ohr', 'አፍንጫ - Nase'
      ]),
      _createGermanLesson('de_beginner_7', 'Tiere', 'Lernen Sie Tiernamen', 'Tiere', [
        'ውሻ - Hund', 'ድር - Katze', 'አህያ - Esel', 'ግምጃ - Pferd', 'ኮረብታ - Kuh', 'አይጥ - Ziege', 'አሳ - Fisch', 'አንበሳ - Löwe'
      ]),
      _createGermanLesson('de_beginner_8', 'Kleidung', 'Lernen Sie Kleidungsvokabular', 'Kleidung', [
        'ሸሚዝ - Hemd', 'ጫማ - Schuh', 'ቦታ - Hut', 'ካባ - Mantel', 'ሱሪ - Hose', 'አልባሳት - Kleidung', 'ጨርቅ - Stoff', 'ልብስ - Kleid'
      ]),
      _createGermanLesson('de_beginner_9', 'Orte', 'Lernen Sie Ortsvokabular', 'Orte', [
        'ቤት - Haus', 'መስጊድ - Moschee', 'ክርስቲያን - Kirche', 'መደብር - Laden', 'መዋኛ - Krankenhaus', 'ትምህርት ቤት - Schule', 'መጽሐፍ ቤት - Bibliothek', 'መናፈሻ - Park'
      ]),
      _createGermanLesson('de_beginner_10', 'Verben', 'Lernen Sie wesentliche Verben', 'Verben', [
        'መሄድ - Gehen', 'መምጣት - Kommen', 'መብላት - Essen', 'መጠጣት - Trinken', 'መተኛት - Schlafen', 'መነሳት - Aufwachen', 'መስራት - Arbeiten', 'መጫወት - Spielen'
      ]),
      _createGermanLesson('de_beginner_11', 'Adjektive', 'Lernen Sie beschreibende Wörter', 'Adjektive', [
        'ትልቅ - Groß', 'ትንሽ - Klein', 'ረዥም - Lang', 'አጫጭር - Kurz', 'ሰፊ - Breit', 'ጠባብ - Schmal', 'ከፍታ - Hoch', 'ዝቅታ - Niedrig'
      ]),
      _createGermanLesson('de_beginner_12', 'Emotionen', 'Lernen Sie Emotionsvokabular', 'Emotionen', [
        'ደስታ - Glücklich', 'ሐዘን - Traurig', 'ቁጣ - Wütend', 'ፍርሃት - Ängstlich', 'መደነቅ - Überrascht', 'መጠራጠር - Besorgt', 'መረጋጋት - Ruhig', 'መደነቅ - Aufgeregt'
      ]),
      _createGermanLesson('de_beginner_13', 'Tägliche Aktivitäten', 'Lernen Sie Routinevokabular', 'Täglich', [
        'መነሳት - Aufwachen', 'መታጠብ - Waschen', 'መብላት - Essen', 'መስራት - Arbeiten', 'መጫወት - Spielen', 'መተኛት - Schlafen', 'መማር - Lernen', 'መጠጣት - Trinken'
      ]),
      _createGermanLesson('de_beginner_14', 'Haushaltsgegenstände', 'Lernen Sie Haushaltsvokabular', 'Haushalt', [
        'ጠረጴዛ - Tisch', 'ወንበር - Stuhl', 'አልጋ - Bett', 'መብራት - Licht', 'መስኮት - Fenster', 'በር - Tür', 'መታጠቢያ - Badezimmer', 'ማድቤት - Küche'
      ]),
      _createGermanLesson('de_beginner_15', 'Schulmaterialien', 'Lernen Sie Schulvokabular', 'Schule', [
        'መጽሐፍ - Buch', 'እርሳስ - Stift', 'ጠረጴዛ - Schreibtisch', 'መምህር - Lehrer', 'ተማሪ - Schüler', 'ክፍል - Klassenzimmer', 'መማሪያ - Lektion', 'ፈተና - Prüfung'
      ]),
      _createGermanLesson('de_beginner_16', 'Sport', 'Lernen Sie Sportvokabular', 'Sport', [
        'ኳስ - Ball', 'መሮጥ - Laufen', 'መዝለል - Springen', 'መጫወት - Spielen', 'መሸነፍ - Gewinnen', 'መሸነፍ - Verlieren', 'መለማመድ - Üben', 'መወዳደር - Wettkämpfen'
      ]),
      _createGermanLesson('de_beginner_17', 'Musik', 'Lernen Sie Musikvokabular', 'Musik', [
        'ሙዚቃ - Musik', 'መስማት - Hören', 'መዘፈን - Singen', 'መጫወት - Spielen', 'መንቀል - Tanzen', 'መሳሪያ - Instrument', 'ገጽታ - Lied', 'መስማት - Klang'
      ]),
      _createGermanLesson('de_beginner_18', 'Natur', 'Lernen Sie Naturvokabular', 'Natur', [
        'ፀሐይ - Sonne', 'ጨረቃ - Mond', 'ኮከብ - Stern', 'ደመና - Wolke', 'ዝናብ - Regen', 'ንፋስ - Wind', 'ጫካ - Wald', 'ተራራ - Berg'
      ]),
      _createGermanLesson('de_beginner_19', 'Zeit und Daten', 'Lernen Sie Zeitvokabular', 'Zeit', [
        'ጊዜ - Zeit', 'ሰዓት - Stunde', 'ደቂቃ - Minute', 'ዛሬ - Heute', 'ነገ - Morgen', 'ትላንት - Gestern', 'ጠዋት - Morgen', 'ምሽት - Abend'
      ]),
      _createGermanLesson('de_beginner_20', 'Wetter', 'Lernen Sie Wettervokabular', 'Wetter', [
        'ፀሐይ ያለች - Sonnig', 'ዝናባማ - Regnerisch', 'ደመናማ - Bewölkt', 'ሙቅ - Heiß', 'ቀዝቃዛ - Kalt', 'ነፋሳማ - Windig', 'ዝናብ - Regen', 'ፀሐይ - Sonne'
      ]),
      // Add more German lessons...
    ];
  }

  /// Helper method to create English lessons
  static Lesson _createEnglishLesson(String id, String title, String description, String category, List<String> vocabulary) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      level: LanguageLevel.beginner,
      languageCode: 'en',
      estimatedMinutes: 8,
      xpReward: 16,
      category: category,
      isUnlocked: false,
      isCompleted: false,
      progress: 0.0,
      vocabulary: vocabulary,
      exercises: [
        Exercise(
          id: '${id}_ex1',
          type: ExerciseType.translate,
          instruction: 'How do you say "${vocabulary.first.split(' - ')[1]}" in Amharic?',
          amharicText: vocabulary.first.split(' - ')[0],
          translation: vocabulary.first.split(' - ')[1],
          options: [
            ExerciseOption(text: vocabulary.first.split(' - ')[0], isCorrect: true),
            ExerciseOption(text: vocabulary.length > 1 ? vocabulary[1].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 2 ? vocabulary[2].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 3 ? vocabulary[3].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
          ],
          correctAnswer: vocabulary.first.split(' - ')[0],
          explanation: '${vocabulary.first.split(' - ')[0]} means "${vocabulary.first.split(' - ')[1]}" in Amharic.',
        ),
      ],
    );
  }

  /// Helper method to create Spanish lessons
  static Lesson _createSpanishLesson(String id, String title, String description, String category, List<String> vocabulary) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      level: LanguageLevel.beginner,
      languageCode: 'es',
      estimatedMinutes: 8,
      xpReward: 16,
      category: category,
      isUnlocked: false,
      isCompleted: false,
      progress: 0.0,
      vocabulary: vocabulary,
      exercises: [
        Exercise(
          id: '${id}_ex1',
          type: ExerciseType.translate,
          instruction: '¿Cómo se dice "${vocabulary.first.split(' - ')[1]}" en amárico?',
          amharicText: vocabulary.first.split(' - ')[0],
          translation: vocabulary.first.split(' - ')[1],
          options: [
            ExerciseOption(text: vocabulary.first.split(' - ')[0], isCorrect: true),
            ExerciseOption(text: vocabulary.length > 1 ? vocabulary[1].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 2 ? vocabulary[2].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 3 ? vocabulary[3].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
          ],
          correctAnswer: vocabulary.first.split(' - ')[0],
          explanation: '${vocabulary.first.split(' - ')[0]} significa "${vocabulary.first.split(' - ')[1]}" en amárico.',
        ),
      ],
    );
  }

  /// Helper method to create French lessons
  static Lesson _createFrenchLesson(String id, String title, String description, String category, List<String> vocabulary) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      level: LanguageLevel.beginner,
      languageCode: 'fr',
      estimatedMinutes: 8,
      xpReward: 16,
      category: category,
      isUnlocked: false,
      isCompleted: false,
      progress: 0.0,
      vocabulary: vocabulary,
      exercises: [
        Exercise(
          id: '${id}_ex1',
          type: ExerciseType.translate,
          instruction: 'Comment dit-on "${vocabulary.first.split(' - ')[1]}" en amharique ?',
          amharicText: vocabulary.first.split(' - ')[0],
          translation: vocabulary.first.split(' - ')[1],
          options: [
            ExerciseOption(text: vocabulary.first.split(' - ')[0], isCorrect: true),
            ExerciseOption(text: vocabulary.length > 1 ? vocabulary[1].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 2 ? vocabulary[2].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 3 ? vocabulary[3].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
          ],
          correctAnswer: vocabulary.first.split(' - ')[0],
          explanation: '${vocabulary.first.split(' - ')[0]} signifie "${vocabulary.first.split(' - ')[1]}" en amharique.',
        ),
      ],
    );
  }

  /// Helper method to create Arabic lessons
  static Lesson _createArabicLesson(String id, String title, String description, String category, List<String> vocabulary) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      level: LanguageLevel.beginner,
      languageCode: 'ar',
      estimatedMinutes: 8,
      xpReward: 16,
      category: category,
      isUnlocked: false,
      isCompleted: false,
      progress: 0.0,
      vocabulary: vocabulary,
      exercises: [
        Exercise(
          id: '${id}_ex1',
          type: ExerciseType.translate,
          instruction: 'ترجم: ${vocabulary.first.split(' - ')[1]}',
          amharicText: vocabulary.first.split(' - ')[0],
          translation: vocabulary.first.split(' - ')[1],
          options: [
            ExerciseOption(text: vocabulary.first.split(' - ')[0], isCorrect: true),
            ExerciseOption(text: vocabulary.length > 1 ? vocabulary[1].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 2 ? vocabulary[2].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 3 ? vocabulary[3].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
          ],
          correctAnswer: vocabulary.first.split(' - ')[0],
          explanation: '${vocabulary.first.split(' - ')[0]} تعني "${vocabulary.first.split(' - ')[1]}" بالأمهرية.',
        ),
      ],
    );
  }

  /// Generate additional lessons for Chinese
  static List<Lesson> generateAdditionalChineseLessons() {
    return [
      _createChineseLesson('zh_beginner_5', '颜色', '学习基本颜色的阿姆哈拉语', '颜色', [
        'ቀይ - 红色', 'ሰማያዊ - 蓝色', 'አረንጓዴ - 绿色', 'ቢጫ - 黄色', 'ጥቁር - 黑色', 'ነጭ - 白色', 'ቡናማ - 棕色', 'ሮዝ - 粉色'
      ]),
      _createChineseLesson('zh_beginner_6', '食物和饮料', '学习基本食物和饮料词汇', '食物', [
        'ውሃ - 水', 'ዳቦ - 面包', 'ሩዝ - 米饭', 'ስጋ - 肉', 'ዓሣ - 鱼', 'ዶሮ - 鸡肉', 'አትክልት - 蔬菜', 'ፍራፍሬ - 水果'
      ]),
      _createChineseLesson('zh_beginner_7', '身体部位', '学习身体部位的阿姆哈拉语', '身体', [
        'እጅ - 手', 'እግር - 脚/腿', 'አይን - 眼睛', 'አፍ - 嘴', 'አዕምሮ - 头', 'ልብ - 心脏', 'ጆሮ - 耳朵', 'አፍንጫ - 鼻子'
      ]),
      _createChineseLesson('zh_beginner_8', '动物', '学习动物名称', '动物', [
        'ውሻ - 狗', 'ድር - 猫', 'አህያ - 驴', 'ግምጃ - 马', 'ኮረብታ - 牛', 'አይጥ - 山羊', 'አሳ - 鱼', 'አንበሳ - 狮子'
      ]),
      // Continue with more Chinese lessons to reach 50...
    ];
  }

  /// Generate additional lessons for Japanese
  static List<Lesson> generateAdditionalJapaneseLessons() {
    return [
      _createJapaneseLesson('ja_beginner_5', '色', '基本的な色のアムハラ語を学ぼう', '色', [
        'ቀይ - 赤', 'ሰማያዊ - 青', 'አረንጓዴ - 緑', 'ቢጫ - 黄色', 'ጥቁር - 黒', 'ነጭ - 白', 'ቡናማ - 茶色', 'ሮዝ - ピンク'
      ]),
      _createJapaneseLesson('ja_beginner_6', '食べ物と飲み物', '基本的な食べ物と飲み物の語彙を学ぼう', '食べ物', [
        'ውሃ - 水', 'ዳቦ - パン', 'ሩዝ - 米', 'ስጋ - 肉', 'ዓሣ - 魚', 'ዶሮ - 鶏肉', 'አትክልት - 野菜', 'ፍራፍሬ - 果物'
      ]),
      _createJapaneseLesson('ja_beginner_7', '体の部位', '体の部位のアムハラ語を学ぼう', '体', [
        'እጅ - 手', 'እግር - 足/脚', 'አይን - 目', 'አፍ - 口', 'አዕምሮ - 頭', 'ልብ - 心臓', 'ጆሮ - 耳', 'አፍንጫ - 鼻'
      ]),
      _createJapaneseLesson('ja_beginner_8', '動物', '動物の名前を学ぼう', '動物', [
        'ውሻ - 犬', 'ድር - 猫', 'አህያ - ロバ', 'ግምጃ - 馬', 'ኮረብታ - 牛', 'አይጥ - ヤギ', 'አሳ - 魚', 'አንበሳ - ライオン'
      ]),
      // Continue with more Japanese lessons to reach 50...
    ];
  }

  /// Generate additional lessons for Portuguese
  static List<Lesson> generateAdditionalPortugueseLessons() {
    return [
      _createPortugueseLesson('pt_beginner_2', 'Cores básicas', 'Aprenda cores básicas em amárico', 'Cores', [
        'ቀይ - Vermelho', 'ሰማያዊ - Azul', 'አረንጓዴ - Verde', 'ቢጫ - Amarelo', 'ጥቁር - Preto', 'ነጭ - Branco', 'ቡናማ - Marrom', 'ሮዝ - Rosa'
      ]),
      _createPortugueseLesson('pt_beginner_3', 'Comida e bebidas', 'Vocabulário essencial de comida e bebidas', 'Comida', [
        'ውሃ - Água', 'ዳቦ - Pão', 'ሩዝ - Arroz', 'ስጋ - Carne', 'ዓሣ - Peixe', 'ዶሮ - Frango', 'አትክልት - Vegetais', 'ፍራፍሬ - Fruta'
      ]),
      _createPortugueseLesson('pt_beginner_4', 'Partes do corpo', 'Aprenda partes do corpo em amárico', 'Corpo', [
        'እጅ - Mão', 'እግር - Pé/Perna', 'አይን - Olho', 'አፍ - Boca', 'አዕምሮ - Cabeça', 'ልብ - Coração', 'ጆሮ - Orelha', 'አፍንጫ - Nariz'
      ]),
      _createPortugueseLesson('pt_beginner_5', 'Animais', 'Aprenda nomes de animais', 'Animais', [
        'ውሻ - Cão', 'ድር - Gato', 'አህያ - Burro', 'ግምጃ - Cavalo', 'ኮረብታ - Vaca', 'አይጥ - Cabra', 'አሳ - Peixe', 'አንበሳ - Leão'
      ]),
      // Continue with more Portuguese lessons to reach 50...
    ];
  }

  /// Generate additional lessons for Italian
  static List<Lesson> generateAdditionalItalianLessons() {
    return [
      // Note: Italian already has 50+ lessons, but adding a few more for completeness
      _createItalianLesson('it_beginner_51', 'Trasporti', 'Impara il vocabolario dei trasporti', 'Trasporti', [
        'መኪና - Auto', 'አውሮፕላን - Aereo', 'ባቡር - Treno', 'አውቶቡስ - Autobus', 'ሳይክል - Bicicletta', 'ግልቦት - Nave', 'ትራም - Tram', 'ታክሲ - Taxi'
      ]),
      // Additional Italian lessons as needed...
    ];
  }

  /// Generate additional lessons for Russian
  static List<Lesson> generateAdditionalRussianLessons() {
    return [
      _createRussianLesson('ru_beginner_2', 'Основные цвета', 'Изучите основные цвета на амхарском', 'Цвета', [
        'ቀይ - Красный', 'ሰማያዊ - Синий', 'አረንጓዴ - Зеленый', 'ቢጫ - Желтый', 'ጥቁር - Черный', 'ነጭ - Белый', 'ቡናማ - Коричневый', 'ሮዝ - Розовый'
      ]),
      _createRussianLesson('ru_beginner_3', 'Еда и напитки', 'Основная лексика еды и напитков', 'Еда', [
        'ውሃ - Вода', 'ዳቦ - Хлеб', 'ሩዝ - Рис', 'ስጋ - Мясо', 'ዓሣ - Рыба', 'ዶሮ - Курица', 'አትክልት - Овощи', 'ፍራፍሬ - Фрукты'
      ]),
      _createRussianLesson('ru_beginner_4', 'Части тела', 'Изучите части тела на амхарском', 'Тело', [
        'እጅ - Рука', 'እግር - Нога', 'አይን - Глаз', 'አፍ - Рот', 'አዕምሮ - Голова', 'ልብ - Сердце', 'ጆሮ - Ухо', 'አፍንጫ - Нос'
      ]),
      _createRussianLesson('ru_beginner_5', 'Животные', 'Изучите названия животных', 'Животные', [
        'ውሻ - Собака', 'ድር - Кошка', 'አህያ - Осел', 'ግምጃ - Лошадь', 'ኮረብታ - Корова', 'አይጥ - Коза', 'አሳ - Рыба', 'አንበሳ - Лев'
      ]),
      // Continue with more Russian lessons to reach 50...
    ];
  }

  /// Generate additional lessons for Hindi
  static List<Lesson> generateAdditionalHindiLessons() {
    return [
      // Note: Hindi already has 50+ lessons, but adding a few more for completeness
      _createHindiLesson('hi_beginner_51', 'परिवहन', 'परिवहन शब्दावली सीखें', 'परिवहन', [
        'መኪና - कार', 'አውሮፕላን - हवाई जहाज', 'ባቡር - ट्रेन', 'አውቶቡስ - बस', 'ሳይክል - साइकिल', 'ግልቦት - नाव', 'ሞተር - मोटर', 'ታክሲ - टैक्सी'
      ]),
      // Additional Hindi lessons as needed...
    ];
  }

  /// Helper method to create Chinese lessons
  static Lesson _createChineseLesson(String id, String title, String description, String category, List<String> vocabulary) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      level: LanguageLevel.beginner,
      languageCode: 'zh',
      estimatedMinutes: 8,
      xpReward: 16,
      category: category,
      isUnlocked: false,
      isCompleted: false,
      progress: 0.0,
      vocabulary: vocabulary,
      exercises: [
        Exercise(
          id: '${id}_ex1',
          type: ExerciseType.translate,
          instruction: '如何用阿姆哈拉语说"${vocabulary.first.split(' - ')[1]}"？',
          amharicText: vocabulary.first.split(' - ')[0],
          translation: vocabulary.first.split(' - ')[1],
          options: [
            ExerciseOption(text: vocabulary.first.split(' - ')[0], isCorrect: true),
            ExerciseOption(text: vocabulary.length > 1 ? vocabulary[1].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 2 ? vocabulary[2].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 3 ? vocabulary[3].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
          ],
          correctAnswer: vocabulary.first.split(' - ')[0],
          explanation: '${vocabulary.first.split(' - ')[0]} 在阿姆哈拉语中意思是"${vocabulary.first.split(' - ')[1]}"。',
        ),
      ],
    );
  }

  /// Helper method to create Japanese lessons
  static Lesson _createJapaneseLesson(String id, String title, String description, String category, List<String> vocabulary) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      level: LanguageLevel.beginner,
      languageCode: 'ja',
      estimatedMinutes: 8,
      xpReward: 16,
      category: category,
      isUnlocked: false,
      isCompleted: false,
      progress: 0.0,
      vocabulary: vocabulary,
      exercises: [
        Exercise(
          id: '${id}_ex1',
          type: ExerciseType.translate,
          instruction: '「${vocabulary.first.split(' - ')[1]}」をアムハラ語で何と言いますか？',
          amharicText: vocabulary.first.split(' - ')[0],
          translation: vocabulary.first.split(' - ')[1],
          options: [
            ExerciseOption(text: vocabulary.first.split(' - ')[0], isCorrect: true),
            ExerciseOption(text: vocabulary.length > 1 ? vocabulary[1].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 2 ? vocabulary[2].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 3 ? vocabulary[3].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
          ],
          correctAnswer: vocabulary.first.split(' - ')[0],
          explanation: '${vocabulary.first.split(' - ')[0]} はアムハラ語で「${vocabulary.first.split(' - ')[1]}」という意味です。',
        ),
      ],
    );
  }

  /// Helper method to create Portuguese lessons
  static Lesson _createPortugueseLesson(String id, String title, String description, String category, List<String> vocabulary) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      level: LanguageLevel.beginner,
      languageCode: 'pt',
      estimatedMinutes: 8,
      xpReward: 16,
      category: category,
      isUnlocked: false,
      isCompleted: false,
      progress: 0.0,
      vocabulary: vocabulary,
      exercises: [
        Exercise(
          id: '${id}_ex1',
          type: ExerciseType.translate,
          instruction: 'Como se diz "${vocabulary.first.split(' - ')[1]}" em amárico?',
          amharicText: vocabulary.first.split(' - ')[0],
          translation: vocabulary.first.split(' - ')[1],
          options: [
            ExerciseOption(text: vocabulary.first.split(' - ')[0], isCorrect: true),
            ExerciseOption(text: vocabulary.length > 1 ? vocabulary[1].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 2 ? vocabulary[2].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 3 ? vocabulary[3].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
          ],
          correctAnswer: vocabulary.first.split(' - ')[0],
          explanation: '${vocabulary.first.split(' - ')[0]} significa "${vocabulary.first.split(' - ')[1]}" em amárico.',
        ),
      ],
    );
  }

  /// Helper method to create Italian lessons
  static Lesson _createItalianLesson(String id, String title, String description, String category, List<String> vocabulary) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      level: LanguageLevel.beginner,
      languageCode: 'it',
      estimatedMinutes: 8,
      xpReward: 16,
      category: category,
      isUnlocked: false,
      isCompleted: false,
      progress: 0.0,
      vocabulary: vocabulary,
      exercises: [
        Exercise(
          id: '${id}_ex1',
          type: ExerciseType.translate,
          instruction: 'Come si dice "${vocabulary.first.split(' - ')[1]}" in amarico?',
          amharicText: vocabulary.first.split(' - ')[0],
          translation: vocabulary.first.split(' - ')[1],
          options: [
            ExerciseOption(text: vocabulary.first.split(' - ')[0], isCorrect: true),
            ExerciseOption(text: vocabulary.length > 1 ? vocabulary[1].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 2 ? vocabulary[2].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 3 ? vocabulary[3].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
          ],
          correctAnswer: vocabulary.first.split(' - ')[0],
          explanation: '${vocabulary.first.split(' - ')[0]} significa "${vocabulary.first.split(' - ')[1]}" in amarico.',
        ),
      ],
    );
  }

  /// Helper method to create Russian lessons
  static Lesson _createRussianLesson(String id, String title, String description, String category, List<String> vocabulary) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      level: LanguageLevel.beginner,
      languageCode: 'ru',
      estimatedMinutes: 8,
      xpReward: 16,
      category: category,
      isUnlocked: false,
      isCompleted: false,
      progress: 0.0,
      vocabulary: vocabulary,
      exercises: [
        Exercise(
          id: '${id}_ex1',
          type: ExerciseType.translate,
          instruction: 'Как сказать "${vocabulary.first.split(' - ')[1]}" на амхарском?',
          amharicText: vocabulary.first.split(' - ')[0],
          translation: vocabulary.first.split(' - ')[1],
          options: [
            ExerciseOption(text: vocabulary.first.split(' - ')[0], isCorrect: true),
            ExerciseOption(text: vocabulary.length > 1 ? vocabulary[1].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 2 ? vocabulary[2].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 3 ? vocabulary[3].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
          ],
          correctAnswer: vocabulary.first.split(' - ')[0],
          explanation: '${vocabulary.first.split(' - ')[0]} означает "${vocabulary.first.split(' - ')[1]}" на амхарском.',
        ),
      ],
    );
  }

  /// Helper method to create Hindi lessons
  static Lesson _createHindiLesson(String id, String title, String description, String category, List<String> vocabulary) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      level: LanguageLevel.beginner,
      languageCode: 'hi',
      estimatedMinutes: 8,
      xpReward: 16,
      category: category,
      isUnlocked: false,
      isCompleted: false,
      progress: 0.0,
      vocabulary: vocabulary,
      exercises: [
        Exercise(
          id: '${id}_ex1',
          type: ExerciseType.translate,
          instruction: 'अम्हारिक में "${vocabulary.first.split(' - ')[1]}" कैसे कहते हैं?',
          amharicText: vocabulary.first.split(' - ')[0],
          translation: vocabulary.first.split(' - ')[1],
          options: [
            ExerciseOption(text: vocabulary.first.split(' - ')[0], isCorrect: true),
            ExerciseOption(text: vocabulary.length > 1 ? vocabulary[1].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 2 ? vocabulary[2].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 3 ? vocabulary[3].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
          ],
          correctAnswer: vocabulary.first.split(' - ')[0],
          explanation: '${vocabulary.first.split(' - ')[0]} का अम्हारिक में मतलब "${vocabulary.first.split(' - ')[1]}" है।',
        ),
      ],
    );
  }

  /// Helper method to create German lessons
  static Lesson _createGermanLesson(String id, String title, String description, String category, List<String> vocabulary) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      level: LanguageLevel.beginner,
      languageCode: 'de',
      estimatedMinutes: 8,
      xpReward: 16,
      category: category,
      isUnlocked: false,
      isCompleted: false,
      progress: 0.0,
      vocabulary: vocabulary,
      exercises: [
        Exercise(
          id: '${id}_ex1',
          type: ExerciseType.translate,
          instruction: 'Wie sagt man "${vocabulary.first.split(' - ')[1]}" auf Amharisch?',
          amharicText: vocabulary.first.split(' - ')[0],
          translation: vocabulary.first.split(' - ')[1],
          options: [
            ExerciseOption(text: vocabulary.first.split(' - ')[0], isCorrect: true),
            ExerciseOption(text: vocabulary.length > 1 ? vocabulary[1].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 2 ? vocabulary[2].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
            ExerciseOption(text: vocabulary.length > 3 ? vocabulary[3].split(' - ')[0] : 'አልተገኘም', isCorrect: false),
          ],
          correctAnswer: vocabulary.first.split(' - ')[0],
          explanation: '${vocabulary.first.split(' - ')[0]} bedeutet "${vocabulary.first.split(' - ')[1]}" auf Amharisch.',
        ),
      ],
    );
  }
}
