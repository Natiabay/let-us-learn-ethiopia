import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionModel {
  final String userId;
  final SubscriptionStatus status;
  final DateTime createdAt;
  final DateTime? trialStartedAt;
  final DateTime? trialEndsAt;
  final DateTime? paidUntil;
  final String? paymentMethod;
  final double? lastPaymentAmount;

  SubscriptionModel({
    required this.userId,
    required this.status,
    required this.createdAt,
    this.trialStartedAt,
    this.trialEndsAt,
    this.paidUntil,
    this.paymentMethod,
    this.lastPaymentAmount,
  });

  factory SubscriptionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return SubscriptionModel(
      userId: doc.id,
      status: SubscriptionStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => SubscriptionStatus.trial,
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      trialStartedAt: data['trialStartedAt'] != null 
          ? (data['trialStartedAt'] as Timestamp).toDate() 
          : null,
      trialEndsAt: data['trialEndsAt'] != null 
          ? (data['trialEndsAt'] as Timestamp).toDate() 
          : null,
      paidUntil: data['paidUntil'] != null 
          ? (data['paidUntil'] as Timestamp).toDate() 
          : null,
      paymentMethod: data['paymentMethod'],
      lastPaymentAmount: data['lastPaymentAmount']?.toDouble(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'status': status.name,
      'createdAt': Timestamp.fromDate(createdAt),
      'trialStartedAt': trialStartedAt != null 
          ? Timestamp.fromDate(trialStartedAt!) 
          : null,
      'trialEndsAt': trialEndsAt != null 
          ? Timestamp.fromDate(trialEndsAt!) 
          : null,
      'paidUntil': paidUntil != null 
          ? Timestamp.fromDate(paidUntil!) 
          : null,
      'paymentMethod': paymentMethod,
      'lastPaymentAmount': lastPaymentAmount,
    };
  }

  bool get isTrialActive {
    if (status != SubscriptionStatus.trial || trialEndsAt == null) {
      return false;
    }
    return DateTime.now().isBefore(trialEndsAt!);
  }

  bool get isPremiumActive {
    return status == SubscriptionStatus.premium && 
           paidUntil != null && 
           DateTime.now().isBefore(paidUntil!);
  }

  bool get hasAccess {
    return isTrialActive || isPremiumActive;
  }

  Duration? get trialTimeLeft {
    if (!isTrialActive || trialEndsAt == null) return null;
    final remaining = trialEndsAt!.difference(DateTime.now());
    return remaining.isNegative ? null : remaining;
  }

  SubscriptionModel copyWith({
    SubscriptionStatus? status,
    DateTime? trialStartedAt,
    DateTime? trialEndsAt,
    DateTime? paidUntil,
    String? paymentMethod,
    double? lastPaymentAmount,
  }) {
    return SubscriptionModel(
      userId: userId,
      status: status ?? this.status,
      createdAt: createdAt,
      trialStartedAt: trialStartedAt ?? this.trialStartedAt,
      trialEndsAt: trialEndsAt ?? this.trialEndsAt,
      paidUntil: paidUntil ?? this.paidUntil,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      lastPaymentAmount: lastPaymentAmount ?? this.lastPaymentAmount,
    );
  }
}

enum SubscriptionStatus {
  trial,
  trialExpired,
  premium,
  expired,
  cancelled,
}
