/// Wrapper for Admin Dashboard - redirects to admin panel
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist_assistive_app/features/auth/providers/auth_provider.dart';
import 'package:tourist_assistive_app/core/services/admin_setup_service.dart';
import 'package:tourist_assistive_app/features/admin/screens/admin_feedback_screen.dart';

class AdminDashboardScreenWrapper extends ConsumerWidget {
  const AdminDashboardScreenWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    
    // Check if user is admin
    if (user == null || !user.isAdmin) {
      // Not admin, redirect to home
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/home');
      });
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Initialize admin setup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AdminSetupService.initializeAdminUser();
    });

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF58CC02), Color(0xFF1CB0F6)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.admin_panel_settings, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              'Admin Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
              if (context.mounted) {
                context.go('/auth');
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF58CC02), Color(0xFF1CB0F6)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF58CC02).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.waving_hand, color: Colors.white, size: 40),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome Admin!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.email ?? '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Real-time Firebase data
              _buildFirebaseDataCard(),
              
              const SizedBox(height: 16),
              
              // Admin Panel Info
              _buildInfoCard(
                icon: Icons.info_outline,
                title: 'Admin Panel Available',
                description: 'The complete admin panel with lesson builder, user management, and RAG knowledge base is available separately.',
                color: const Color(0xFF1CB0F6),
              ),
              
              const SizedBox(height: 16),
              
              _buildInfoCard(
                icon: Icons.rocket_launch,
                title: 'Quick Start',
                description: 'To access the full admin panel:\n1. Open terminal\n2. Run: START_ADMIN_PANEL.bat\n3. Open: http://localhost:8000/admin/docs',
                color: const Color(0xFFFF6B6B),
              ),
              
              const SizedBox(height: 16),
              
              _buildInfoCard(
                icon: Icons.school,
                title: 'Create Lessons',
                description: 'Use the admin panel to create Duolingo-style lessons with 6+ exercise types (conversation, multiple choice, listening, etc.)',
                color: const Color(0xFFFFD93D),
              ),
              
              const SizedBox(height: 32),
              
              // Quick Actions
              const Text(
                'Quick Actions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 16),
              
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildActionButton(
                    context,
                    label: 'Feedback Management',
                    icon: Icons.feedback,
                    color: const Color(0xFF58CC02),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminFeedbackScreen(),
                        ),
                      );
                    },
                  ),
                  _buildActionButton(
                    context,
                    label: 'View Users',
                    icon: Icons.people,
                    color: const Color(0xFF1CB0F6),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Feature available in full admin panel'),
                          backgroundColor: Color(0xFF1CB0F6),
                        ),
                      );
                    },
                  ),
                  _buildActionButton(
                    context,
                    label: 'Manage Lessons',
                    icon: Icons.menu_book,
                    color: const Color(0xFFFFD93D),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Feature available in full admin panel'),
                          backgroundColor: Color(0xFF1CB0F6),
                        ),
                      );
                    },
                  ),
                  _buildActionButton(
                    context,
                    label: 'View Main App',
                    icon: Icons.home,
                    color: const Color(0xFFFF6B6B),
                    onTap: () {
                      context.go('/home');
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Documentation
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF3A3A3A)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.library_books, color: Color(0xFF58CC02), size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Documentation',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDocLink('admin_panel/README.md', 'Complete Admin Panel Guide'),
                    _buildDocLink('admin_panel/QUICKSTART.md', '5-Minute Quick Start'),
                    _buildDocLink('admin_panel/API_EXAMPLES.md', 'API Usage Examples'),
                    _buildDocLink('START_HERE.md', 'Getting Started Guide'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3), width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDocLink(String path, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.arrow_right, color: Color(0xFF58CC02), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ),
          Text(
            path,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirebaseDataCard() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildInfoCard(
            icon: Icons.error_outline,
            title: 'Database Error',
            description: 'Failed to load user data: ${snapshot.error}',
            color: const Color(0xFFFF4B4B),
          );
        }

        if (!snapshot.hasData) {
          return _buildInfoCard(
            icon: Icons.hourglass_empty,
            title: 'Loading Data...',
            description: 'Connecting to Firebase database...',
            color: const Color(0xFF1CB0F6),
          );
        }

        final users = snapshot.data!.docs;
        final totalUsers = users.length;
        final adminUsers = users.where((doc) => doc.data() is Map && 
            (doc.data() as Map)['isAdmin'] == true).length;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF58CC02), Color(0xFF1CB0F6)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF58CC02).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.dashboard, color: Colors.white, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Firebase Database Status',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Total Users', totalUsers.toString(), Icons.people),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('Admin Users', adminUsers.toString(), Icons.admin_panel_settings),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Database', 'Connected', Icons.cloud_done),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('Status', 'Active', Icons.check_circle),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
