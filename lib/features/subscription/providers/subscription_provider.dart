import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_assistive_app/features/subscription/models/subscription_model.dart';
import 'package:tourist_assistive_app/features/subscription/services/subscription_service.dart';
import 'package:tourist_assistive_app/features/subscription/services/trial_service.dart';

// Subscription service provider
final subscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  return SubscriptionService();
});

// Current user subscription stream provider
final subscriptionProvider = StreamProvider<SubscriptionModel?>((ref) {
  final subscriptionService = ref.watch(subscriptionServiceProvider);
  return subscriptionService.subscriptionStream();
});

// Subscription access provider - checks if user has active subscription
// TEMPORARILY ALLOWING ALL ACCESS UNTIL REAL PAYMENT INTEGRATION
final hasAccessProvider = Provider<bool>((ref) {
  // TODO: Replace with real subscription check when payment integration is ready
  return true; // Allow everything for now
});

// Trial status provider using TrialService
// TEMPORARILY ALLOWING ALL ACCESS UNTIL REAL PAYMENT INTEGRATION
final trialStatusProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  // TODO: Replace with real trial check when payment integration is ready
  return {
    'hasAccess': true,
    'isTrialActive': true,
    'trialDaysRemaining': 30,
    'message': 'Full access granted - payment integration pending'
  };
});

// Subscription actions provider
final subscriptionActionsProvider = Provider<SubscriptionActions>((ref) {
  final subscriptionService = ref.watch(subscriptionServiceProvider);
  return SubscriptionActions(subscriptionService);
});

class SubscriptionActions {
  final SubscriptionService _subscriptionService;

  SubscriptionActions(this._subscriptionService);

  Future<void> startFreeTrial() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _subscriptionService.startFreeTrial(user.uid);
    }
  }

  Future<void> activatePremium({
    required int durationDays,
    required String paymentMethod,
    required double amount,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _subscriptionService.activatePremiumSubscription(
        userId: user.uid,
        durationDays: durationDays,
        paymentMethod: paymentMethod,
        amount: amount,
      );
    }
  }

  Future<void> cancelSubscription() async {
    await _subscriptionService.cancelSubscription();
  }
}
