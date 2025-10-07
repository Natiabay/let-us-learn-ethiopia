import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:tourist_assistive_app/core/config/environment_config.dart';

/// Telebirr API Service for Ethiopian payment processing
class TelebirrService {
  static const String _baseUrl = 'https://api.telebirr.com/v1';
  
  // Get API keys from environment config
  String get _merchantId => EnvironmentConfig.getTelebirrKey();
  String get _merchantKey => EnvironmentConfig.getTelebirrKey();
  
  // Payment phone number
  static const String _paymentPhoneNumber = '+251972217121';

  /// Initialize payment with Telebirr
  Future<TelebirrResponse> initializePayment({
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
        'payment_method': 'telebirr',
      };

      debugPrint('Telebirr Payment Request: $requestBody');

      final response = await http.post(
        Uri.parse('$_baseUrl/payments/initialize'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('Telebirr Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return TelebirrResponse.fromJson(responseData);
        } else {
        throw TelebirrException(
          'Payment initialization failed: ${response.statusCode}',
          response.body,
        );
      }
      } catch (e) {
      debugPrint('Telebirr Error: $e');
      throw TelebirrException('Network error: $e', '');
    }
  }

  /// Check payment status
  Future<TelebirrStatusResponse> checkPaymentStatus(String transactionId) async {
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
        return TelebirrStatusResponse.fromJson(responseData);
      } else {
        throw TelebirrException(
          'Status check failed: ${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      debugPrint('Telebirr Status Check Error: $e');
      throw TelebirrException('Status check error: $e', '');
    }
  }

  /// Verify payment callback
  Future<bool> verifyPaymentCallback(Map<String, dynamic> callbackData) async {
    try {
      // Verify the callback signature and data integrity
      final expectedSignature = _generateSignature(callbackData);
      final receivedSignature = callbackData['signature'] as String?;
      
      if (expectedSignature != receivedSignature) {
        debugPrint('Telebirr callback signature verification failed');
      return false;
      }

      return true;
    } catch (e) {
      debugPrint('Telebirr callback verification error: $e');
      return false;
    }
  }

  /// Generate signature for verification
  String _generateSignature(Map<String, dynamic> data) {
    // Implement signature generation based on Telebirr documentation
    // This is a simplified version - implement according to actual API specs
    final sortedKeys = data.keys.toList()..sort();
    final signatureString = sortedKeys
        .map((key) => '$key=${data[key]}')
        .join('&');
    
    // Add merchant key and hash
    return '${signatureString}&key=$_merchantKey'.hashCode.toString();
  }

  /// Get payment phone number
  String get paymentPhoneNumber => _paymentPhoneNumber;

  /// Get supported currencies
  List<String> getSupportedCurrencies() {
    return ['ETB', 'USD'];
  }

  /// Get minimum and maximum payment amounts
  Map<String, double> getPaymentLimits() {
    return {
      'min_amount': 1.0,
      'max_amount': 100000.0,
    };
  }
}

/// Telebirr Response Model
class TelebirrResponse {
  final bool success;
  final String? transactionId;
  final String? paymentUrl;
  final String? qrCode;
  final String? message;
  final String? error;

  TelebirrResponse({
    required this.success,
    this.transactionId,
    this.paymentUrl,
    this.qrCode,
    this.message,
    this.error,
  });

  factory TelebirrResponse.fromJson(Map<String, dynamic> json) {
    return TelebirrResponse(
      success: json['success'] ?? false,
      transactionId: json['transaction_id'],
      paymentUrl: json['payment_url'],
      qrCode: json['qr_code'],
      message: json['message'],
      error: json['error'],
    );
  }
}

/// Telebirr Status Response Model
class TelebirrStatusResponse {
  final String status;
  final String? transactionId;
  final double? amount;
  final String? currency;
  final String? message;

  TelebirrStatusResponse({
    required this.status,
    this.transactionId,
    this.amount,
    this.currency,
    this.message,
  });

  factory TelebirrStatusResponse.fromJson(Map<String, dynamic> json) {
    return TelebirrStatusResponse(
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

/// Telebirr Exception
class TelebirrException implements Exception {
  final String message;
  final String details;

  TelebirrException(this.message, this.details);

  @override
  String toString() => 'TelebirrException: $message';
}