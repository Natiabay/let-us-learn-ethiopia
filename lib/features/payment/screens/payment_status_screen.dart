import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/features/payment/providers/payment_provider.dart';
import 'package:tourist_assistive_app/features/payment/services/payment_manager.dart';

class PaymentStatusScreen extends ConsumerStatefulWidget {
  final String transactionId;

  const PaymentStatusScreen({
    super.key,
    required this.transactionId,
  });

  @override
  ConsumerState<PaymentStatusScreen> createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends ConsumerState<PaymentStatusScreen> {
  @override
  Widget build(BuildContext context) {
    final paymentStatusAsync = ref.watch(paymentStatusProvider(widget.transactionId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Status'),
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: paymentStatusAsync.when(
              data: (status) => _buildStatusContent(status),
              loading: () => _buildLoadingContent(),
              error: (error, stack) => _buildErrorContent(error),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusContent(PaymentStatusResult? status) {
    if (status == null) {
      return _buildErrorContent('Payment status not found');
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Status Icon
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
          child: Icon(
            _getStatusIcon(status),
            size: 60,
            color: _getStatusColor(status),
          ),
        ),

        const SizedBox(height: 32),

        // Status Title
        Text(
          _getStatusTitle(status),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 16),

        // Status Message
        Text(
          status.message ?? _getStatusMessage(status),
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),

        // Transaction ID
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
              const Text(
                'Transaction ID',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.transactionId,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Action Buttons
        if (status.isCompleted) ...[
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
              onPressed: () {
                context.go('/home');
              },
              child: const Text(
                'Continue to App',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ] else if (status.isPending) ...[
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
              onPressed: () {
                // Refresh payment status
                ref.invalidate(paymentStatusProvider(widget.transactionId));
              },
              child: const Text(
                'Check Status Again',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              context.go('/payment');
            },
            child: const Text(
              'Try Different Payment Method',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ] else if (status.isFailed) ...[
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
              onPressed: () {
                context.go('/payment');
              },
              child: const Text(
                'Try Again',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
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
        ],

        const SizedBox(height: 32),

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
                '1. Open your SantimPay or Telebirr app\n'
                '2. Send the payment amount to +251 97 221 7121\n'
                '3. Use the transaction ID as reference\n'
                '4. Wait for automatic confirmation',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingContent() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
          SizedBox(height: 24),
          Text(
            'Checking payment status...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorContent(dynamic error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 80,
          ),
          const SizedBox(height: 24),
          const Text(
            'Error Loading Payment Status',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            error.toString(),
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                context.go('/payment');
              },
              child: const Text(
                'Back to Payment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(PaymentStatusResult status) {
    if (status.isCompleted) {
      return Icons.check_circle;
    } else if (status.isPending) {
      return Icons.access_time;
    } else if (status.isFailed) {
      return Icons.cancel;
    } else {
      return Icons.help_outline;
    }
  }

  Color _getStatusColor(PaymentStatusResult status) {
    if (status.isCompleted) {
      return Colors.green;
    } else if (status.isPending) {
      return Colors.orange;
    } else if (status.isFailed) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  String _getStatusTitle(PaymentStatusResult status) {
    if (status.isCompleted) {
      return 'Payment Successful!';
    } else if (status.isPending) {
      return 'Payment Pending';
    } else if (status.isFailed) {
      return 'Payment Failed';
    } else {
      return 'Unknown Status';
    }
  }

  String _getStatusMessage(PaymentStatusResult status) {
    if (status.isCompleted) {
      return 'Your subscription has been activated successfully. Enjoy your premium features!';
    } else if (status.isPending) {
      return 'We are waiting for your payment. Please complete the transaction using your mobile money app.';
    } else if (status.isFailed) {
      return 'The payment could not be processed. Please try again or contact support.';
    } else {
      return 'We are checking your payment status. Please wait...';
    }
  }
}
