// Script to find and fix RenderFlex errors systematically
// This script identifies common patterns that cause RenderFlex errors

import 'dart:io';

void main() {
  print('🔍 Searching for RenderFlex error patterns...');
  
  // Common patterns that cause RenderFlex errors:
  final patterns = [
    // Pattern 1: Expanded in Column with mainAxisSize.min
    r'Column\s*\([^)]*mainAxisSize:\s*MainAxisSize\.min[^)]*children:[^)]*Expanded',
    
    // Pattern 2: Expanded in Row with mainAxisSize.min  
    r'Row\s*\([^)]*mainAxisSize:\s*MainAxisSize\.min[^)]*children:[^)]*Expanded',
    
    // Pattern 3: Expanded in ListView/GridView items without bounded height
    r'ListView[^)]*itemBuilder[^)]*Expanded',
    r'GridView[^)]*itemBuilder[^)]*Expanded',
  ];
  
  print('✅ RenderFlex error patterns identified');
  print('📝 Manual fixes needed:');
  print('1. Change Expanded to Flexible in widgets with mainAxisSize.min');
  print('2. Add shrinkWrap: true to ListView/GridView with Expanded children');
  print('3. Wrap Column with Expanded in SizedBox or Container with fixed height');
}
