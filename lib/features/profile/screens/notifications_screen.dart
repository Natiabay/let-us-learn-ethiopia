import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
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

  // Notification settings
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _learningReminders = true;
  bool _locationUpdates = true;
  bool _achievementAlerts = true;
  bool _weeklyReports = false;

  // Sample notifications data
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Learning Streak!',
      'message': 'Great job! You\'ve maintained a 7-day learning streak.',
      'time': '2 hours ago',
      'type': 'achievement',
      'isRead': false,
      'icon': Icons.local_fire_department,
      'color': _red,
    },
    {
      'id': '2',
      'title': 'New Location Added',
      'message': 'Simien Mountains National Park has been added to your favorites.',
      'time': '1 day ago',
      'type': 'location',
      'isRead': false,
      'icon': Icons.location_on,
      'color': _blue,
    },
    {
      'id': '3',
      'title': 'Lesson Reminder',
      'message': 'Don\'t forget to practice your Amharic lessons today!',
      'time': '2 days ago',
      'type': 'learning',
      'isRead': true,
      'icon': Icons.school,
      'color': _turquoise,
    },
    {
      'id': '4',
      'title': 'Achievement Unlocked',
      'message': 'Congratulations! You\'ve completed 10 lessons.',
      'time': '3 days ago',
      'type': 'achievement',
      'isRead': true,
      'icon': Icons.emoji_events,
      'color': _yellow,
    },
    {
      'id': '5',
      'title': 'Weather Update',
      'message': 'Perfect weather for visiting Lalibela today!',
      'time': '1 week ago',
      'type': 'weather',
      'isRead': true,
      'icon': Icons.wb_sunny,
      'color': _yellow,
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
        'Notifications',
              style: TextStyle(
          color: _textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: _textPrimary),
          onPressed: () => _showSettingsDialog(),
        ),
        IconButton(
          icon: const Icon(Icons.mark_email_read, color: _textPrimary),
          onPressed: () => _markAllAsRead(),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
              children: [
        _buildSettingsSection(),
        Expanded(
          child: _buildNotificationsList(),
        ),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      margin: const EdgeInsets.all(20),
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
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _turquoise.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.notifications, color: _turquoise, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Notification Settings',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingItem(
            title: 'Push Notifications',
            subtitle: 'Receive notifications on your device',
            value: _pushNotifications,
            onChanged: (value) => setState(() => _pushNotifications = value),
          ),
          _buildSettingItem(
            title: 'Email Notifications',
            subtitle: 'Receive notifications via email',
            value: _emailNotifications,
            onChanged: (value) => setState(() => _emailNotifications = value),
          ),
          _buildSettingItem(
            title: 'Learning Reminders',
            subtitle: 'Daily reminders to practice',
            value: _learningReminders,
            onChanged: (value) => setState(() => _learningReminders = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: _turquoise,
            activeTrackColor: _turquoise.withValues(alpha: 0.3),
            inactiveThumbColor: _textTertiary,
            inactiveTrackColor: _textTertiary.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    if (_notifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notification['isRead'] 
            ? _textTertiary.withValues(alpha: 0.3)
            : notification['color'].withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: notification['color'].withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _markAsRead(notification),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: notification['color'].withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  notification['icon'],
                  color: notification['color'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: TextStyle(
                              color: _textPrimary,
                              fontSize: 16,
                              fontWeight: notification['isRead'] 
                                ? FontWeight.w500 
                                : FontWeight.w600,
                            ),
                          ),
                        ),
                        if (!notification['isRead'])
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: _turquoise,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification['message'],
                style: TextStyle(
                        color: _textSecondary,
                        fontSize: 14,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      notification['time'],
                      style: const TextStyle(
                        color: _textTertiary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: _textTertiary),
                onSelected: (value) => _handleNotificationAction(value, notification),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'mark_read',
                    child: Row(
                      children: [
                        Icon(
                          notification['isRead'] ? Icons.mark_email_unread : Icons.mark_email_read,
                          color: _textPrimary,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          notification['isRead'] ? 'Mark as unread' : 'Mark as read',
                          style: const TextStyle(color: _textPrimary),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(Icons.delete, color: _red, size: 16),
                        const SizedBox(width: 8),
                        const Text('Delete', style: TextStyle(color: _red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: _turquoise.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_none,
              size: 60,
              color: _turquoise,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Notifications',
                  style: TextStyle(
              color: _textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'You\'re all caught up!\nNew notifications will appear here.',
            textAlign: TextAlign.center,
                  style: TextStyle(
              color: _textSecondary,
              fontSize: 16,
              ),
            ),
        ],
      ),
    );
  }

  void _markAsRead(Map<String, dynamic> notification) {
    setState(() {
      notification['isRead'] = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        backgroundColor: _turquoise,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleNotificationAction(String action, Map<String, dynamic> notification) {
    switch (action) {
      case 'mark_read':
        setState(() {
          notification['isRead'] = !notification['isRead'];
        });
        break;
      case 'delete':
        setState(() {
          _notifications.removeWhere((n) => n['id'] == notification['id']);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notification deleted'),
            backgroundColor: _red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _navyCard,
        title: const Text('Notification Settings', style: TextStyle(color: _textPrimary)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogSettingItem(
                title: 'Push Notifications',
                value: _pushNotifications,
                onChanged: (value) => setState(() => _pushNotifications = value),
              ),
              _buildDialogSettingItem(
                title: 'Email Notifications',
                value: _emailNotifications,
                onChanged: (value) => setState(() => _emailNotifications = value),
              ),
              _buildDialogSettingItem(
                title: 'SMS Notifications',
                value: _smsNotifications,
                onChanged: (value) => setState(() => _smsNotifications = value),
              ),
              _buildDialogSettingItem(
                title: 'Learning Reminders',
                value: _learningReminders,
                onChanged: (value) => setState(() => _learningReminders = value),
              ),
              _buildDialogSettingItem(
                title: 'Location Updates',
                value: _locationUpdates,
                onChanged: (value) => setState(() => _locationUpdates = value),
              ),
              _buildDialogSettingItem(
                title: 'Achievement Alerts',
                value: _achievementAlerts,
                onChanged: (value) => setState(() => _achievementAlerts = value),
              ),
              _buildDialogSettingItem(
                title: 'Weekly Reports',
                value: _weeklyReports,
                onChanged: (value) => setState(() => _weeklyReports = value),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings saved'),
                  backgroundColor: _turquoise,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Save', style: TextStyle(color: _turquoise)),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogSettingItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: _textPrimary),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: _turquoise,
            activeTrackColor: _turquoise.withValues(alpha: 0.3),
            inactiveThumbColor: _textTertiary,
            inactiveTrackColor: _textTertiary.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}
