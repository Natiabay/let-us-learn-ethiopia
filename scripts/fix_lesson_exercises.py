#!/usr/bin/env python3
"""
Fix missing 'options' parameter in lesson exercises
"""

import re

def fix_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Pattern to match LessonExercise without options parameter
    # Find exercises that have wordBank but no options
    pattern = r'(LessonExercise\(\s+id: \'[^\']+\',\s+type: LessonType\.\w+,\s+question: \'[^\']+\',\s+(?:audioUrl: \'[^\']+\',\s+)?(?:amharicScript: \'[^\']+\',\s+)?(?:pronunciation: \'[^\']+\',\s+)?)(correctAnswer:)'
    
    # Replace with options: [] before correctAnswer
    def replacer(match):
        return match.group(1) + 'options: [],\n          ' + match.group(2)
    
    content = re.sub(pattern, replacer, content)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"Fixed: {filepath}")

# Fix both files
fix_file('../lib/features/language/data/amharic_lessons_part1_greetings_expanded.dart')
fix_file('../lib/features/language/data/amharic_lessons_part2_numbers_expanded.dart')

print("\nAll files fixed!")
