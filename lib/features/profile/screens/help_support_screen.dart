import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/core/constants/app_colors.dart';

class HelpSupportScreen extends ConsumerStatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  ConsumerState<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends ConsumerState<HelpSupportScreen> {
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

  final List<Map<String, dynamic>> _faqItems = [
    {
      'question': 'How do I start learning Amharic?',
      'answer': 'Go to the Language section and select Amharic lessons. Start with basic greetings and common phrases.',
      'category': 'Learning',
    },
    {
      'question': 'How can I find tourist locations?',
      'answer': 'Use the Locations tab to explore historical sites, natural wonders, and cultural attractions in Ethiopia.',
      'category': 'Locations',
    },
    {
      'question': 'Is the app available offline?',
      'answer': 'Yes! Download lessons and location data for offline access. Some features require internet connection.',
      'category': 'Technical',
    },
    {
      'question': 'How do I save favorite locations?',
      'answer': 'Tap the heart icon on any location card to add it to your favorites. Access them from your profile.',
      'category': 'Features',
    },
    {
      'question': 'Can I use the app without internet?',
      'answer': 'Yes, downloaded content works offline. You can access saved lessons and location information.',
      'category': 'Technical',
    },
  ];

  final List<Map<String, dynamic>> _contactOptions = [
    {
      'title': 'Live Chat',
      'subtitle': 'Get instant help from our support team',
      'icon': Icons.chat,
      'color': _turquoise,
      'action': 'Start Chat',
    },
    {
      'title': 'Email Support',
      'subtitle': 'Send us a detailed message',
      'icon': Icons.email,
      'color': _blue,
      'action': 'Send Email',
    },
    {
      'title': 'Phone Support',
      'subtitle': 'Call us for urgent assistance',
      'icon': Icons.phone,
      'color': _red,
      'action': 'Call Now',
    },
    {
      'title': 'Video Call',
      'subtitle': 'Schedule a video consultation',
      'icon': Icons.video_call,
      'color': _yellow,
      'action': 'Schedule',
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
        'Help & Support',
        style: TextStyle(
          color: _textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: _textPrimary),
          onPressed: () => _showSearchDialog(),
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
          _buildQuickHelpSection(),
          const SizedBox(height: 24),
          _buildContactSection(),
          const SizedBox(height: 24),
          _buildFAQSection(),
          const SizedBox(height: 24),
          _buildResourcesSection(),
        ],
      ),
    );
  }

  Widget _buildQuickHelpSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_turquoise.withValues(alpha: 0.1), _blue.withValues(alpha: 0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _turquoise.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: _turquoise.withValues(alpha: 0.2),
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
                  color: _turquoise.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.help_outline,
                  color: _turquoise,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Need Help?',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'We\'re here to help you explore Ethiopia!',
                      style: TextStyle(
                        color: _textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildQuickAction(
                  icon: Icons.search,
                  label: 'Search FAQ',
                  onTap: () => _showSearchDialog(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickAction(
                  icon: Icons.chat,
                  label: 'Live Chat',
                  onTap: () => _startLiveChat(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: _navyCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _turquoise.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: _turquoise, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: _textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Support',
          style: TextStyle(
            color: _textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ..._contactOptions.map((option) => _buildContactOption(option)),
      ],
    );
  }

  Widget _buildContactOption(Map<String, dynamic> option) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: option['color'].withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: option['color'].withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _handleContactAction(option),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: option['color'].withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  option['icon'],
                  color: option['color'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option['title'],
                      style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      option['subtitle'],
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: option['color'].withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: option['color'].withValues(alpha: 0.3)),
                ),
                child: Text(
                  option['action'],
                  style: TextStyle(
                    color: option['color'],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () => _viewAllFAQ(),
              child: const Text(
                'View All',
                style: TextStyle(color: _turquoise),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._faqItems.take(3).map((faq) => _buildFAQItem(faq)),
      ],
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _textTertiary.withValues(alpha: 0.3)),
      ),
      child: ExpansionTile(
        title: Text(
          faq['question'],
          style: const TextStyle(
            color: _textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          faq['category'],
          style: const TextStyle(
            color: _textSecondary,
            fontSize: 12,
          ),
        ),
        iconColor: _turquoise,
        collapsedIconColor: _textTertiary,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              faq['answer'],
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

  Widget _buildResourcesSection() {
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
            'Additional Resources',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildResourceItem(
            icon: Icons.book,
            title: 'User Guide',
            subtitle: 'Complete guide to using the app',
            onTap: () => _openUserGuide(),
          ),
          const Divider(color: _textTertiary, height: 24),
          _buildResourceItem(
            icon: Icons.video_library,
            title: 'Video Tutorials',
            subtitle: 'Watch step-by-step tutorials',
            onTap: () => _openVideoTutorials(),
          ),
          const Divider(color: _textTertiary, height: 24),
          _buildResourceItem(
            icon: Icons.feedback,
            title: 'Send Feedback',
            subtitle: 'Help us improve the app',
            onTap: () => _sendFeedback(),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _turquoise.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: _turquoise, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: _textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: _textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: _textTertiary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _navyCard,
        title: const Text('Search Help', style: TextStyle(color: _textPrimary)),
        content: const TextField(
          style: TextStyle(color: _textPrimary),
          decoration: InputDecoration(
            hintText: 'What can we help you with?',
            hintStyle: TextStyle(color: _textSecondary),
            prefixIcon: Icon(Icons.search, color: _turquoise),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Search', style: TextStyle(color: _turquoise)),
          ),
        ],
      ),
    );
  }

  void _startLiveChat() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Starting live chat...'),
        backgroundColor: _turquoise,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleContactAction(Map<String, dynamic> option) {
    String message = '';
    switch (option['title']) {
      case 'Live Chat':
        message = 'Starting live chat...';
        break;
      case 'Email Support':
        message = 'Opening email client...';
        break;
      case 'Phone Support':
        message = 'Calling support...';
        break;
      case 'Video Call':
        message = 'Scheduling video call...';
        break;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: option['color'],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _viewAllFAQ() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening all FAQ...'),
        backgroundColor: _blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _openUserGuide() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening user guide...'),
        backgroundColor: _turquoise,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _openVideoTutorials() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening video tutorials...'),
        backgroundColor: _blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _sendFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening feedback form...'),
        backgroundColor: _yellow,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
