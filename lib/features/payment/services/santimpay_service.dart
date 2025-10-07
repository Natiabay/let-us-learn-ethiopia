import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:tourist_assistive_app/core/config/environment_config.dart';

/// SantimPay API Service for Ethiopian payment processing
class SantimPayService {
  static const String _baseUrl = 'https://api.santimpay.com/v1';
  
  // Get API keys from environment config
  String get _merchantId => EnvironmentConfig.getSantimpayKey();
  String get _merchantKey => EnvironmentConfig.getSantimpayKey();
  
  // Payment phone number
  static const String _paymentPhoneNumber = '+251972217121';

  /// Initialize payment with SantimPay
  Future<SantimPayResponse> initializePayment({
    required double amount,
    required String currency,
    required String customerPhone,
    required String description,
    required String orderId,
  }) async {
    try {
      final requestBody = {
        'merchant_id': _merchantId,
        'merchant_key': _merchantKey,
        'amount': amount.toString(),
        'currency': currency,
        'customer_phone': customerPhone,
        'description': description,
        'order_id': orderId,
        'callback_url': 'https://touristassistant.ethiopia.com/payment/callback',
        'return_url': 'https://touristassistant.ethiopia.com/payment/success',
      };

      debugPrint('SantimPay Payment Request: $requestBody');

      final response = await http.post(
        Uri.parse('$_baseUrl/payments/initialize'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('SantimPay Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return SantimPayResponse.fromJson(responseData);
      } else {
        throw SantimPayException(
          'Payment initialization failed: ${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      debugPrint('SantimPay Error: $e');
      throw SantimPayException('Network error: $e', '');
    }
  }

  /// Check payment status
  Future<SantimPayStatusResponse> checkPaymentStatus(String transactionId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/payments/$transactionId/status'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_merchantKey',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return SantimPayStatusResponse.fromJson(responseData);
      } else {
        throw SantimPayException(
          'Status check failed: ${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      debugPrint('SantimPay Status Check Error: $e');
      throw SantimPayException('Status check error: $e', '');
    }
  }

  /// Verify payment callback
  Future<bool> verifyPaymentCallback(Map<String, dynamic> callbackData) async {
    try {
      // Verify the callback signature and data integrity
      final expectedSignature = _generateSignature(callbackData);
      final receivedSignature = callbackData['signature'] as String?;
      
      if (expectedSignature != receivedSignature) {
        debugPrint('SantimPay callback signature verification failed');
        return false;
      }

      return true;
    } catch (e) {
      debugPrint('SantimPay callback verification error: $e');
      return false;
    }
  }

  /// Generate signature for verification
  String _generateSignature(Map<String, dynamic> data) {
    // Implement signature generation based on SantimPay documentation
    // This is a simplified version - implement according to actual API specs
    final sortedKeys = data.keys.toList()..sort();
    final signatureString = sortedKeys
        .map((key) => '$key=${data[key]}')
        .join('&');
    
    // Add merchant key and hash
    return '${signatureString}&key=$_merchantKey'.hashCode.toString();
  }

  /// Get payment methods available
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

  /// Get payment phone number
  String get paymentPhoneNumber => _paymentPhoneNumber;
}

/// SantimPay Response Model
class SantimPayResponse {
  final bool success;
  final String? transactionId;
  final String? paymentUrl;
  final String? qrCode;
  final String? message;
  final String? error;

  SantimPayResponse({
    required this.success,
    this.transactionId,
    this.paymentUrl,
    this.qrCode,
    this.message,
    this.error,
  });

  factory SantimPayResponse.fromJson(Map<String, dynamic> json) {
    return SantimPayResponse(
      success: json['success'] ?? false,
      transactionId: json['transaction_id'],
      paymentUrl: json['payment_url'],
      qrCode: json['qr_code'],
      message: json['message'],
      error: json['error'],
    );
  }
}

/// SantimPay Status Response Model
class SantimPayStatusResponse {
  final String status;
  final String? transactionId;
  final double? amount;
  final String? currency;
  final String? message;

  SantimPayStatusResponse({
    required this.status,
    this.transactionId,
    this.amount,
    this.currency,
    this.message,
  });

  factory SantimPayStatusResponse.fromJson(Map<String, dynamic> json) {
    return SantimPayStatusResponse(
      status: json['status'] ?? 'unknown',
      transactionId: json['transaction_id'],
      amount: json['amount']?.toDouble(),
      currency: json['currency'],
      message: json['message'],
    );
  }

  bool get isCompleted => status == 'completed' || status == 'success';
  bool get isPending => status == 'pending' || status == 'processing';
  bool get isFailed => status == 'failed' || status == 'cancelled';
}

/// SantimPay Exception
class SantimPayException implements Exception {
  final String message;
  final String details;

  SantimPayException(this.message, this.details);

  @override
  String toString() => 'SantimPayException: $message';
}

/// Payment Method Model
class PaymentMethod {
  final String id;
  final String name;
  final String description;
  final String icon;
  final bool isAvailable;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.isAvailable,
  });
}

