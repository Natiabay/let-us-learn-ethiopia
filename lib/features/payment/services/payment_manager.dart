import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist_assistive_app/features/payment/services/santimpay_service.dart';
import 'package:tourist_assistive_app/features/payment/services/telebirr_service.dart';
import 'package:tourist_assistive_app/features/subscription/models/subscription_model.dart';

/// Comprehensive Payment Manager for handling all payment operations
class PaymentManager {
  final SantimPayService _santimPayService = SantimPayService();
  final TelebirrService _telebirrService = TelebirrService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Payment phone number for both services
  static const String paymentPhoneNumber = '+251972217121';

  /// Initialize payment with selected method
  Future<PaymentResult> initializePayment({
    required PaymentMethodType method,
    required double amount,
    required String currency,
    required String description,
    required int subscriptionDays,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw PaymentException('User not authenticated');
      }

      final orderId = _generateOrderId();
      final customerPhone = user.phoneNumber ?? '';

      // Create payment record in Firestore
      await _createPaymentRecord(
        userId: user.uid,
        orderId: orderId,
        amount: amount,
        currency: currency,
        method: method,
        description: description,
        subscriptionDays: subscriptionDays,
      );

      PaymentResponse response;
      
      switch (method) {
        case PaymentMethodType.santimpay:
          final santimResponse = await _santimPayService.initializePayment(
            amount: amount,
            currency: currency,
            customerPhone: customerPhone,
            description: description,
            orderId: orderId,
          );
          response = santimResponse.toPaymentResponse();
          break;
        case PaymentMethodType.telebirr:
          final telebirrResponse = await _telebirrService.initializePayment(
            amount: amount,
            currency: currency,
            customerPhone: customerPhone,
            description: description,
            orderId: orderId,
          );
          response = telebirrResponse.toPaymentResponse();
          break;
      }

      if (response.success) {
        // Update payment record with transaction ID
        await _updatePaymentRecord(orderId, {
          'transaction_id': response.transactionId,
          'payment_url': response.paymentUrl,
          'qr_code': response.qrCode,
          'status': 'pending',
        });

        return PaymentResult(
          success: true,
          transactionId: response.transactionId,
          paymentUrl: response.paymentUrl,
          qrCode: response.qrCode,
          orderId: orderId,
          message: response.message ?? 'Payment initialized successfully',
        );
      } else {
        throw PaymentException(response.error ?? 'Payment initialization failed');
      }
    } catch (e) {
      debugPrint('Payment initialization error: $e');
      return PaymentResult(
        success: false,
        error: e.toString(),
        message: 'Payment initialization failed',
      );
    }
  }

  /// Check payment status
  Future<PaymentStatusResult> checkPaymentStatus(String transactionId) async {
    try {
      // Get payment record from Firestore
      final paymentRecord = await _getPaymentRecord(transactionId);
      if (paymentRecord == null) {
        throw PaymentException('Payment record not found');
      }

      final method = PaymentMethodType.values.firstWhere(
        (m) => m.name == paymentRecord['method'],
        orElse: () => PaymentMethodType.telebirr,
      );

      PaymentStatusResponse statusResponse;
      
      switch (method) {
        case PaymentMethodType.santimpay:
          final santimStatusResponse = await _santimPayService.checkPaymentStatus(transactionId);
          statusResponse = santimStatusResponse.toPaymentStatusResponse();
          break;
        case PaymentMethodType.telebirr:
          final telebirrStatusResponse = await _telebirrService.checkPaymentStatus(transactionId);
          statusResponse = telebirrStatusResponse.toPaymentStatusResponse();
          break;
      }

      // Update payment record with new status
      await _updatePaymentRecord(paymentRecord['order_id'], {
        'status': statusResponse.status,
        'last_checked': FieldValue.serverTimestamp(),
      });

      // If payment is completed, activate subscription
      if (statusResponse.isCompleted) {
        await _activateSubscriptionAfterPayment(paymentRecord);
      }

      return PaymentStatusResult(
        status: statusResponse.status,
        isCompleted: statusResponse.isCompleted,
        isPending: statusResponse.isPending,
        isFailed: statusResponse.isFailed,
        message: statusResponse.message,
      );
    } catch (e) {
      debugPrint('Payment status check error: $e');
      return PaymentStatusResult(
        status: 'error',
        isCompleted: false,
        isPending: false,
        isFailed: true,
        message: e.toString(),
      );
    }
  }

  /// Handle payment callback
  Future<bool> handlePaymentCallback(Map<String, dynamic> callbackData) async {
    try {
      final transactionId = callbackData['transaction_id'] as String?;
      if (transactionId == null) {
        debugPrint('No transaction ID in callback');
        return false;
      }

      // Get payment record
      final paymentRecord = await _getPaymentRecord(transactionId);
      if (paymentRecord == null) {
        debugPrint('Payment record not found for transaction: $transactionId');
        return false;
      }

      final method = PaymentMethodType.values.firstWhere(
        (m) => m.name == paymentRecord['method'],
        orElse: () => PaymentMethodType.telebirr,
      );

      // Verify callback
      bool isValid;
      switch (method) {
        case PaymentMethodType.santimpay:
          isValid = await _santimPayService.verifyPaymentCallback(callbackData);
          break;
        case PaymentMethodType.telebirr:
          isValid = await _telebirrService.verifyPaymentCallback(callbackData);
          break;
      }

      if (!isValid) {
        debugPrint('Payment callback verification failed');
        return false;
      }

      // Update payment status
      final status = callbackData['status'] as String? ?? 'completed';
      await _updatePaymentRecord(paymentRecord['order_id'], {
        'status': status,
        'callback_data': callbackData,
        'completed_at': FieldValue.serverTimestamp(),
      });

      // Activate subscription if payment is successful
      if (status == 'completed' || status == 'success') {
        await _activateSubscriptionAfterPayment(paymentRecord);
      }

      return true;
    } catch (e) {
      debugPrint('Payment callback handling error: $e');
      return false;
    }
  }

  /// Get available payment methods
  List<PaymentMethod> getAvailablePaymentMethods() {
    return [
        PaymentMethod(
          id: 'santimpay',
          name: 'SantimPay',
          description: 'Pay with SantimPay mobile money',
          icon: 'assets/icons/santimpay.png',
          isAvailable: true,
        ),
        PaymentMethod(
          id: 'telebirr',
          name: 'Telebirr',
          description: 'Pay with Telebirr mobile money',
          icon: 'assets/icons/telebirr.png',
          isAvailable: true,
        ),
    ];
  }

  /// Get subscription pricing
  Map<String, double> getSubscriptionPricing() {
    return {
      '1_day': 50.0,    // 50 ETB for 1 day
      '7_days': 300.0,  // 300 ETB for 7 days
      '30_days': 1000.0, // 1000 ETB for 30 days
      '90_days': 2500.0, // 2500 ETB for 90 days
    };
  }

  /// Create payment record in Firestore
  Future<Map<String, dynamic>> _createPaymentRecord({
    required String userId,
    required String orderId,
    required double amount,
    required String currency,
    required PaymentMethodType method,
    required String description,
    required int subscriptionDays,
  }) async {
    final paymentData = {
      'user_id': userId,
      'order_id': orderId,
      'amount': amount,
      'currency': currency,
      'method': method.name,
      'description': description,
      'subscription_days': subscriptionDays,
      'status': 'pending',
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };

    await _firestore
        .collection('payments')
        .doc(orderId)
        .set(paymentData);

    return paymentData;
  }

  /// Update payment record
  Future<void> _updatePaymentRecord(String orderId, Map<String, dynamic> updates) async {
    await _firestore
        .collection('payments')
        .doc(orderId)
        .update({
      ...updates,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  /// Get payment record
  Future<Map<String, dynamic>?> _getPaymentRecord(String transactionId) async {
    final query = await _firestore
        .collection('payments')
        .where('transaction_id', isEqualTo: transactionId)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return query.docs.first.data();
    }
    return null;
  }

  /// Activate subscription after successful payment
  Future<void> _activateSubscriptionAfterPayment(Map<String, dynamic> paymentRecord) async {
    try {
      final userId = paymentRecord['user_id'] as String;
      final subscriptionDays = paymentRecord['subscription_days'] as int;
      final amount = paymentRecord['amount'] as double;
      final method = paymentRecord['method'] as String;

      // Update subscription in Firestore
      final now = DateTime.now();
      final paidUntil = now.add(Duration(days: subscriptionDays));

      await _firestore
          .collection('subscriptions')
          .doc(userId)
          .update({
        'status': SubscriptionStatus.premium.name,
        'paid_until': Timestamp.fromDate(paidUntil),
        'payment_method': method,
        'last_payment_amount': amount,
        'last_payment_date': Timestamp.fromDate(now),
        'updated_at': FieldValue.serverTimestamp(),
      });

      debugPrint('✅ Subscription activated for user $userId until $paidUntil');
    } catch (e) {
      debugPrint('Error activating subscription: $e');
      rethrow;
    }
  }

  /// Generate unique order ID
  String _generateOrderId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp % 10000).toString().padLeft(4, '0');
    return 'TA_${timestamp}_$random';
  }
}

