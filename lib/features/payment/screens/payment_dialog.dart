import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/features/subscription/providers/subscription_provider.dart';

void showPaymentDialog(BuildContext context, SubscriptionActions subscriptionActions) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1B5E20).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.workspace_premium,
                color: Color(0xFF1B5E20),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Choose Your Plan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Your free trial has ended. Choose a plan to continue accessing premium Ethiopian tourism content.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            
            // Monthly Plan
            _buildPlanCard(
              context,
              subscriptionActions,
              title: 'Monthly Plan',
              price: '\$9.99',
              period: 'per month',
              features: [
                'Full access to all attractions',
                'AI-powered chatbot assistance',
                'Offline maps and content',
                'Cultural learning modules',
                'Priority customer support',
              ],
              durationDays: 30,
              amount: 9.99,
              isPopular: false,
            ),
            
            const SizedBox(height: 16),
            
            // Yearly Plan
            _buildPlanCard(
              context,
              subscriptionActions,
              title: 'Yearly Plan',
              price: '\$99.99',
              period: 'per year',
              originalPrice: '\$119.88',
              features: [
                'Everything in Monthly Plan',
                'Save \$20 per year',
                'Exclusive cultural experiences',
                'Premium travel recommendations',
                'Free updates and new content',
              ],
              durationDays: 365,
              amount: 99.99,
              isPopular: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Maybe Later',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildPlanCard(
  BuildContext context,
  SubscriptionActions subscriptionActions, {
  required String title,
  required String price,
  required String period,
  String? originalPrice,
  required List<String> features,
  required int durationDays,
  required double amount,
  required bool isPopular,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: isPopular ? const Color(0xFF1B5E20) : Colors.grey[300]!,
        width: isPopular ? 2 : 1,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      children: [
        if (isPopular)
          Positioned(
            top: -1,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: const BoxDecoration(
                color: Color(0xFF1B5E20),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: const Text(
                'BEST VALUE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isPopular ? const Color(0xFF1B5E20) : Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (originalPrice != null)
                        Text(
                          originalPrice,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Row(
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isPopular ? const Color(0xFF1B5E20) : Colors.black87,
                            ),
                          ),
                          Text(
                            ' $period',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: isPopular ? const Color(0xFF1B5E20) : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await subscriptionActions.activatePremium(
                        durationDays: durationDays,
                        paymentMethod: 'telebirr',
                        amount: amount,
                      );
                      
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('🎉 Premium subscription activated!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        context.go('/home');
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Payment failed: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPopular ? const Color(0xFF1B5E20) : Colors.grey[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Choose $title',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
