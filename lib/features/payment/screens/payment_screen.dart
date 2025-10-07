import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_assistive_app/features/subscription/providers/subscription_provider.dart';
import 'package:tourist_assistive_app/core/app_router.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  bool _isStartingTrial = false;

  /// Wait for subscription provider to update after starting trial
  Future<void> _waitForSubscriptionUpdate() async {
    int attempts = 0;
    const maxAttempts = 10;
    const delay = Duration(milliseconds: 500);

    while (attempts < maxAttempts) {
      final trialStatus = ref.read(trialStatusProvider);
      
      final trialData = trialStatus.when(
        data: (data) => data,
        loading: () => {'hasAccess': false},
        error: (_, __) => {'hasAccess': false},
      );
      
      final hasAccess = trialData['hasAccess'] ?? false;
      
      if (hasAccess) {
        print('✅ Subscription updated successfully');
        return;
      }
      
      attempts++;
      await Future.delayed(delay);
    }
    
    print('⚠️ Subscription update timeout, proceeding with navigation');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF58CC02),
              Color(0xFF1CB0F6),
              Color(0xFFCE82FF),
              Color(0xFF4CAF50),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  
                  // Ethiopian Icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.workspace_premium,
                      size: 60,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Title
                  const Text(
                    'Unlock Premium Ethiopian Experience',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Subtitle
                  Text(
                    'Start with a 24-hour free trial, then continue with premium access to all Ethiopian attractions, AI chatbot, and exclusive content.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Features List
                        Container(
                    padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                            ),
                          ),
                          child: Column(
                      children: [
                        const Text(
                          'Premium Features',
                                    style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...[
                          '🏛️ Complete access to all Ethiopian attractions',
                          '🤖 AI-powered Ethiopian tourism chatbot',
                          '🗺️ Offline maps and cultural guides',
                          '📚 Amharic language learning modules',
                          '🎭 Exclusive cultural experiences',
                          '🎧 Audio guides for historical sites',
                      ].map((feature) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                feature,
                                  style: const TextStyle(
                                          fontSize: 14,
                                    color: Colors.white,
                                  ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                          ),
                        ),
                        
                  const SizedBox(height: 40),
                  
                  // Action Button
                  SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1B5E20),
                        elevation: 8,
                        shadowColor: Colors.black.withValues(alpha: 0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                      child: _isStartingTrial
                          ? const CircularProgressIndicator(
                              color: Color(0xFF1B5E20),
                            )
                          : const Text(
                              'Start 24 Hours Free Trial',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      onPressed: _isStartingTrial ? null : () async {
                        setState(() {
                          _isStartingTrial = true;
                        });

                        try {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            // Start the free trial using the provider
                            final subscriptionActions = ref.read(subscriptionActionsProvider);
                            await subscriptionActions.startFreeTrial();
                            
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('🎉 Free trial started! Enjoy 24 hours of premium features.'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              
                              // Wait for subscription provider to update
                              await _waitForSubscriptionUpdate();
                              
                              if (mounted) {
                                context.go('/home');
                              }
                            }
                          } else {
                            // User not logged in, redirect to auth
                            if (mounted) {
                              context.go('/auth');
                            }
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error starting trial: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() {
                              _isStartingTrial = false;
                            });
                          }
                        }
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Subscribe Now Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        context.go('/payment/method');
                      },
                      child: const Text(
                        'Subscribe Now - Pay with SantimPay/Telebirr',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Skip/Later Button
          TextButton(
                    onPressed: () {
                      // Set limited access flag
                      ref.read(limitedAccessProvider.notifier).state = true;
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You can start your free trial anytime to unlock all features!'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                      context.go('/home');
                    },
                    child: const Text(
                      'Continue with Limited Access',
                style: TextStyle(
                  color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                ),
              ),
            ),
                  
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}