/// Payment Method Types
enum PaymentMethodType {
  santimpay,
  telebirr,
}

/// Payment Result
class PaymentResult {
  final bool success;
  final String? transactionId;
  final String? paymentUrl;
  final String? qrCode;
  final String? orderId;
  final String? error;
  final String message;

  PaymentResult({
    required this.success,
    this.transactionId,
    this.paymentUrl,
    this.qrCode,
    this.orderId,
    this.error,
    required this.message,
  });
}

/// Payment Status Result
class PaymentStatusResult {
  final String status;
  final bool isCompleted;
  final bool isPending;
  final bool isFailed;
  final String? message;

  PaymentStatusResult({
    required this.status,
    required this.isCompleted,
    required this.isPending,
    required this.isFailed,
    this.message,
  });
}

/// Payment Response (common interface)
abstract class PaymentResponse {
  bool get success;
  String? get transactionId;
  String? get paymentUrl;
  String? get qrCode;
  String? get message;
  String? get error;
}

/// Payment Status Response (common interface)
abstract class PaymentStatusResponse {
  String get status;
  String? get transactionId;
  double? get amount;
  String? get currency;
  String? get message;
  bool get isCompleted;
  bool get isPending;
  bool get isFailed;
}

/// Make SantimPayResponse implement PaymentResponse
extension SantimPayResponseExtension on SantimPayResponse {
  PaymentResponse toPaymentResponse() => _PaymentResponseWrapper(this);
}

