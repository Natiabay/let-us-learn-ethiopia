import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tourist_assistive_app/firebase_options.dart';

class FirebaseService {
  static bool _initialized = false;
  static String? _initializationError;

  static bool get isInitialized => _initialized;
  static String? get initializationError => _initializationError;

  /// Initialize Firebase with comprehensive error handling
  static Future<bool> initialize() async {
    try {
      if (_initialized) {
        return true;
      }

      // Initialize Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Test Firebase services
      await _testFirebaseServices();

      _initialized = true;
      _initializationError = null;
      
      print('✅ Firebase initialized successfully');
      return true;
    } catch (e) {
      _initializationError = 'Firebase initialization failed: $e';
      print('❌ Firebase initialization error: $e');
      return false;
    }
  }

  /// Test all Firebase services to ensure they're working
  static Future<void> _testFirebaseServices() async {
    try {
      // Test Authentication
      final auth = FirebaseAuth.instance;
      print('🔐 Firebase Auth initialized: ${auth.app.name}');

      // Test Firestore with minimal permissions
      final firestore = FirebaseFirestore.instance;
      
      // Try to read from a public collection (will fail gracefully if doesn't exist)
      try {
        await firestore.collection('appSettings').limit(1).get().timeout(
          const Duration(seconds: 5),
        );
        print('✅ Firestore connection test successful');
      } catch (e) {
        if (e.toString().contains('permission-denied')) {
          print('⚠️  Firestore permissions not yet configured (expected for new users)');
        } else {
          print('⚠️  Firestore connection test failed: $e');
        }
      }

      // Test Storage
      try {
        final storage = FirebaseStorage.instance;
        print('🗂️  Firebase Storage initialized: ${storage.app.name}');
      } catch (e) {
        print('⚠️  Firebase Storage test failed: $e');
      }

    } catch (e) {
      print('⚠️  Firebase services test failed: $e');
      // Don't throw error here, as the app can still work with limited functionality
    }
  }

  /// Check if user is authenticated
  static bool get isUserAuthenticated {
    return FirebaseAuth.instance.currentUser != null;
  }

  /// Get current user
  static User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }

  /// Initialize user document in Firestore after authentication
  static Future<void> initializeUserDocument(User user) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
      
      // Check if document exists
      final docSnapshot = await userDoc.get();
      
      // Check if user is admin
      final isAdmin = user.email?.toLowerCase() == 'kiru72fekadu@gmail.com';
      
      if (!docSnapshot.exists) {
        // Create new user document
        await userDoc.set({
          'uid': user.uid,
          'email': user.email,
          'displayName': user.displayName,
          'photoURL': user.photoURL,
          'emailVerified': user.emailVerified,
          'isAdmin': isAdmin,
          'role': isAdmin ? 'admin' : 'user',
          'createdAt': FieldValue.serverTimestamp(),
          'lastLoginAt': FieldValue.serverTimestamp(),
          'profileCompleted': false,
          'preferences': {
            'language': 'en',
            'notifications': true,
          },
        });
        print('✅ User document created successfully${isAdmin ? ' (Admin)' : ''}');
      } else {
        // Update last login time and admin status
        await userDoc.update({
          'lastLoginAt': FieldValue.serverTimestamp(),
          'isAdmin': isAdmin,
          'role': isAdmin ? 'admin' : 'user',
        });
        print('✅ User document updated with last login${isAdmin ? ' (Admin)' : ''}');
      }
      
      // If admin, set up admin-specific data
      if (isAdmin) {
        await _setupAdminData(user);
      }
    } catch (e) {
      print('⚠️  Failed to initialize user document: $e');
      // Don't throw error, as authentication still works
    }
  }

  /// Set up admin-specific data
  static Future<void> _setupAdminData(User user) async {
    try {
      // Create admin settings
      await FirebaseFirestore.instance.collection('admin').doc('settings').set({
        'adminUsers': [user.email],
        'permissions': {
          'userManagement': true,
          'lessonManagement': true,
          'contentManagement': true,
          'analytics': true,
          'subscriptionManagement': true,
        },
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      
      print('✅ Admin settings configured');
    } catch (e) {
      print('⚠️  Failed to set up admin data: $e');
    }
  }

  /// Create initial app settings if they don't exist
  static Future<void> initializeAppSettings() async {
    try {
      final settingsDoc = FirebaseFirestore.instance.collection('appSettings').doc('general');
      
      final docSnapshot = await settingsDoc.get();
      
      if (!docSnapshot.exists) {
        await settingsDoc.set({
          'appVersion': '1.0.0',
          'maintenanceMode': false,
          'supportedLanguages': ['en', 'am'],
          'emergencyContacts': {
            'police': '991',
            'medical': '907',
            'fire': '939',
          },
          'lastUpdated': FieldValue.serverTimestamp(),
        });
        print('✅ App settings initialized');
      }
    } catch (e) {
      if (e.toString().contains('permission-denied')) {
        print('⚠️  Firestore permissions not configured (app will work with limited features)');
      } else {
        print('⚠️  Failed to initialize app settings: $e');
      }
    }
  }

  /// Handle authentication state changes
  static void listenToAuthChanges(Function(User?) onAuthStateChanged) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is signed in
        initializeUserDocument(user);
      }
      onAuthStateChanged(user);
    });
  }

  /// Sign out user
  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('✅ User signed out successfully');
    } catch (e) {
      print('❌ Sign out error: $e');
      rethrow;
    }
  }
}
