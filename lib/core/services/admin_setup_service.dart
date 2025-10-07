import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Service to set up admin user and ensure proper Firebase configuration
class AdminSetupService {
  static const String adminEmail = 'kiru72fekadu@gmail.com';
  static const String adminPassword = '12332122';
  
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Initialize admin user in Firebase
  static Future<void> initializeAdminUser() async {
    try {
      print('🔧 Setting up admin user in Firebase...');
      
      // Check if admin user already exists
      final adminUser = await _checkAdminUserExists();
      
      if (adminUser != null) {
        print('✅ Admin user already exists: ${adminUser.email}');
        await _updateAdminUserDocument(adminUser);
      } else {
        print('⚠️ Admin user not found in Firebase Auth');
        print('📝 Please create admin user manually in Firebase Console:');
        print('   Email: $adminEmail');
        print('   Password: $adminPassword');
        print('   Or run: flutter run --dart-define=CREATE_ADMIN=true');
      }
      
    } catch (e) {
      print('❌ Admin setup error: $e');
    }
  }

  /// Check if admin user exists in Firebase Auth
  static Future<User?> _checkAdminUserExists() async {
    try {
      // Get all users (this requires Admin SDK in production)
      // For now, we'll check if current user is admin
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser?.email?.toLowerCase() == adminEmail.toLowerCase()) {
        return currentUser;
      }
      return null;
    } catch (e) {
      print('⚠️ Could not check admin user: $e');
      return null;
    }
  }

  /// Update admin user document in Firestore
  static Future<void> _updateAdminUserDocument(User user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName ?? 'Admin User',
        'photoURL': user.photoURL,
        'emailVerified': user.emailVerified,
        'isAdmin': true,
        'role': 'admin',
        'permissions': [
          'read_all_users',
          'write_all_users',
          'manage_lessons',
          'manage_content',
          'view_analytics',
          'manage_subscriptions'
        ],
        'createdAt': FieldValue.serverTimestamp(),
        'lastLoginAt': FieldValue.serverTimestamp(),
        'profileCompleted': true,
      }, SetOptions(merge: true));
      
      print('✅ Admin user document updated in Firestore');
    } catch (e) {
      print('❌ Failed to update admin user document: $e');
    }
  }

  /// Create admin settings document
  static Future<void> createAdminSettings() async {
    try {
      await _firestore.collection('admin').doc('settings').set({
        'adminUsers': [adminEmail],
        'permissions': {
          'userManagement': true,
          'lessonManagement': true,
          'contentManagement': true,
          'analytics': true,
          'subscriptionManagement': true,
        },
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      
      print('✅ Admin settings created');
    } catch (e) {
      print('❌ Failed to create admin settings: $e');
    }
  }

  /// Verify admin authentication
  static Future<bool> verifyAdminAccess(User user) async {
    try {
      // Check if user email matches admin email
      if (user.email?.toLowerCase() != adminEmail.toLowerCase()) {
        return false;
      }

      // Check if user document has admin flag
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        return userData?['isAdmin'] == true;
      }

      return false;
    } catch (e) {
      print('❌ Admin verification error: $e');
      return false;
    }
  }

  /// Get admin dashboard data
  static Future<Map<String, dynamic>> getAdminDashboardData() async {
    try {
      // Get user count
      final usersSnapshot = await _firestore.collection('users').get();
      final userCount = usersSnapshot.docs.length;

      // Get subscription count
      final subscriptionsSnapshot = await _firestore.collection('subscriptions').get();
      final subscriptionCount = subscriptionsSnapshot.docs.length;

      // Get lesson count
      final lessonsSnapshot = await _firestore.collection('lessons').get();
      final lessonCount = lessonsSnapshot.docs.length;

      // Get recent activity
      final recentUsers = await _firestore
          .collection('users')
          .orderBy('lastLoginAt', descending: true)
          .limit(5)
          .get();

      return {
        'totalUsers': userCount,
        'activeSubscriptions': subscriptionCount,
        'totalLessons': lessonCount,
        'recentUsers': recentUsers.docs.map((doc) => doc.data()).toList(),
        'lastUpdated': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      print('❌ Failed to get admin dashboard data: $e');
      return {
        'totalUsers': 0,
        'activeSubscriptions': 0,
        'totalLessons': 0,
        'recentUsers': [],
        'error': e.toString(),
      };
    }
  }
}
