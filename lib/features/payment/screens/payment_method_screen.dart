import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/payment/services/payment_manager.dart';
import 'package:tourist_assistive_app/features/payment/providers/payment_provider.dart';
import 'package:tourist_assistive_app/features/subscription/services/trial_service.dart';

class PaymentMethodScreen extends ConsumerStatefulWidget {
  final String? selectedPlan;
  
  const PaymentMethodScreen({super.key, this.selectedPlan});

  @override
  ConsumerState<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends ConsumerState<PaymentMethodScreen> {
  PaymentMethodType? _selectedMethod;
  late String _selectedPlan;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _selectedPlan = widget.selectedPlan ?? 'unlimited';
  }

  final Map<String, Map<String, dynamic>> _subscriptionPlans = {
    'unlimited': {
      'name': 'Premium Unlimited',
      'price': 300.0,
      'currency': 'ETB',
      'description': 'One-time payment for lifetime access',
      'days': -1, // -1 indicates unlimited
    },
    '1_week': {
      'name': '1 Week Access',
      'price': 100.0,
      'currency': 'ETB',
      'description': 'Perfect for short visits',
      'days': 7,
    },
    '1_month': {
      'name': '1 Month Access',
      'price': 200.0,
      'currency': 'ETB',
      'description': 'Great for extended stays',
      'days': 30,
    },
    '1_day': {
      'name': '1 Day Access',
      'price': 50.0,
      'currency': 'ETB',
      'description': 'Perfect for a quick visit',
      'days': 1,
    },
    '90_days': {
      'name': '3 Months Access',
      'price': 2500.0,
      'currency': 'ETB',
      'description': 'Ultimate Ethiopian experience',
      'days': 90,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Payment Method'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.secondary,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Payment Phone Number Info
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.phone_android,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Payment Number',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '+251 97 221 7121',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Send payment to this number using SantimPay or Telebirr',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Subscription Plans
                const Text(
                  'Choose Your Plan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                ..._subscriptionPlans.entries.map((entry) {
                  final plan = entry.value;
                  final isSelected = _selectedPlan == entry.key;
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedPlan = entry.key;
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? Colors.white 
                                : Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected 
                                  ? AppColors.primary 
                                  : Colors.white.withValues(alpha: 0.2),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected 
                                      ? AppColors.primary 
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: isSelected 
                                        ? AppColors.primary 
                                        : Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plan['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected 
                                            ? AppColors.primary 
                                            : Colors.white,
                                      ),
                                    ),
                                    Text(
                                      plan['description'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isSelected 
                                            ? AppColors.primary.withValues(alpha: 0.7)
                                            : Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${plan['price']} ${plan['currency']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected 
                                      ? AppColors.primary 
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 24),

                // Payment Methods
                const Text(
                  'Select Payment Method',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // SantimPay Option
                _buildPaymentMethodCard(
                  title: 'SantimPay',
                  subtitle: 'Pay with SantimPay mobile money',
                  icon: Icons.account_balance_wallet,
                  method: PaymentMethodType.santimpay,
                  color: const Color(0xFF4CAF50),
                ),

                const SizedBox(height: 12),

                // Telebirr Option
                _buildPaymentMethodCard(
                  title: 'Telebirr',
                  subtitle: 'Pay with Telebirr mobile money',
                  icon: Icons.phone_android,
                  method: PaymentMethodType.telebirr,
                  color: const Color(0xFF2196F3),
                ),

                const SizedBox(height: 32),

                // Pay Now Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      elevation: 8,
                      shadowColor: Colors.black.withValues(alpha: 0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _canProceed() ? _processPayment : null,
                    child: _isProcessing
                        ? const CircularProgressIndicator(
                            color: AppColors.primary,
                          )
                        : Text(
                            'Pay ${_subscriptionPlans[_selectedPlan]!['price']} ${_subscriptionPlans[_selectedPlan]!['currency']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 16),

                // Payment Instructions
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment Instructions:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '1. Select your preferred payment method\n'
                        '2. Click "Pay Now" to generate payment details\n'
                        '3. Send the exact amount to +251 97 221 7121\n'
                        '4. Your subscription will be activated automatically',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required PaymentMethodType method,
    required Color color,
  }) {
    final isSelected = _selectedMethod == method;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedMethod = method;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected 
                ? Colors.white 
                : Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected 
                  ? color 
                  : Colors.white.withValues(alpha: 0.2),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected 
                      ? color 
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected 
                        ? color 
                        : Colors.white,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? color : Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected 
                            ? AppColors.primary 
                            : Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected 
                            ? AppColors.primary.withValues(alpha: 0.7)
                            : Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _canProceed() {
    return _selectedMethod != null && !_isProcessing;
  }

  Future<void> _processPayment() async {
    if (_selectedMethod == null) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final plan = _subscriptionPlans[_selectedPlan]!;
      final paymentManager = ref.read(paymentManagerProvider);

      final result = await paymentManager.initializePayment(
        method: _selectedMethod!,
        amount: plan['price'].toDouble(),
        currency: plan['currency'],
        description: 'Tourist Assistant - ${plan['name']}',
        subscriptionDays: plan['days'],
      );

      if (result.success) {
        // If it's the unlimited plan, mark user as paid
        if (plan['days'] == -1) {
          await TrialService.markAsPaid();
        }
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment initialized! ${result.message}'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to payment status screen
          context.go('/payment/status/${result.transactionId}');
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment failed: ${result.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }
}



















