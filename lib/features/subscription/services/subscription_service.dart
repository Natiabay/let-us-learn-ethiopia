import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_assistive_app/features/subscription/models/subscription_model.dart';
import 'package:tourist_assistive_app/features/subscription/services/trial_counter_service.dart';

class SubscriptionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TrialCounterService _trialCounter = TrialCounterService();

  static const int _trialDurationDays = 1;

  /// Get subscription status for current user
  Future<SubscriptionModel?> getCurrentUserSubscription() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    try {
      final doc = await _firestore
          .collection('subscriptions')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        return SubscriptionModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error getting subscription: $e');
      return null;
    }
  }

  /// Create free trial for new user with precise timing
  Future<SubscriptionModel> startFreeTrial(String userId) async {
    final now = DateTime.now();
    // Use precise 24-hour duration (1440 minutes)
    final trialEnd = now.add(const Duration(hours: 24));

    final subscription = SubscriptionModel(
      userId: userId,
      status: SubscriptionStatus.trial,
      createdAt: now,
      trialStartedAt: now,
      trialEndsAt: trialEnd,
    );

    await _firestore
        .collection('subscriptions')
        .doc(userId)
        .set(subscription.toFirestore());

    // Start monitoring trial countdown
    _trialCounter.startTrialMonitoring();

    print('✅ Free trial started for user $userId until $trialEnd (exactly 24 hours)');
    return subscription;
  }

  /// Check if user has active subscription or trial
  Future<bool> hasActiveSubscription() async {
    final subscription = await getCurrentUserSubscription();
    return subscription?.hasAccess ?? false;
  }

  /// Update subscription status when trial expires
  Future<void> expireTrialIfNeeded(SubscriptionModel subscription) async {
    if (subscription.status == SubscriptionStatus.trial && 
        subscription.trialEndsAt != null &&
        DateTime.now().isAfter(subscription.trialEndsAt!)) {
      
      await _firestore
          .collection('subscriptions')
          .doc(subscription.userId)
          .update({'status': SubscriptionStatus.trialExpired.name});

      print('⏰ Trial expired for user ${subscription.userId}');
    }
  }

  /// Activate premium subscription after payment
  Future<void> activatePremiumSubscription({
    required String userId,
    required int durationDays,
    required String paymentMethod,
    required double amount,
  }) async {
    final now = DateTime.now();
    final paidUntil = now.add(Duration(days: durationDays));

    final updates = {
      'status': SubscriptionStatus.premium.name,
      'paidUntil': Timestamp.fromDate(paidUntil),
      'paymentMethod': paymentMethod,
      'lastPaymentAmount': amount,
    };

    await _firestore
        .collection('subscriptions')
        .doc(userId)
        .update(updates);

    print('✅ Premium subscription activated for user $userId until $paidUntil');
  }

  /// Get subscription status with real-time updates
  Stream<SubscriptionModel?> subscriptionStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value(null);

    return _firestore
        .collection('subscriptions')
        .doc(user.uid)
        .snapshots()
        .map((doc) {
          if (doc.exists) {
            final subscription = SubscriptionModel.fromFirestore(doc);
            // The trial counter service handles expiration monitoring
            return subscription;
          }
          return null;
        });
  }

  /// Get trial status with precise timing
  Future<TrialStatus> getTrialStatus() async {
    final user = _auth.currentUser;
    if (user == null) {
      return TrialStatus(
        isActive: false,
        timeRemaining: null,
        progress: 0.0,
        isExpired: false,
        isAboutToExpire: false,
      );
    }

    return await _trialCounter.getTrialStatus(user.uid);
  }

  /// Get user subscription stats
  Future<Map<String, dynamic>> getSubscriptionStats() async {
    final user = _auth.currentUser;
    if (user == null) return {};

    final subscription = await getCurrentUserSubscription();
    if (subscription == null) return {};

    return {
      'status': subscription.status.name,
      'hasAccess': subscription.hasAccess,
      'isTrialActive': subscription.isTrialActive,
      'isPremiumActive': subscription.isPremiumActive,
      'trialTimeLeft': subscription.trialTimeLeft,
      'trialEndsAt': subscription.trialEndsAt,
      'paidUntil': subscription.paidUntil,
    };
  }

  /// Cancel subscription
  Future<void> cancelSubscription() async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('subscriptions')
        .doc(user.uid)
        .update({'status': SubscriptionStatus.cancelled.name});

    print('❌ Subscription cancelled for user ${user.uid}');
  }
}
