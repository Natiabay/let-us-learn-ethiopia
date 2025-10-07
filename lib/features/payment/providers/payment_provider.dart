import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/features/payment/services/payment_manager.dart';
import 'package:tourist_assistive_app/features/payment/services/santimpay_service.dart';
import 'package:tourist_assistive_app/features/payment/services/telebirr_service.dart';

// Payment Manager Provider
final paymentManagerProvider = Provider<PaymentManager>((ref) {
  return PaymentManager();
});

// SantimPay Service Provider
final santimPayServiceProvider = Provider<SantimPayService>((ref) {
  return SantimPayService();
});

// Telebirr Service Provider
final telebirrServiceProvider = Provider<TelebirrService>((ref) {
  return TelebirrService();
});

// Payment Status Provider
final paymentStatusProvider = StreamProvider.family<PaymentStatusResult?, String>((ref, transactionId) {
  final paymentManager = ref.watch(paymentManagerProvider);
  
  return Stream.periodic(const Duration(seconds: 5), (_) async {
    return await paymentManager.checkPaymentStatus(transactionId);
  }).asyncMap((event) => event);
});

// Available Payment Methods Provider
final availablePaymentMethodsProvider = Provider<List<PaymentMethod>>((ref) {
  final paymentManager = ref.watch(paymentManagerProvider);
  return paymentManager.getAvailablePaymentMethods();
});

// Subscription Pricing Provider
final subscriptionPricingProvider = Provider<Map<String, double>>((ref) {
  final paymentManager = ref.watch(paymentManagerProvider);
  return paymentManager.getSubscriptionPricing();
});

// Payment Phone Number Provider
final paymentPhoneNumberProvider = Provider<String>((ref) {
  return PaymentManager.paymentPhoneNumber;
});