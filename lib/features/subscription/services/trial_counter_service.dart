import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_assistive_app/features/subscription/models/subscription_model.dart';

/// Precise Trial Counter Service for exact day counting
class TrialCounterService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Timer? _trialTimer;
  static const Duration _checkInterval = Duration(minutes: 1); // Check every minute

  /// Start monitoring trial countdown
  void startTrialMonitoring() {
    _trialTimer?.cancel();
    _trialTimer = Timer.periodic(_checkInterval, (timer) {
      _checkTrialExpiration();
    });
  }

  /// Stop monitoring trial countdown
  void stopTrialMonitoring() {
    _trialTimer?.cancel();
    _trialTimer = null;
  }

  /// Check if trial has expired and update status
  Future<void> _checkTrialExpiration() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final subscription = await _getCurrentSubscription(user.uid);
      if (subscription == null) return;

      // Only check if trial is active
      if (subscription.status != SubscriptionStatus.trial) return;

      final now = DateTime.now();
      final trialEndsAt = subscription.trialEndsAt;

      if (trialEndsAt != null && now.isAfter(trialEndsAt)) {
        await _expireTrial(user.uid);
        debugPrint('⏰ Trial expired for user ${user.uid} at ${now.toIso8601String()}');
      }
    } catch (e) {
      debugPrint('Error checking trial expiration: $e');
    }
  }

  /// Get current subscription
  Future<SubscriptionModel?> _getCurrentSubscription(String userId) async {
    try {
      final doc = await _firestore
          .collection('subscriptions')
          .doc(userId)
          .get();

      if (doc.exists) {
        return SubscriptionModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting subscription: $e');
      return null;
    }
  }

  /// Expire trial and update status
  Future<void> _expireTrial(String userId) async {
    try {
      await _firestore
          .collection('subscriptions')
          .doc(userId)
          .update({
        'status': SubscriptionStatus.trialExpired.name,
        'trial_expired_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });

      // Send notification to user about trial expiration
      await _sendTrialExpiredNotification(userId);
    } catch (e) {
      debugPrint('Error expiring trial: $e');
    }
  }

  /// Send trial expired notification
  Future<void> _sendTrialExpiredNotification(String userId) async {
    try {
      await _firestore
          .collection('notifications')
          .add({
        'user_id': userId,
        'type': 'trial_expired',
        'title': 'Free Trial Expired',
        'message': 'Your 24-hour free trial has expired. Subscribe now to continue enjoying premium features!',
        'is_read': false,
        'created_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error sending trial expired notification: $e');
    }
  }

  /// Get precise trial time remaining
  Future<Duration?> getTrialTimeRemaining(String userId) async {
    try {
      final subscription = await _getCurrentSubscription(userId);
      if (subscription == null || subscription.trialEndsAt == null) {
        return null;
      }

      final now = DateTime.now();
      final trialEndsAt = subscription.trialEndsAt!;

      if (now.isAfter(trialEndsAt)) {
        return Duration.zero; // Trial has expired
      }

      return trialEndsAt.difference(now);
    } catch (e) {
      debugPrint('Error getting trial time remaining: $e');
      return null;
    }
  }

  /// Get trial progress percentage (0.0 to 1.0)
  Future<double> getTrialProgress(String userId) async {
    try {
      final subscription = await _getCurrentSubscription(userId);
      if (subscription == null || 
          subscription.trialStartedAt == null || 
          subscription.trialEndsAt == null) {
        return 0.0;
      }

      final now = DateTime.now();
      final trialStart = subscription.trialStartedAt!;
      final trialEnd = subscription.trialEndsAt!;
      final totalDuration = trialEnd.difference(trialStart);
      final elapsed = now.difference(trialStart);

      if (elapsed >= totalDuration) {
        return 1.0; // Trial completed
      }

      return elapsed.inMilliseconds / totalDuration.inMilliseconds;
    } catch (e) {
      debugPrint('Error getting trial progress: $e');
      return 0.0;
    }
  }

  /// Format trial time remaining as human-readable string
  String formatTrialTimeRemaining(Duration? duration) {
    if (duration == null || duration.isNegative) {
      return 'Trial Expired';
    }

    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s remaining';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s remaining';
    } else {
      return '${seconds}s remaining';
    }
  }

  /// Check if trial is about to expire (within 1 hour)
  Future<bool> isTrialAboutToExpire(String userId) async {
    try {
      final timeRemaining = await getTrialTimeRemaining(userId);
      if (timeRemaining == null) return false;

      return timeRemaining.inHours <= 1 && timeRemaining.inMinutes > 0;
    } catch (e) {
      debugPrint('Error checking if trial is about to expire: $e');
      return false;
    }
  }

  /// Get trial status with detailed information
  Future<TrialStatus> getTrialStatus(String userId) async {
    try {
      final subscription = await _getCurrentSubscription(userId);
      if (subscription == null) {
        return TrialStatus(
          isActive: false,
          timeRemaining: null,
          progress: 0.0,
          isExpired: false,
          isAboutToExpire: false,
        );
      }

      final timeRemaining = await getTrialTimeRemaining(userId);
      final progress = await getTrialProgress(userId);
      final isAboutToExpire = await isTrialAboutToExpire(userId);

      return TrialStatus(
        isActive: subscription.status == SubscriptionStatus.trial,
        timeRemaining: timeRemaining,
        progress: progress,
        isExpired: subscription.status == SubscriptionStatus.trialExpired,
        isAboutToExpire: isAboutToExpire,
      );
    } catch (e) {
      debugPrint('Error getting trial status: $e');
      return TrialStatus(
        isActive: false,
        timeRemaining: null,
        progress: 0.0,
        isExpired: false,
        isAboutToExpire: false,
      );
    }
  }

  /// Dispose resources
  void dispose() {
    stopTrialMonitoring();
  }
}

/// Trial Status Model
class TrialStatus {
  final bool isActive;
  final Duration? timeRemaining;
  final double progress;
  final bool isExpired;
  final bool isAboutToExpire;

  TrialStatus({
    required this.isActive,
    this.timeRemaining,
    required this.progress,
    required this.isExpired,
    required this.isAboutToExpire,
  });

  String get formattedTimeRemaining {
    if (timeRemaining == null) return 'Unknown';
    
    final hours = timeRemaining!.inHours;
    final minutes = timeRemaining!.inMinutes % 60;
    final seconds = timeRemaining!.inSeconds % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  String get statusText {
    if (isExpired) return 'Trial Expired';
    if (isAboutToExpire) return 'Trial Expiring Soon';
    if (isActive) return 'Trial Active';
    return 'No Trial';
  }
}
















