/// Make TelebirrResponse implement PaymentResponse
extension TelebirrResponseExtension on TelebirrResponse {
  PaymentResponse toPaymentResponse() => _PaymentResponseWrapper(this);
}

/// Make SantimPayStatusResponse implement PaymentStatusResponse
extension SantimPayStatusResponseExtension on SantimPayStatusResponse {
  PaymentStatusResponse toPaymentStatusResponse() => _PaymentStatusResponseWrapper(this);
}

/// Make TelebirrStatusResponse implement PaymentStatusResponse
extension TelebirrStatusResponseExtension on TelebirrStatusResponse {
  PaymentStatusResponse toPaymentStatusResponse() => _PaymentStatusResponseWrapper(this);
}

/// Wrapper class for PaymentResponse
class _PaymentResponseWrapper implements PaymentResponse {
  final dynamic _response;
  
  _PaymentResponseWrapper(this._response);
  
  @override
  bool get success => _response.success;
  
  @override
  String? get transactionId => _response.transactionId;
  
  @override
  String? get paymentUrl => _response.paymentUrl;
  
  @override
  String? get qrCode => _response.qrCode;
  
  @override
  String? get message => _response.message;
  
  @override
  String? get error => _response.error;
}

/// Wrapper class for PaymentStatusResponse
class _PaymentStatusResponseWrapper implements PaymentStatusResponse {
  final dynamic _response;
  
  _PaymentStatusResponseWrapper(this._response);
  
  @override
  String get status => _response.status;
  
  @override
  String? get transactionId => _response.transactionId;
  
  @override
  double? get amount => _response.amount;
  
  @override
  String? get currency => _response.currency;
  
  @override
  String? get message => _response.message;
  
  @override
  bool get isCompleted => _response.isCompleted;
  
  @override
  bool get isPending => _response.isPending;
  
  @override
  bool get isFailed => _response.isFailed;
}

/// Payment Exception
class PaymentException implements Exception {
  final String message;

  PaymentException(this.message);

  @override
  String toString() => 'PaymentException: $message';
}

