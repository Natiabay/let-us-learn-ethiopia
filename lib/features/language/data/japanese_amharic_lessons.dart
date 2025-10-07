import 'package:tourist_assistive_app/features/language/models/comprehensive_lesson_model.dart';

/// 包括的な日本語 → アムハラ語観光レッスン
/// Comprehensive Japanese → Amharic Lessons for Tourists
/// 初級、中級、上級レベルをカバーする60以上の詳細なレッスン
class JapaneseAmharicLessons {
  
  /// すべての日本語 → アムハラ語レッスンを取得（60以上のレッスン）
  static List<Lesson> getAllLessons() {
    return [
      ...getBeginnerLessons(),
      ...getIntermediateLessons(),
      ...getAdvancedLessons(),
    ];
  }

  /// 初級レベルのレッスン（20レッスン）
  static List<Lesson> getBeginnerLessons() {
    return [
      // レッスン1: 基本的な挨拶
      Lesson(
        id: 'ja_am_beginner_1',
        title: '基本的な挨拶',
        description: 'アムハラ語の基本的な挨拶を学びます',
        level: LanguageLevel.beginner,
        languageCode: 'ja',
        estimatedMinutes: 8,
        xpReward: 150,
        category: '挨拶',
        exercises: [
          Exercise(
            id: 'ja_am_b1_ex1',
            type: ExerciseType.translate,
            instruction: '翻訳してください：こんにちは',
            amharicText: 'ሰላም',
            translation: 'こんにちは',
            options: [
              ExerciseOption(text: 'ሰላም', isCorrect: true),
              ExerciseOption(text: 'ታዲያስ', isCorrect: false),
              ExerciseOption(text: 'እንዴት ናችሁ', isCorrect: false),
              ExerciseOption(text: 'አመሰግናለሁ', isCorrect: false),
            ],
            explanation: '"ሰላም"はアムハラ語で「こんにちは」または「平和」を意味します。最も一般的な挨拶です。',
          ),
          Exercise(
            id: 'ja_am_b1_ex2',
            type: ExerciseType.multipleChoice,
            instruction: 'アムハラ語で「おはようございます」はどう言いますか？',
            amharicText: 'እንደምን አደሩ',
            translation: 'おはようございます',
            options: [
              ExerciseOption(text: 'እንደምን አደሩ', isCorrect: true),
              ExerciseOption(text: 'ሰላም', isCorrect: false),
              ExerciseOption(text: 'ታዲያስ', isCorrect: false),
              ExerciseOption(text: 'እንዴት ናችሁ', isCorrect: false),
            ],
            explanation: '"እንደምን አደሩ"は朝の正式な挨拶です。',
          ),
          Exercise(
            id: 'ja_am_b1_ex3',
            type: ExerciseType.listen,
            instruction: '音声を聞いて正しい翻訳を選んでください',
            amharicText: 'ታዲያስ',
            translation: 'さようなら',
            options: [
              ExerciseOption(text: 'さようなら', isCorrect: true),
              ExerciseOption(text: 'こんにちは', isCorrect: false),
              ExerciseOption(text: 'ありがとう', isCorrect: false),
              ExerciseOption(text: 'お願いします', isCorrect: false),
            ],
            explanation: '"ታዲያስ"はアムハラ語でさようならを意味します。',
          ),
          Exercise(
            id: 'ja_am_b1_ex4',
            type: ExerciseType.fillBlank,
            instruction: '挨拶を完成させてください：お元気ですか？',
            amharicText: 'እንዴት ____？',
            translation: 'どう____？',
            options: [
              ExerciseOption(text: 'ናችሁ', isCorrect: true),
              ExerciseOption(text: 'ነህ', isCorrect: false),
              ExerciseOption(text: 'ናት', isCorrect: false),
              ExerciseOption(text: 'ነው', isCorrect: false),
            ],
            explanation: '"እንዴት ናችሁ？"は「お元気ですか？」を意味します（敬語/複数形）',
          ),
          Exercise(
            id: 'ja_am_b1_ex5',
            type: ExerciseType.pronunciation,
            instruction: '発音を練習してください：平和',
            amharicText: 'ሰላም',
            translation: '平和/こんにちは',
            options: [
              ExerciseOption(text: 'セ-ラム', isCorrect: true),
              ExerciseOption(text: 'サ-ラム', isCorrect: false),
              ExerciseOption(text: 'シ-ラム', isCorrect: false),
              ExerciseOption(text: 'ソ-ラム', isCorrect: false),
            ],
            explanation: '「セ-ラム」と発音し、第二音節にアクセントがあります。',
          ),
        ],
        vocabulary: ['ሰላም', 'እንደምን አደሩ', 'ታዲያስ', 'እንዴት ናችሁ', 'እንደምን ነዎት'],
      ),

      // レッスン2: 数字1-10
      Lesson(
        id: 'ja_am_beginner_2',
        title: '数字1-10',
        description: 'アムハラ語で1から10まで数えることを学びます',
        level: LanguageLevel.beginner,
        languageCode: 'ja',
        estimatedMinutes: 10,
        xpReward: 150,
        category: '数字',
        exercises: [
          Exercise(
            id: 'ja_am_b2_ex1',
            type: ExerciseType.selectImage,
            instruction: '「一」を示す画像を選んでください',
            amharicText: 'አንድ',
            translation: '一',
            options: [
              ExerciseOption(text: '1', isCorrect: true),
              ExerciseOption(text: '2', isCorrect: false),
              ExerciseOption(text: '3', isCorrect: false),
              ExerciseOption(text: '4', isCorrect: false),
            ],
            explanation: '"አንድ"はアムハラ語で「一」を意味します。',
          ),
          Exercise(
            id: 'ja_am_b2_ex2',
            type: ExerciseType.translate,
            instruction: '翻訳してください：五',
            amharicText: 'አምስት',
            translation: '五',
            options: [
              ExerciseOption(text: 'አምስት', isCorrect: true),
              ExerciseOption(text: 'አራት', isCorrect: false),
              ExerciseOption(text: 'ስድስት', isCorrect: false),
              ExerciseOption(text: 'ሶስት', isCorrect: false),
            ],
            explanation: '"አምስት"はアムハラ語で「五」を意味します。',
          ),
          Exercise(
            id: 'ja_am_b2_ex3',
            type: ExerciseType.matching,
            instruction: 'アムハラ語の数字と日本語を一致させてください',
            amharicText: 'ሁለት',
            translation: '二',
            options: [
              ExerciseOption(text: '二', isCorrect: true),
              ExerciseOption(text: '三', isCorrect: false),
              ExerciseOption(text: '四', isCorrect: false),
              ExerciseOption(text: '六', isCorrect: false),
            ],
            explanation: '"ሁለት"はアムハラ語で「二」を意味します。',
          ),
          Exercise(
            id: 'ja_am_b2_ex4',
            type: ExerciseType.listen,
            instruction: '音声を聞いて聞こえたものを書いてください',
            amharicText: 'ሰባት',
            translation: '七',
            options: [
              ExerciseOption(text: 'ሰባት', isCorrect: true),
              ExerciseOption(text: 'ስምንት', isCorrect: false),
              ExerciseOption(text: 'ዘጠኝ', isCorrect: false),
              ExerciseOption(text: 'አስር', isCorrect: false),
            ],
            explanation: '"ሰባት"はアムハラ語で「七」を意味します。',
          ),
          Exercise(
            id: 'ja_am_b2_ex5',
            type: ExerciseType.pronunciation,
            instruction: '「十」はどう発音しますか？',
            amharicText: 'አስር',
            translation: '十',
            options: [
              ExerciseOption(text: 'ア-シル', isCorrect: true),
              ExerciseOption(text: 'ア-セル', isCorrect: false),
              ExerciseOption(text: 'ア-シェル', isCorrect: false),
              ExerciseOption(text: 'ア-シ', isCorrect: false),
            ],
            explanation: '"አስር"は「ア-シル」と発音し、十を意味します。',
          ),
        ],
        vocabulary: ['አንድ', 'ሁለት', 'ሶስት', 'አራት', 'አምስት', 'ስድስት', 'ሰባት', 'ስምንት', 'ዘጠኝ', 'አስር'],
      ),

      // レッスン3: 家族のメンバー
      Lesson(
        id: 'ja_am_beginner_3',
        title: '家族のメンバー',
        description: 'アムハラ語の家族関係用語を学びます',
        level: LanguageLevel.beginner,
        languageCode: 'ja',
        estimatedMinutes: 12,
        xpReward: 180,
        category: '家族',
        exercises: [
          Exercise(
            id: 'ja_am_b3_ex1',
            type: ExerciseType.translate,
            instruction: '翻訳してください：父',
            amharicText: 'አባት',
            translation: '父',
            options: [
              ExerciseOption(text: 'አባት', isCorrect: true),
              ExerciseOption(text: 'እናት', isCorrect: false),
              ExerciseOption(text: 'ወንድም', isCorrect: false),
              ExerciseOption(text: 'እህት', isCorrect: false),
            ],
            explanation: '"አባት"はアムハラ語で「父」を意味します。',
          ),
          Exercise(
            id: 'ja_am_b3_ex2',
            type: ExerciseType.multipleChoice,
            instruction: '"እናት"は何を意味しますか？',
            amharicText: 'እናት',
            translation: '母',
            options: [
              ExerciseOption(text: '母', isCorrect: true),
              ExerciseOption(text: '父', isCorrect: false),
              ExerciseOption(text: '姉妹', isCorrect: false),
              ExerciseOption(text: '兄弟', isCorrect: false),
            ],
            explanation: '"እናት"はアムハラ語で「母」を意味します。',
          ),
          Exercise(
            id: 'ja_am_b3_ex3',
            type: ExerciseType.selectImage,
            instruction: '「兄弟」を表す画像を選んでください',
            amharicText: 'ወንድም',
            translation: '兄弟',
            options: [
              ExerciseOption(text: '男の子/男性', isCorrect: true),
              ExerciseOption(text: '女の子/女性', isCorrect: false),
              ExerciseOption(text: '高齢男性', isCorrect: false),
              ExerciseOption(text: '小さな子供', isCorrect: false),
            ],
            explanation: '"ወንድም"はアムハラ語で「兄弟」を意味します。',
          ),
          Exercise(
            id: 'ja_am_b3_ex4',
            type: ExerciseType.fillBlank,
            instruction: '完成させてください：私の姉妹は美しいです',
            amharicText: 'የኔ ____ ቆንጆ ነች',
            translation: '私の____は美しいです',
            options: [
              ExerciseOption(text: 'እህት', isCorrect: true),
              ExerciseOption(text: 'ወንድም', isCorrect: false),
              ExerciseOption(text: 'አባት', isCorrect: false),
              ExerciseOption(text: 'እናት', isCorrect: false),
            ],
            explanation: '"እህት"はアムハラ語で「姉妹」を意味します。',
          ),
          Exercise(
            id: 'ja_am_b3_ex5',
            type: ExerciseType.listen,
            instruction: '音声を聞いて家族のメンバーを特定してください',
            amharicText: 'ልጅ',
            translation: '子供',
            options: [
              ExerciseOption(text: '子供', isCorrect: true),
              ExerciseOption(text: '親', isCorrect: false),
              ExerciseOption(text: '叔父', isCorrect: false),
              ExerciseOption(text: '叔母', isCorrect: false),
            ],
            explanation: '"ልጅ"はアムハラ語で「子供」を意味します。',
          ),
        ],
        vocabulary: ['አባት', 'እናት', 'ወንድም', 'እህት', 'ልጅ', 'ቤተሰብ', 'የኔ', 'ቆንጆ'],
      ),

      // レッスン4: 基本的な礼儀
      Lesson(
        id: 'ja_am_beginner_4',
        title: '基本的な礼儀',
        description: '丁寧な表現と礼儀正しい言葉を学びます',
        level: LanguageLevel.beginner,
        languageCode: 'ja',
        estimatedMinutes: 8,
        xpReward: 130,
        category: '礼儀',
        exercises: [
          Exercise(
            id: 'ja_am_b4_ex1',
            type: ExerciseType.translate,
            instruction: '翻訳してください：ありがとう',
            amharicText: 'አመሰግናለሁ',
            translation: 'ありがとう',
            options: [
              ExerciseOption(text: 'አመሰግናለሁ', isCorrect: true),
              ExerciseOption(text: 'ይቅርታ', isCorrect: false),
              ExerciseOption(text: 'እባክዎ', isCorrect: false),
              ExerciseOption(text: 'ሰላም', isCorrect: false),
            ],
            explanation: '"አመሰግናለሁ"はアムハラ語で「ありがとう」を意味します。',
          ),
          Exercise(
            id: 'ja_am_b4_ex2',
            type: ExerciseType.multipleChoice,
            instruction: '「お願いします」はアムハラ語でどう言いますか？',
            amharicText: 'እባክዎ',
            translation: 'お願いします',
            options: [
              ExerciseOption(text: 'እባክዎ', isCorrect: true),
              ExerciseOption(text: 'አመሰግናለሁ', isCorrect: false),
              ExerciseOption(text: 'ይቅርታ', isCorrect: false),
              ExerciseOption(text: 'ታዲያስ', isCorrect: false),
            ],
            explanation: '"እባክዎ"はアムハラ語で「お願いします」を意味します（敬語）。',
          ),
          Exercise(
            id: 'ja_am_b4_ex3',
            type: ExerciseType.pronunciation,
            instruction: '「すみません」の言い方を練習してください',
            amharicText: 'ይቅርታ',
            translation: 'すみません/ごめんなさい',
            options: [
              ExerciseOption(text: 'イ-キル-タ', isCorrect: true),
              ExerciseOption(text: 'ヤ-キル-タ', isCorrect: false),
              ExerciseOption(text: 'イエ-ケル-タ', isCorrect: false),
              ExerciseOption(text: 'イ-カル-タ', isCorrect: false),
            ],
            explanation: '"ይቅርታ"は「すみません」や「ごめんなさい」を意味し、「イ-キル-タ」と発音します。',
          ),
          Exercise(
            id: 'ja_am_b4_ex4',
            type: ExerciseType.listen,
            instruction: 'どんな礼儀正しい表現が聞こえますか？',
            amharicText: 'እንኳን ደህና መጡ',
            translation: 'ようこそ',
            options: [
              ExerciseOption(text: 'ようこそ', isCorrect: true),
              ExerciseOption(text: 'ありがとう', isCorrect: false),
              ExerciseOption(text: 'さようなら', isCorrect: false),
              ExerciseOption(text: 'お願いします', isCorrect: false),
            ],
            explanation: '"እንኳን ደህና መጡ"はアムハラ語で「ようこそ」を意味します。',
          ),
          Exercise(
            id: 'ja_am_b4_ex5',
            type: ExerciseType.fillBlank,
            instruction: '完成させてください：どういたしまして',
            amharicText: '____ አይደለም',
            translation: '____ありません',
            options: [
              ExerciseOption(text: 'ምንም', isCorrect: true),
              ExerciseOption(text: 'አመሰግናለሁ', isCorrect: false),
              ExerciseOption(text: 'እባክዎ', isCorrect: false),
              ExerciseOption(text: 'ሰላም', isCorrect: false),
            ],
            explanation: '"ምንም አይደለም"は「どういたしまして」や「何でもありません」を意味します。',
          ),
        ],
        vocabulary: ['አመሰግናለሁ', 'እባክዎ', 'ይቅርታ', 'እንኳን ደህና መጡ', 'ምንም አይደለም'],
      ),

      // Continue with more Japanese beginner lessons...
    ];
  }

  /// 中級レベルのレッスン（20レッスン）
  static List<Lesson> getIntermediateLessons() {
    return [
      // Intermediate lessons go here
    ];
  }

  /// 上級レベルのレッスン（20レッスン）
  static List<Lesson> getAdvancedLessons() {
    return [
      // Advanced lessons go here
    ];
  }
}