import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_assistive_app/core/services/firebase_service.dart';

class AuthState {
  final bool isAuthenticated;
  final User? user;
  final bool isLoading;
  final String? error;
  
  AuthState({
    required this.isAuthenticated,
    this.user,
    required this.isLoading,
    this.error,
  });
  
  factory AuthState.initial() => AuthState(
    isAuthenticated: false,
    isLoading: true,
  );
  
  factory AuthState.authenticated(User user) => AuthState(
    isAuthenticated: true,
    user: user,
    isLoading: false,
  );
  
  factory AuthState.unauthenticated() => AuthState(
    isAuthenticated: false,
    isLoading: false,
  );
  
  factory AuthState.error(String error) => AuthState(
    isAuthenticated: false,
    isLoading: false,
    error: error,
  );
  
  @override
  String toString() {
    return 'AuthState(isAuthenticated: $isAuthenticated, user: ${user?.uid}, isLoading: $isLoading, error: $error)';
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.initial()) {
    _initialize();
  }
  
  Future<void> _initialize() async {
    print('🔐 Initializing Auth Provider...');
    
    try {
      // Wait for Firebase to be ready
      int attempts = 0;
      while (!FirebaseService.isInitialized && attempts < 50) {
        await Future.delayed(Duration(milliseconds: 100));
        attempts++;
        print('⏳ Waiting for Firebase initialization... attempt $attempts');
      }
      
      if (!FirebaseService.isInitialized) {
        print('❌ Firebase not initialized after 5 seconds');
        state = AuthState.error('Firebase initialization timeout');
        return;
      }
      
      print('✅ Firebase is ready, setting up auth listener');
      
      // Listen to auth state changes
      FirebaseAuth.instance.authStateChanges().listen(
        (User? user) {
          print('🔄 Auth state changed: ${user?.uid ?? 'null'}');
          if (user != null) {
            state = AuthState.authenticated(user);
            FirebaseService.initializeUserDocument(user);
          } else {
            state = AuthState.unauthenticated();
          }
        },
        onError: (error) {
          print('❌ Auth state change error: $error');
          state = AuthState.error(error.toString());
        },
      );
      
      // Set initial state based on current user
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        print('👤 Current user found: ${currentUser.uid}');
        state = AuthState.authenticated(currentUser);
        FirebaseService.initializeUserDocument(currentUser);
      } else {
        print('👤 No current user');
        state = AuthState.unauthenticated();
      }
      
    } catch (e) {
      print('❌ Auth initialization error: $e');
      state = AuthState.error(e.toString());
    }
  }
  
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      state = AuthState(
        isAuthenticated: false,
        isLoading: true,
      );
      
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // State will be updated by the listener
    } catch (e) {
      print('❌ Sign in error: $e');
      state = AuthState.error(e.toString());
    }
  }
  
  Future<void> signUpWithEmailAndPassword(String email, String password, [String? fullName]) async {
    try {
      state = AuthState(
        isAuthenticated: false,
        isLoading: true,
      );
      
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Update display name if provided
      if (fullName != null && userCredential.user != null) {
        await userCredential.user!.updateDisplayName(fullName);
      }
      
      // State will be updated by the listener
    } catch (e) {
      print('❌ Sign up error: $e');
      state = AuthState.error(e.toString());
    }
  }
  
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // State will be updated by the listener
    } catch (e) {
      print('❌ Sign out error: $e');
      state = AuthState.error(e.toString());
    }
  }
  
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('❌ Password reset error: $e');
      state = AuthState.error(e.toString());
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});