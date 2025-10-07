import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/features/auth/models/app_user.dart';
import 'package:tourist_assistive_app/features/auth/services/auth_service.dart';
import 'package:tourist_assistive_app/features/subscription/services/subscription_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final subscriptionServiceProvider = Provider<SubscriptionService>((ref) => SubscriptionService());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final subscriptionService = ref.watch(subscriptionServiceProvider);
  return AuthNotifier(authService, subscriptionService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  final SubscriptionService _subscriptionService;
  
  AuthNotifier(this._authService, this._subscriptionService) : super(const AuthState.initial()) {
    _authService.authStateChanges.listen((user) {
      if (user == null) {
        state = const AuthState.unauthenticated();
      } else {
        state = AuthState.authenticated(AppUser.fromFirebaseUser(user));
      }
    });
  }
  
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = const AuthState.loading();
    try {
      await _authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
  
  Future<void> signUpWithEmailAndPassword(String email, String password, String name) async {
    state = const AuthState.loading();
    try {
      final userCredential = await _authService.signUpWithEmailAndPassword(email, password, name);
      
      // Start free trial for new users
      if (userCredential?.user != null) {
        try {
          await _subscriptionService.startFreeTrial(userCredential!.user!.uid);
          print('🎉 Free trial started for new user: $email');
        } catch (trialError) {
          print('⚠️ Failed to start trial: $trialError');
        }
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
  
  Future<void> signOut() async {
    await _authService.signOut();
  }
  
  Future<void> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
  
  // Debug method to check admin status
  void debugAdminStatus() {
    final user = state.user;
    if (user != null) {
      print('🔍 DEBUG ADMIN STATUS:');
      print('  - User email: ${user.email}');
      print('  - Is admin flag: ${user.isAdmin}');
      print('  - Admin email constant: ${AppUser.adminEmail}');
      print('  - Email comparison: "${user.email?.toLowerCase()}" == "${AppUser.adminEmail.toLowerCase()}"');
      print('  - Auth state: ${state.runtimeType}');
    } else {
      print('🔍 DEBUG: No user logged in');
    }
  }
}

class AuthState {
  final AppUser? user;
  final bool isLoading;
  final String? error;
  
  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });
  
  const AuthState.initial() : this();
  const AuthState.loading() : this(isLoading: true);
  const AuthState.authenticated(AppUser user) : this(user: user);
  const AuthState.unauthenticated() : this();
  const AuthState.error(String error) : this(error: error);
}
