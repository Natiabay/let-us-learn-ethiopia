import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:tourist_assistive_app/core/config/environment_config.dart';

/// SantimPay Payment Service for REST API integration
class SantimPayService {
  static const String _baseUrl = 'https://api.santimpay.com';
  static const String _sandboxUrl = 'https://sandbox.santimpay.com';
  
  /// Create a payment request
  static Future<Map<String, dynamic>?> createPayment({
    required String amount,
    required String currency,
    required String orderId,
    required String description,
    required String customerPhone,
    required String customerName,
    required String customerEmail,
    String? returnUrl,
    String? cancelUrl,
  }) async {
    try {
      final apiKey = EnvironmentConfig.getSantimpayKey();
      if (apiKey.isEmpty || apiKey.contains('dev-')) {
        // Development mode - return mock payment URL
        return _createMockPayment(amount, orderId, description);
      }
      
      // Real SantimPay API integration
      final response = await http.post(
        Uri.parse('$_baseUrl/v1/payments'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
          'X-API-Key': apiKey,
        },
        body: jsonEncode({
          'amount': amount,
          'currency': currency,
          'order_id': orderId,
          'description': description,
          'customer': {
            'phone': customerPhone,
            'name': customerName,
            'email': customerEmail,
          },
          'return_url': returnUrl ?? 'https://your-app.com/payment/success',
          'cancel_url': cancelUrl ?? 'https://your-app.com/payment/cancel',
          'webhook_url': 'https://your-backend.com/webhook/santimpay',
          'metadata': {
            'app_name': 'Tourist Assistive App',
            'app_version': '1.0.0',
          },
        }),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true || data['status'] == 'success') {
          return {
            'success': true,
            'payment_url': data['payment_url'] ?? data['checkout_url'],
            'transaction_id': data['transaction_id'] ?? data['id'],
            'order_id': orderId,
            'reference': data['reference'],
          };
        } else {
          debugPrint('SantimPay payment creation failed: ${data['message']}');
          return {
            'success': false,
            'error': data['message'] ?? 'Payment creation failed',
          };
        }
      } else {
        debugPrint('SantimPay API error: ${response.statusCode}');
        return {
          'success': false,
          'error': 'API request failed with status ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint('SantimPay payment creation error: $e');
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
      'payment_url': 'https://mock-santimpay.com/payment?order_id=$orderId&amount=$amount',
      'transaction_id': 'mock_${DateTime.now().millisecondsSinceEpoch}',
      'order_id': orderId,
      'reference': 'REF_${DateTime.now().millisecondsSinceEpoch}',
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
      final apiKey = EnvironmentConfig.getSantimpayKey();
      if (apiKey.isEmpty || apiKey.contains('dev-')) {
        // Development mode - return mock verification
        return _createMockVerification(transactionId, orderId);
      }
      
      // Real SantimPay API verification
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/payments/$transactionId'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'X-API-Key': apiKey,
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
          'payment_date': data['created_at'] ?? data['payment_date'],
          'reference': data['reference'],
        };
      } else {
        debugPrint('SantimPay verification error: ${response.statusCode}');
        return {
          'success': false,
          'error': 'Verification failed with status ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint('SantimPay payment verification error: $e');
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
      'reference': 'REF_${DateTime.now().millisecondsSinceEpoch}',
      'is_mock': true,
    };
  }
  
  /// Get payment methods available
  static List<Map<String, dynamic>> getAvailablePaymentMethods() {
    return [
      {
        'id': 'santimpay',
        'name': 'SantimPay',
        'description': 'Pay with SantimPay digital wallet',
        'icon': 'assets/icons/santimpay.png',
        'enabled': true,
      },
      {
        'id': 'santimpay_bank',
        'name': 'SantimPay Bank Transfer',
        'description': 'Pay with bank transfer via SantimPay',
        'icon': 'assets/icons/santimpay_bank.png',
        'enabled': true,
      },
      {
        'id': 'santimpay_mobile',
        'name': 'SantimPay Mobile Money',
        'description': 'Pay with mobile money via SantimPay',
        'icon': 'assets/icons/santimpay_mobile.png',
        'enabled': true,
      },
    ];
  }
  
  /// Get supported currencies
  static List<String> getSupportedCurrencies() {
    return ['ETB', 'USD', 'EUR'];
  }
  
  /// Get minimum and maximum payment amounts
  static Map<String, double> getPaymentLimits() {
    return {
      'min_amount': 1.0,
      'max_amount': 500000.0,
    };
  }
  
  /// Check if SantimPay is configured
  static bool get isConfigured {
    try {
      final apiKey = EnvironmentConfig.getSantimpayKey();
      return apiKey.isNotEmpty && !apiKey.contains('dev-');
    } catch (e) {
      return false;
    }
  }
  
  /// Get configuration status
  static String get configurationStatus {
    if (isConfigured) {
      return '✅ SantimPay configured with real API key';
    } else {
      return '🔄 SantimPay running in development mode';
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
    required String customerEmail,
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
      if (numAmount > 500000.0) {
        errors.add('Maximum amount is 500,000.00 ETB');
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
    
    // Validate customer email
    if (customerEmail.isEmpty) {
      errors.add('Customer email is required');
    } else if (!_isValidEmail(customerEmail)) {
      errors.add('Invalid email format');
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
  
  /// Validate email format
  static bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  /// Get transaction history (if supported by API)
  static Future<List<Map<String, dynamic>>> getTransactionHistory({
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final apiKey = EnvironmentConfig.getSantimpayKey();
      if (apiKey.isEmpty || apiKey.contains('dev-')) {
        // Development mode - return mock history
        return _getMockTransactionHistory();
      }
      
      // Real SantimPay API call for transaction history
      final response = await http.get(
        Uri.parse('$_baseUrl/v1/transactions?limit=$limit&offset=$offset'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'X-API-Key': apiKey,
        },
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['transactions'] ?? []);
      } else {
        debugPrint('SantimPay transaction history error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      debugPrint('SantimPay transaction history error: $e');
      return [];
    }
  }
  
  /// Get mock transaction history for development
  static List<Map<String, dynamic>> _getMockTransactionHistory() {
    return [
      {
        'id': 'mock_1',
        'amount': '50.00',
        'currency': 'ETB',
        'status': 'completed',
        'description': 'Tourist Assistive App Subscription',
        'created_at': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'reference': 'REF_001',
      },
      {
        'id': 'mock_2',
        'amount': '100.00',
        'currency': 'ETB',
        'status': 'completed',
        'description': 'Premium Features Access',
        'created_at': DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
        'reference': 'REF_002',
      },
    ];
  }
}
















































