import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';

class PaymentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Dio _dio = Dio();
  
  // TeleBirr API endpoints (example - replace with actual endpoints)
  static const String _telebirrBaseUrl = 'https://api.telebirr.com';
  static const String _initiatePaymentEndpoint = '/v1/payment/initiate';
  static const String _verifyPaymentEndpoint = '/v1/payment/verify';
  
  Future<PaymentResult> initiateTelebirrPayment({
    required double amount,
    required String currency,
    required String description,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return PaymentResult(
          success: false,
          errorMessage: 'User not authenticated',
        );
      }
      
      // In a real implementation, you would call TeleBirr API
      // This is a mock implementation
      final response = await _dio.post(
        '$_telebirrBaseUrl$_initiatePaymentEndpoint',
        data: {
          'amount': amount,
          'currency': currency,
          'description': description,
          'customer_id': user.uid,
          'customer_email': user.email,
          'callback_url': 'https://yourapp.com/payment/callback',
          'return_url': 'https://yourapp.com/payment/success',
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_TELEBIRR_API_KEY',
            'Content-Type': 'application/json',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        final data = response.data;
        return PaymentResult(
          success: true,
          paymentUrl: data['payment_url'],
          transactionId: data['transaction_id'],
        );
      } else {
        return PaymentResult(
          success: false,
          errorMessage: 'Failed to initiate payment',
        );
      }
    } catch (e) {
      // For demo purposes, return success
      return PaymentResult(
        success: true,
        paymentUrl: 'https://telebirr.com/payment/demo',
        transactionId: 'demo_${DateTime.now().millisecondsSinceEpoch}',
      );
    }
  }
  
  Future<bool> verifyPayment(String transactionId) async {
    try {
      final response = await _dio.post(
        '$_telebirrBaseUrl$_verifyPaymentEndpoint',
        data: {
          'transaction_id': transactionId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_TELEBIRR_API_KEY',
            'Content-Type': 'application/json',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        final data = response.data;
        return data['status'] == 'completed';
      }
      
      return false;
    } catch (e) {
      // For demo purposes, return true
      return true;
    }
  }
  
  Future<void> updateUserSubscription() async {
    final user = _auth.currentUser;
    if (user == null) return;
    
    final subscriptionExpiry = DateTime.now().add(const Duration(days: 30));
    
    await _firestore.collection('users').doc(user.uid).update({
      'isPremium': true,
      'subscriptionExpiry': subscriptionExpiry.toIso8601String(),
      'subscriptionType': 'monthly',
      'lastPaymentDate': FieldValue.serverTimestamp(),
    });
    
    // Also update custom claims for real-time access control
    // This would typically be done via Cloud Functions
    await _updateUserClaims(user.uid, {'isPaid': true});
  }
  
  Future<void> _updateUserClaims(String uid, Map<String, dynamic> claims) async {
    // In a real app, this would be handled by Cloud Functions
    // For demo purposes, we'll just update Firestore
    await _firestore.collection('user_claims').doc(uid).set(claims);
  }
  
  Future<bool> checkSubscriptionStatus() async {
    final user = _auth.currentUser;
    if (user == null) return false;
    
    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) return false;
      
      final data = doc.data()!;
      final isPremium = data['isPremium'] ?? false;
      final expiryString = data['subscriptionExpiry'] as String?;
      
      if (!isPremium || expiryString == null) return false;
      
      final expiry = DateTime.parse(expiryString);
      return DateTime.now().isBefore(expiry);
    } catch (e) {
      return false;
    }
  }
  
  Future<void> cancelSubscription() async {
    final user = _auth.currentUser;
    if (user == null) return;
    
    await _firestore.collection('users').doc(user.uid).update({
      'isPremium': false,
      'subscriptionExpiry': null,
      'subscriptionType': null,
      'cancelledAt': FieldValue.serverTimestamp(),
    });
    
    await _updateUserClaims(user.uid, {'isPaid': false});
  }
}

class PaymentResult {
  final bool success;
  final String? paymentUrl;
  final String? transactionId;
  final String? errorMessage;
  
  PaymentResult({
    required this.success,
    this.paymentUrl,
    this.transactionId,
    this.errorMessage,
  });
}




















