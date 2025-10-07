/// Lesson Builder - Create Duolingo-style lessons
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LessonBuilderScreen extends ConsumerStatefulWidget {
  const LessonBuilderScreen({super.key});

  @override
  ConsumerState<LessonBuilderScreen> createState() => _LessonBuilderScreenState();
}

class _LessonBuilderScreenState extends ConsumerState<LessonBuilderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedLanguagePair = 'en_am';
  String _selectedLevel = 'beginner';
  int _xpReward = 10;
  int _estimatedMinutes = 5;
  List<Map<String, dynamic>> _exercises = [];
  bool _isLoading = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        elevation: 0,
        title: const Text(
          'Lesson Builder',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: _isLoading ? null : _previewLesson,
            icon: const Icon(Icons.visibility, color: Color(0xFF1CB0F6)),
            label: const Text(
              'Preview',
              style: TextStyle(color: Color(0xFF1CB0F6)),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _saveLesson,
            icon: const Icon(Icons.save),
            label: const Text('Save Draft'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF58CC02),
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF58CC02)))
          : Row(
              children: [
                // Left panel - Lesson metadata
                Expanded(
                  flex: 1,
                  child: _buildMetadataPanel(),
                ),
                Container(width: 1, color: const Color(0xFF3A3A3A)),
                // Right panel - Exercise builder
                Expanded(
                  flex: 2,
                  child: _buildExercisePanel(),
                ),
              ],
            ),
    );
  }
  
  Widget _buildMetadataPanel() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lesson Information',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            // Title
            TextFormField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Lesson Title',
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3A3A3A)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF58CC02), width: 2),
                ),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            
            // Description
            TextFormField(
              controller: _descriptionController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3A3A3A)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF58CC02), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Language Pair
            DropdownButtonFormField<String>(
              value: _selectedLanguagePair,
              style: const TextStyle(color: Colors.white),
              dropdownColor: const Color(0xFF2A2A2A),
              decoration: const InputDecoration(
                labelText: 'Language Pair',
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3A3A3A)),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'en_am', child: Text('English → Amharic')),
                DropdownMenuItem(value: 'zh_am', child: Text('Chinese → Amharic')),
                DropdownMenuItem(value: 'fr_am', child: Text('French → Amharic')),
                DropdownMenuItem(value: 'de_am', child: Text('German → Amharic')),
                DropdownMenuItem(value: 'es_am', child: Text('Spanish → Amharic')),
                DropdownMenuItem(value: 'ar_am', child: Text('Arabic → Amharic')),
              ],
              onChanged: (value) {
                setState(() => _selectedLanguagePair = value!);
              },
            ),
            const SizedBox(height: 16),
            
            // Level
            DropdownButtonFormField<String>(
              value: _selectedLevel,
              style: const TextStyle(color: Colors.white),
              dropdownColor: const Color(0xFF2A2A2A),
              decoration: const InputDecoration(
                labelText: 'Difficulty Level',
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3A3A3A)),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'beginner', child: Text('Beginner')),
                DropdownMenuItem(value: 'elementary', child: Text('Elementary')),
                DropdownMenuItem(value: 'intermediate', child: Text('Intermediate')),
                DropdownMenuItem(value: 'advanced', child: Text('Advanced')),
                DropdownMenuItem(value: 'expert', child: Text('Expert')),
              ],
              onChanged: (value) {
                setState(() => _selectedLevel = value!);
              },
            ),
            const SizedBox(height: 16),
            
            // XP Reward
            _buildNumberField(
              label: 'XP Reward',
              value: _xpReward,
              onChanged: (value) => setState(() => _xpReward = value),
            ),
            const SizedBox(height: 16),
            
            // Estimated Minutes
            _buildNumberField(
              label: 'Estimated Minutes',
              value: _estimatedMinutes,
              onChanged: (value) => setState(() => _estimatedMinutes = value),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNumberField({
    required String label,
    required int value,
    required Function(int) onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
        IconButton(
          onPressed: () => onChanged(value > 1 ? value - 1 : 1),
          icon: const Icon(Icons.remove_circle, color: Color(0xFF58CC02)),
        ),
        Text(
          value.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () => onChanged(value + 1),
          icon: const Icon(Icons.add_circle, color: Color(0xFF58CC02)),
        ),
      ],
    );
  }
  
  Widget _buildExercisePanel() {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          color: const Color(0xFF2A2A2A),
          child: Row(
            children: [
              const Text(
                'Exercises',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _addExercise,
                icon: const Icon(Icons.add),
                label: const Text('Add Exercise'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1CB0F6),
                ),
              ),
            ],
          ),
        ),
        
        // Exercise list
        Expanded(
          child: _exercises.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _exercises.length,
                  itemBuilder: (context, index) {
                    return _buildExerciseCard(_exercises[index], index);
                  },
                ),
        ),
      ],
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 80,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No exercises yet',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Click "Add Exercise" to get started',
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildExerciseCard(Map<String, dynamic> exercise, int index) {
    final type = exercise['type'] as String;
    final iconColor = _getExerciseColor(type);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF3A3A3A)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(_getExerciseIcon(type), color: iconColor),
        ),
        title: Text(
          _getExerciseTypeName(type),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          exercise['question'] ?? 'No question set',
          style: TextStyle(color: Colors.white.withOpacity(0.6)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF1CB0F6)),
              onPressed: () => _editExercise(index),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteExercise(index),
            ),
          ],
        ),
      ),
    );
  }
  
  Color _getExerciseColor(String type) {
    switch (type) {
      case 'conversation':
        return const Color(0xFF58CC02);
      case 'vocabulary':
        return const Color(0xFF1CB0F6);
      case 'multiple_choice':
        return const Color(0xFFFF6B6B);
      case 'listening':
        return const Color(0xFFFFD93D);
      default:
        return const Color(0xFF88D8C0);
    }
  }
  
  IconData _getExerciseIcon(String type) {
    switch (type) {
      case 'conversation':
        return Icons.chat_bubble;
      case 'vocabulary':
        return Icons.book;
      case 'multiple_choice':
        return Icons.checklist;
      case 'listening':
        return Icons.headphones;
      case 'typing':
        return Icons.keyboard;
      default:
        return Icons.school;
    }
  }
  
  String _getExerciseTypeName(String type) {
    switch (type) {
      case 'conversation':
        return 'Conversation Dialog';
      case 'vocabulary':
        return 'Vocabulary Flashcard';
      case 'multiple_choice':
        return 'Multiple Choice';
      case 'listening':
        return 'Listening Exercise';
      case 'typing':
        return 'Typing / Translation';
      default:
        return type;
    }
  }
  
  void _addExercise() {
    showDialog(
      context: context,
      builder: (context) => _ExerciseTypeDialog(
        onSelected: (type) {
          setState(() {
            _exercises.add({
              'type': type,
              'question': '',
              'answer_data': {},
              'order': _exercises.length,
            });
          });
        },
      ),
    );
  }
  
  void _editExercise(int index) {
    // Open exercise editor dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Exercise'),
        content: const Text('Exercise editor would open here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  void _deleteExercise(int index) {
    setState(() {
      _exercises.removeAt(index);
    });
  }
  
  void _previewLesson() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lesson Preview'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title: ${_titleController.text}'),
              Text('Level: $_selectedLevel'),
              Text('Exercises: ${_exercises.length}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  Future<void> _saveLesson() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      // TODO: Call API to save lesson
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lesson saved successfully!'),
            backgroundColor: Color(0xFF58CC02),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

class _ExerciseTypeDialog extends StatelessWidget {
  final Function(String) onSelected;
  
  const _ExerciseTypeDialog({required this.onSelected});
  
  @override
  Widget build(BuildContext context) {
    final types = [
      {'type': 'conversation', 'name': 'Conversation Dialog', 'icon': Icons.chat_bubble},
      {'type': 'vocabulary', 'name': 'Vocabulary Flashcard', 'icon': Icons.book},
      {'type': 'multiple_choice', 'name': 'Multiple Choice', 'icon': Icons.checklist},
      {'type': 'listening', 'name': 'Listening Exercise', 'icon': Icons.headphones},
      {'type': 'typing', 'name': 'Typing / Translation', 'icon': Icons.keyboard},
      {'type': 'matching', 'name': 'Matching Pairs', 'icon': Icons.compare_arrows},
    ];
    
    return AlertDialog(
      title: const Text('Choose Exercise Type'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: types.length,
          itemBuilder: (context, index) {
            final type = types[index];
            return ListTile(
              leading: Icon(type['icon'] as IconData, color: const Color(0xFF58CC02)),
              title: Text(type['name'] as String),
              onTap: () {
                Navigator.pop(context);
                onSelected(type['type'] as String);
              },
            );
          },
        ),
      ),
    );
  }
}
