import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/core/constants/app_colors.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  // Professional navy blue theme colors
  static const Color _navyBlue = Color(0xFF0A1929);
  static const Color _navyCard = Color(0xFF1A2F44);
  static const Color _turquoise = Color(0xFF00D9B8);
  static const Color _yellow = Color(0xFFFFD43B);
  static const Color _blue = Color(0xFF1CB0F6);
  static const Color _red = Color(0xFFFF4B4B);
  static const Color _textPrimary = Color(0xFFFFFFFF);
  static const Color _textSecondary = Color(0xFFB3B3B3);
  static const Color _textTertiary = Color(0xFF8B949E);

  // Current subscription status
  bool _isPremium = false;
  String _currentPlan = 'Free';
  DateTime? _expiryDate;

  // Subscription plans
  final List<Map<String, dynamic>> _plans = [
    {
      'name': 'Free',
      'price': '0',
      'currency': 'ETB',
      'period': 'Forever',
      'features': [
        'Basic Amharic lessons',
        'Limited location access',
        'Standard support',
        'Basic progress tracking',
      ],
      'color': _textTertiary,
      'isPopular': false,
    },
    {
      'name': 'Explorer',
      'price': '299',
      'currency': 'ETB',
      'period': 'per month',
      'features': [
        'All Amharic lessons',
        'All location access',
        'Offline downloads',
        'Priority support',
        'Advanced progress tracking',
        'Exclusive content',
      ],
      'color': _turquoise,
      'isPopular': true,
    },
    {
      'name': 'Adventurer',
      'price': '2,999',
      'currency': 'ETB',
      'period': 'per year',
      'features': [
        'Everything in Explorer',
        'All language lessons',
        'Unlimited downloads',
        '24/7 premium support',
        'Advanced analytics',
        'Early access to new features',
        'Personal tour guide AI',
      ],
      'color': _blue,
      'isPopular': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navyBlue,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _navyCard,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: _textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Subscription',
        style: TextStyle(
          color: _textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline, color: _textPrimary),
          onPressed: () => _showHelpDialog(),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCurrentStatus(),
          const SizedBox(height: 24),
          _buildPlansSection(),
          const SizedBox(height: 24),
          _buildFeaturesComparison(),
          const SizedBox(height: 24),
          _buildFAQSection(),
        ],
      ),
    );
  }

  Widget _buildCurrentStatus() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _isPremium 
            ? [_turquoise.withValues(alpha: 0.1), _blue.withValues(alpha: 0.1)]
            : [_textTertiary.withValues(alpha: 0.1), _textTertiary.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _isPremium 
            ? _turquoise.withValues(alpha: 0.3)
            : _textTertiary.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: _isPremium 
              ? _turquoise.withValues(alpha: 0.2)
              : _textTertiary.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _isPremium 
                    ? _turquoise.withValues(alpha: 0.2)
                    : _textTertiary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _isPremium ? Icons.diamond : Icons.person,
                  color: _isPremium ? _turquoise : _textTertiary,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isPremium ? 'Premium Member' : 'Free User',
                      style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _isPremium 
                        ? 'Enjoying all premium features'
                        : 'Upgrade to unlock premium features',
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isPremium && _expiryDate != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _navyCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _turquoise.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.schedule, color: _turquoise, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Expires: ${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}',
                    style: const TextStyle(
                      color: _textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlansSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Your Plan',
          style: TextStyle(
            color: _textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ..._plans.map((plan) => _buildPlanCard(plan)),
      ],
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    final isCurrentPlan = plan['name'] == _currentPlan;
    final isPopular = plan['isPopular'] as bool;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrentPlan 
            ? _turquoise.withValues(alpha: 0.5)
            : isPopular 
              ? plan['color'].withValues(alpha: 0.5)
              : _textTertiary.withValues(alpha: 0.3),
          width: isCurrentPlan || isPopular ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isCurrentPlan 
              ? _turquoise.withValues(alpha: 0.2)
              : isPopular 
                ? plan['color'].withValues(alpha: 0.2)
                : _textTertiary.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (isPopular)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: plan['color'],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: const Text(
                  'POPULAR',
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan['name'],
                            style: const TextStyle(
                              color: _textPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${plan['currency']} ${plan['price']}',
                                style: TextStyle(
                                  color: plan['color'],
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                plan['period'],
                                style: const TextStyle(
                                  color: _textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (isCurrentPlan)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _turquoise.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: _turquoise.withValues(alpha: 0.3)),
                        ),
                        child: const Text(
                          'CURRENT',
                          style: TextStyle(
                            color: _turquoise,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                ...(plan['features'] as List<String>).map((feature) => _buildFeatureItem(feature)),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isCurrentPlan ? null : () => _selectPlan(plan),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isCurrentPlan 
                        ? _textTertiary.withValues(alpha: 0.3)
                        : plan['color'],
                      foregroundColor: isCurrentPlan 
                        ? _textTertiary
                        : _textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isCurrentPlan ? 'Current Plan' : 'Select Plan',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: _turquoise,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(
                color: _textSecondary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesComparison() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _turquoise.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: _turquoise.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Feature Comparison',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildComparisonRow('Amharic Lessons', [true, true, true]),
          _buildComparisonRow('All Languages', [false, false, true]),
          _buildComparisonRow('Offline Access', [false, true, true]),
          _buildComparisonRow('Priority Support', [false, true, true]),
          _buildComparisonRow('Advanced Analytics', [false, false, true]),
          _buildComparisonRow('Personal AI Guide', [false, false, true]),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String feature, List<bool> availability) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              feature,
              style: const TextStyle(
                color: _textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ...availability.map((available) => Expanded(
            child: Center(
              child: Icon(
                available ? Icons.check : Icons.close,
                color: available ? _turquoise : _textTertiary,
                size: 20,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Frequently Asked Questions',
          style: TextStyle(
            color: _textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildFAQItem(
          'Can I cancel anytime?',
          'Yes, you can cancel your subscription at any time. You\'ll continue to have access to premium features until the end of your billing period.',
        ),
        _buildFAQItem(
          'What payment methods do you accept?',
          'We accept all major credit cards, debit cards, and mobile payment methods including Telebirr and Chapa.',
        ),
        _buildFAQItem(
          'Is there a free trial?',
          'Yes! New users get a 7-day free trial of the Explorer plan. No credit card required.',
        ),
        _buildFAQItem(
          'Can I change my plan later?',
          'Absolutely! You can upgrade or downgrade your plan at any time. Changes take effect immediately.',
        ),
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _textTertiary.withValues(alpha: 0.3)),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            color: _textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconColor: _turquoise,
        collapsedIconColor: _textTertiary,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: const TextStyle(
                color: _textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectPlan(Map<String, dynamic> plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _navyCard,
        title: Text(
          'Subscribe to ${plan['name']}',
          style: const TextStyle(color: _textPrimary),
        ),
        content: Text(
          'You will be charged ${plan['currency']} ${plan['price']} ${plan['period']}. Continue?',
          style: const TextStyle(color: _textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _processSubscription(plan);
            },
            child: Text(
              'Subscribe',
              style: TextStyle(color: plan['color']),
            ),
          ),
        ],
      ),
    );
  }

  void _processSubscription(Map<String, dynamic> plan) {
    setState(() {
      _isPremium = plan['name'] != 'Free';
      _currentPlan = plan['name'];
      if (_isPremium) {
        _expiryDate = DateTime.now().add(const Duration(days: 30));
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully subscribed to ${plan['name']}!'),
        backgroundColor: plan['color'],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _navyCard,
        title: const Text('Subscription Help', style: TextStyle(color: _textPrimary)),
        content: const Text(
          'Need help with your subscription? Contact our support team for assistance.',
          style: TextStyle(color: _textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: _turquoise)),
          ),
        ],
      ),
    );
  }
}
