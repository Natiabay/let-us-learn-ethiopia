import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  
  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      print('🔍 Attempting login for: $email');
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      print('✅ Login successful for: $email');
      
      // Update user document with admin status if needed
      if (credential.user != null) {
        // Enhanced admin detection
        final userEmail = email.toLowerCase().trim();
        final adminEmail = 'kiru72fekadu@gmail.com'.toLowerCase().trim();
        final isAdmin = userEmail == adminEmail;
        
        print('🔍 Enhanced admin status check:');
        print('  - User email: "$userEmail"');
        print('  - Admin email: "$adminEmail"');
        print('  - Is admin: $isAdmin');

        try {
          await _firestore.collection('users').doc(credential.user!.uid).set({
            'uid': credential.user!.uid,
            'email': email,
            'displayName': credential.user!.displayName ?? 'User',
            'photoURL': credential.user!.photoURL,
            'emailVerified': credential.user!.emailVerified,
            'isAdmin': isAdmin,
            'role': isAdmin ? 'admin' : 'user',
            'lastLoginAt': FieldValue.serverTimestamp(),
            'profileCompleted': true,
            'adminEmail': adminEmail, // Store for verification
            'adminVerified': isAdmin, // Additional verification flag
          }, SetOptions(merge: true));

          print('🔍 Auth Service: Updated user ${email} with isAdmin: $isAdmin');
          print('🔍 Firestore update successful');
        } catch (e) {
          print('⚠️  Firestore update failed (user still authenticated): $e');
          // Continue without Firestore - user is still authenticated
        }

        if (isAdmin) {
          print('✅ ADMIN USER LOGGED IN: $email');
          print('✅ Admin status confirmed in Firestore');
        }
      }
      
      return credential;
    } on FirebaseAuthException catch (e) {
      print('❌ Login failed for $email: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    }
  }

  // Create user with email and password (alias)
  Future<UserCredential?> createUserWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  ) async {
    return signUpWithEmailAndPassword(email, password, fullName);
  }

  // Sign up with email and password
  Future<UserCredential?> signUpWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await credential.user?.updateDisplayName(fullName);

      // Create user document in Firestore (with error handling)
      final isAdmin = email.toLowerCase() == 'kiru72fekadu@gmail.com';
      try {
        await _firestore.collection('users').doc(credential.user?.uid).set({
          'uid': credential.user?.uid,
          'email': email,
          'fullName': fullName,
          'isAdmin': isAdmin,
          'role': isAdmin ? 'admin' : 'user',
          'createdAt': FieldValue.serverTimestamp(),
          'profileCompleted': false,
        });
        print('✅ User document created in Firestore');
      } catch (e) {
        print('⚠️  Firestore write failed (user still authenticated): $e');
        // Continue without Firestore - user is still authenticated
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Create admin account if it doesn't exist
  Future<void> createAdminAccountIfNeeded() async {
    try {
      const adminEmail = 'kiru72fekadu@gmail.com';
      const adminPassword = '12332122';
      
      print('🔧 ADMIN SETUP: Starting admin account verification...');
      print('📧 Target email: $adminEmail');
      print('🔑 Target password: $adminPassword');
      
      // Try to sign in first to check if account exists
      try {
        print('🔍 ADMIN CHECK: Attempting to sign in with admin credentials...');
        await _auth.signInWithEmailAndPassword(
          email: adminEmail,
          password: adminPassword,
        );
        print('✅ ADMIN EXISTS: Admin account already exists and credentials are correct');
        await _auth.signOut(); // Sign out after check
        return;
      } catch (e) {
        print('🔍 ADMIN CHECK RESULT: $e');
        
        // Account doesn't exist, create it
        if (e.toString().contains('user-not-found')) {
          print('🔧 ADMIN CREATION: Admin account not found, creating new account...');
          print('📧 Creating account for: $adminEmail');
          print('🔑 Using password: $adminPassword');
          
          final credential = await _auth.createUserWithEmailAndPassword(
            email: adminEmail,
            password: adminPassword,
          );
          
          print('✅ FIREBASE AUTH: Admin account created in Firebase Authentication');
          
          // Update display name
          await credential.user?.updateDisplayName('Admin User');
          print('✅ DISPLAY NAME: Set to "Admin User"');
          
          // Create admin user document (with error handling)
          try {
            print('🔧 FIRESTORE: Creating admin document in Firestore...');
            await _firestore.collection('users').doc(credential.user?.uid).set({
              'uid': credential.user?.uid,
              'email': adminEmail,
              'displayName': 'Admin User',
              'photoURL': null,
              'emailVerified': false,
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
              'adminEmail': adminEmail,
              'adminVerified': true,
            });
            print('✅ FIRESTORE: Admin document created with full permissions');
          } catch (e) {
            print('⚠️  FIRESTORE ERROR: Admin document creation failed: $e');
            print('⚠️  NOTE: Admin account still exists in Firebase Auth');
          }
          
          print('🎉 ADMIN SUCCESS: Admin account created successfully!');
          print('📧 Email: $adminEmail');
          print('🔑 Password: $adminPassword');
          print('🎯 Ready for admin login!');
        } else {
          print('❌ ADMIN ERROR: Unexpected error during admin account check: $e');
        }
      }
    } catch (e) {
      print('❌ ADMIN FAILURE: Failed to create admin account: $e');
      print('🔧 MANUAL SETUP: Please create admin account manually in Firebase Console');
      print('📧 Email: kiru72fekadu@gmail.com');
      print('🔑 Password: 12332122');
    }
  }

  // Handle auth exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}