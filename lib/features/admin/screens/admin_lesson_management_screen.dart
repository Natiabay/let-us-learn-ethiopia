import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist_assistive_app/features/auth/providers/auth_provider.dart';

class AdminLessonManagementScreen extends ConsumerStatefulWidget {
  const AdminLessonManagementScreen({super.key});

  @override
  ConsumerState<AdminLessonManagementScreen> createState() => _AdminLessonManagementScreenState();
}

class _AdminLessonManagementScreenState extends ConsumerState<AdminLessonManagementScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'all';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filterOptions = ['all', 'beginner', 'intermediate', 'advanced'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watchauthProvider;
    final user = authState.user;
    
    // Check if user is admin
    if (user == null || !user.isAdmin) {
      WidgetsBinding.instance.addPostFrameCallback(_ {
        context.go('/home');
      });
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        elevation: 0,
        title: const Text(
          'Lesson Management',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/admin'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => context.push('/admin/lessons/editor'),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          Expanded(
            child: _buildLessonsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF2A2A2A),
        border: Border(
          bottom: BorderSide(color: Color(0xFF3A3A3A)),
        ),
      ),
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search lessons...',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
              prefixIcon: const Icon(Icons.search, color: Colors.white70),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.white70),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: const Color(0xFF3A3A3A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
          ),
          const SizedBox(height: 16),
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _filterOptions.map(filter {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      filter.toUpperCase(),
                      style: TextStyle(
                        color: _selectedFilter == filter ? Colors.white : Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    selected: _selectedFilter == filter,
                    onSelected: selected {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    selectedColor: const Color(0xFF58CC02),
                    backgroundColor: const Color(0xFF3A3A3A),
                    checkmarkColor: Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonsList() {
    Query query = FirebaseFirestore.instance
        .collection('lessons')
        .orderBy('createdAt', descending: true);

    // Apply filter
    if (_selectedFilter != 'all') {
      query = query.where('level', isEqualTo: _selectedFilter);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 64),
                const SizedBox(height: 16),
                Text(
                  'Error loading lessons: $snapshot.error',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF58CC02),
            ),
          );
        }

        final lessons = snapshot.data!.docs;
        
        // Apply search filter
        final filteredLessons = lessons.where(doc {
          if (_searchQuery.isEmpty) return true;
          
          final data = doc.data() as Map<String, dynamic>;
          final title = (data['title'] ?? '').toString().toLowerCase();
          final description = (data['description'] ?? '').toString().toLowerCase();
          
          return title.contains_searchQuery || description.contains_searchQuery;
        }).toList();

        if (filteredLessons.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.school_outlined, color: Colors.white54, size: 64),
                const SizedBox(height: 16),
                Text(
                  'No lessons found',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredLessons.length,
          itemBuilder: (context, index) {
            final lessonDoc = filteredLessons[index];
            final lessonData = lessonDoc.data() as Map<String, dynamic>;
            
            return _buildLessonCard(lessonDoc.id, lessonData);
          },
        );
      },
    );
  }

  Widget _buildLessonCard(String lessonId, Map<String, dynamic> lessonData) {
    final title = lessonData['title'] ?? 'Untitled Lesson';
    final description = lessonData['description'] ?? 'No description';
    final level = lessonData['level'] ?? 'beginner';
    final category = lessonData['category'] ?? 'General';
    final isActive = lessonData['isActive'] == true;
    final exerciseCount = (lessonData['exercises'] as List?)?.length ?? 0;
    final createdAt = lessonData['createdAt'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getLevelColorlevel,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  level.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  category.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFF4CAF50) : const Color(0xFF9E9E9E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isActive ? 'ACTIVE' : 'INACTIVE',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.quiz_outlined,
                color: Colors.white.withValues(alpha: 0.7),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '$exerciseCount exercises',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              if (createdAt != null)
                Text(
                  'Created: $_formatDatecreatedAt',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showLessonDetails(lessonId, lessonData),
                  icon: const Icon(Icons.info_outline, size: 16),
                  label: const Text('Details'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showLessonActions(lessonId, lessonData),
                  icon: const Icon(Icons.more_vert, size: 16),
                  label: const Text('Actions'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A2A2A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'beginner':
        return const Color(0xFF4CAF50);
      case 'intermediate':
        return const Color(0xFFFF9800);
      case 'advanced':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'Unknown';
    
    DateTime date;
    if (timestamp is Timestamp) {
      date = timestamp.toDate();
    } else if (timestamp is DateTime) {
      date = timestamp;
    } else {
      return 'Unknown';
    }
    
    return '$date.day/$date.month/$date.year';
  }


  void _showLessonDetails(String lessonId, Map<String, dynamic> lessonData) {
    showDialog(
      context: context,
      builder: context => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Lesson Details',
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Lesson ID', lessonId),
              _buildDetailRow('Title', lessonData['title'] ?? 'N/A'),
              _buildDetailRow('Description', lessonData['description'] ?? 'N/A'),
              _buildDetailRow('Level', lessonData['level'] ?? 'N/A'),
              _buildDetailRow('Category', lessonData['category'] ?? 'N/A'),
              _buildDetailRow('Active', lessonData['isActive'] == true ? 'Yes' : 'No'),
              _buildDetailRow('Exercise Count', '$(lessonData['exercises'] as List?)?.length ?? 0'),
              _buildDetailRow('Created At', _formatDate(lessonData['createdAt'])),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.popcontext,
            child: const Text('Close', style: TextStyle(color: Color(0xFF58CC02))),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showLessonActions(String lessonId, Map<String, dynamic> lessonData) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      builder: context => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Lesson Actions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('Edit Lesson', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.popcontext;
                context.push('/admin/lessons/editor/$lessonId');
              },
            ),
            ListTile(
              leading: Icon(
                lessonData['isActive'] == true ? Icons.pause : Icons.play_arrow,
                color: lessonData['isActive'] == true ? Colors.orange : Colors.green,
              ),
              title: Text(
                lessonData['isActive'] == true ? 'Deactivate' : 'Activate',
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.popcontext;
                _toggleLessonStatus(lessonId, lessonData);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Lesson', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.popcontext;
                _deleteLessonlessonId;
              },
            ),
          ],
        ),
      ),
    );
  }

  void _toggleLessonStatus(String lessonId, Map<String, dynamic> lessonData) {
    // Toggle lesson status will be implemented with backend integration
    ScaffoldMessenger.ofcontext.showSnackBar(
      const SnackBar(
        content: Text('Toggle lesson status functionality not implemented yet'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _deleteLesson(String lessonId) {
    // Delete lesson will be implemented with backend integration
    ScaffoldMessenger.ofcontext.showSnackBar(
      const SnackBar(
        content: Text('Delete lesson functionality not implemented yet'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
