import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:tourist_assistive_app/core/config/environment_config.dart';

/// Telebirr Payment Service for H5 payment integration
class TelebirrService {
  static const String _baseUrl = 'https://api.telebirr.com';
  static const String _h5BaseUrl = 'https://h5.telebirr.com';
  
  /// Create a payment request
  static Future<Map<String, dynamic>?> createPayment({
    required String amount,
    required String currency,
    required String orderId,
    required String description,
    required String customerPhone,
    required String customerName,
    String? returnUrl,
    String? cancelUrl,
  }) async {
    try {
      final apiKey = EnvironmentConfig.getTelebirrKey();
      if (apiKey.isEmpty || apiKey.contains('dev-')) {
        // Development mode - return mock payment URL
        return _createMockPayment(amount, orderId, description);
      }
      
      // Real Telebirr API integration
      final response = await http.post(
        Uri.parse('$_baseUrl/v1/payments/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
          'X-Merchant-ID': 'your-merchant-id', // Replace with actual merchant ID
        },
        body: jsonEncode({
          'amount': amount,
          'currency': currency,
          'order_id': orderId,
          'description': description,
          'customer_phone': customerPhone,
          'customer_name': customerName,
          'return_url': returnUrl ?? 'https://your-app.com/payment/success',
          'cancel_url': cancelUrl ?? 'https://your-app.com/payment/cancel',
          'notify_url': 'https://your-backend.com/webhook/telebirr',
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return {
            'success': true,
            'payment_url': data['payment_url'],
            'transaction_id': data['transaction_id'],
            'order_id': orderId,
          };
        } else {
          debugPrint('Telebirr payment creation failed: ${data['message']}');
          return {
            'success': false,
            'error': data['message'] ?? 'Payment creation failed',
          };
        }
      } else {
        debugPrint('Telebirr API error: ${response.statusCode}');
        return {
          'success': false,
          'error': 'API request failed with status ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint('Telebirr payment creation error: $e');
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }
  
  /// Create mock payment for development
  static Map<String, dynamic> _createMockPayment(String amount, String orderId, String description) {
    return {
      'success': true,
      'payment_url': 'https://mock-telebirr.com/payment?order_id=$orderId&amount=$amount',
      'transaction_id': 'mock_${DateTime.now().millisecondsSinceEpoch}',
      'order_id': orderId,
      'is_mock': true,
    };
  }
  
  /// Launch payment URL in browser or WebView
  static Future<bool> launchPaymentUrl(String paymentUrl) async {
    try {
      final uri = Uri.parse(paymentUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        return true;
      } else {
        debugPrint('Cannot launch payment URL: $paymentUrl');
        return false;
      }
    } catch (e) {
      debugPrint('Error launching payment URL: $e');
      return false;
    }
  }
  
  /// Verify payment status
  static Future<Map<String, dynamic>?> verifyPayment({
    required String transactionId,
    required String orderId,
  }) async {
    try {
      final apiKey = EnvironmentConfig.getTelebirrKey();
      if (apiKey.isEmpty || apiKey.contains('dev-')) {
        // Development mode - return mock verification
        return _createMockVerification(transactionId, orderId);
      }
      
      // Real Telebirr API verification
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/payments/verify?transaction_id=$transactionId&order_id=$orderId'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'X-Merchant-ID': 'your-merchant-id', // Replace with actual merchant ID
        },
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'status': data['status'],
          'transaction_id': transactionId,
          'order_id': orderId,
          'amount': data['amount'],
          'currency': data['currency'],
          'payment_date': data['payment_date'],
        };
      } else {
        debugPrint('Telebirr verification error: ${response.statusCode}');
        return {
          'success': false,
          'error': 'Verification failed with status ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint('Telebirr payment verification error: $e');
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }
  
  /// Create mock verification for development
  static Map<String, dynamic> _createMockVerification(String transactionId, String orderId) {
    return {
      'success': true,
      'status': 'completed',
      'transaction_id': transactionId,
      'order_id': orderId,
      'amount': '100.00',
      'currency': 'ETB',
      'payment_date': DateTime.now().toIso8601String(),
      'is_mock': true,
    };
  }
  
  /// Get payment methods available
  static List<Map<String, dynamic>> getAvailablePaymentMethods() {
    return [
      {
        'id': 'telebirr',
        'name': 'Telebirr',
        'description': 'Pay with Telebirr mobile wallet',
        'icon': 'assets/icons/telebirr.png',
        'enabled': true,
      },
      {
        'id': 'telebirr_h5',
        'name': 'Telebirr H5',
        'description': 'Pay with Telebirr H5 web interface',
        'icon': 'assets/icons/telebirr_h5.png',
        'enabled': true,
      },
    ];
  }
  
  /// Get supported currencies
  static List<String> getSupportedCurrencies() {
    return ['ETB', 'USD'];
  }
  
  /// Get minimum and maximum payment amounts
  static Map<String, double> getPaymentLimits() {
    return {
      'min_amount': 1.0,
      'max_amount': 100000.0,
    };
  }
  
  /// Check if Telebirr is configured
  static bool get isConfigured {
    try {
      final apiKey = EnvironmentConfig.getTelebirrKey();
      return apiKey.isNotEmpty && !apiKey.contains('dev-');
    } catch (e) {
      return false;
    }
  }
  
  /// Get configuration status
  static String get configurationStatus {
    if (isConfigured) {
      return '✅ Telebirr configured with real API key';
    } else {
      return '🔄 Telebirr running in development mode';
    }
  }
  
  /// Get merchant information (for display)
  static Map<String, String> getMerchantInfo() {
    return {
      'merchant_name': 'Tourist Assistive App',
      'merchant_id': 'TA_001',
      'support_phone': '+251 97 221 7121',
      'support_email': 'support@touristassistiveapp.com',
    };
  }
  
  /// Format amount for display
  static String formatAmount(String amount, String currency) {
    try {
      final numAmount = double.parse(amount);
      return '${numAmount.toStringAsFixed(2)} $currency';
    } catch (e) {
      return '$amount $currency';
    }
  }
  
  /// Validate payment parameters
  static Map<String, dynamic> validatePaymentParams({
    required String amount,
    required String currency,
    required String orderId,
    required String description,
    required String customerPhone,
    required String customerName,
  }) {
    final errors = <String>[];
    
    // Validate amount
    try {
      final numAmount = double.parse(amount);
      if (numAmount <= 0) {
        errors.add('Amount must be greater than 0');
      }
      if (numAmount < 1.0) {
        errors.add('Minimum amount is 1.00 ETB');
      }
      if (numAmount > 100000.0) {
        errors.add('Maximum amount is 100,000.00 ETB');
      }
    } catch (e) {
      errors.add('Invalid amount format');
    }
    
    // Validate currency
    if (!getSupportedCurrencies().contains(currency)) {
      errors.add('Unsupported currency: $currency');
    }
    
    // Validate order ID
    if (orderId.isEmpty) {
      errors.add('Order ID is required');
    }
    
    // Validate description
    if (description.isEmpty) {
      errors.add('Description is required');
    }
    
    // Validate customer phone
    if (customerPhone.isEmpty) {
      errors.add('Customer phone is required');
    } else if (!_isValidEthiopianPhone(customerPhone)) {
      errors.add('Invalid Ethiopian phone number format');
    }
    
    // Validate customer name
    if (customerName.isEmpty) {
      errors.add('Customer name is required');
    }
    
    return {
      'is_valid': errors.isEmpty,
      'errors': errors,
    };
  }
  
  /// Validate Ethiopian phone number
  static bool _isValidEthiopianPhone(String phone) {
    // Remove any non-digit characters
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    
    // Check if it's a valid Ethiopian mobile number
    // Ethiopian mobile numbers start with 09 and are 10 digits long
    if (cleanPhone.length == 10 && cleanPhone.startsWith('09')) {
      return true;
    }
    
    // Check if it's a valid Ethiopian mobile number with country code
    // Ethiopian mobile numbers with country code start with 2519 and are 12 digits long
    if (cleanPhone.length == 12 && cleanPhone.startsWith('2519')) {
      return true;
    }
    
    return false;
  }
}
















































