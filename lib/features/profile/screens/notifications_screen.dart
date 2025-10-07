import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _lessonReminders = true;
  bool _locationUpdates = true;
  bool _promotionalOffers = false;
  bool _culturalEvents = true;
  bool _weatherAlerts = true;
  bool _emergencyAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _saveSettings,
            child: const Text(
              'Save',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // General Settings
            _buildSectionCard(
              title: 'General Settings',
              children: [
                _buildNotificationToggle(
                  title: 'Push Notifications',
                  subtitle: 'Receive notifications on your device',
                  value: _pushNotifications,
                  onChanged: (value) {
                    setState(() {
                      _pushNotifications = value;
                    });
                  },
                ),
                _buildNotificationToggle(
                  title: 'Email Notifications',
                  subtitle: 'Receive notifications via email',
                  value: _emailNotifications,
                  onChanged: (value) {
                    setState(() {
                      _emailNotifications = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Learning Settings
            _buildSectionCard(
              title: 'Learning & Progress',
              children: [
                _buildNotificationToggle(
                  title: 'Lesson Reminders',
                  subtitle: 'Daily reminders to practice Amharic',
                  value: _lessonReminders,
                  onChanged: (value) {
                    setState(() {
                      _lessonReminders = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Location Settings
            _buildSectionCard(
              title: 'Location & Travel',
              children: [
                _buildNotificationToggle(
                  title: 'Location Updates',
                  subtitle: 'Updates about nearby attractions',
                  value: _locationUpdates,
                  onChanged: (value) {
                    setState(() {
                      _locationUpdates = value;
                    });
                  },
                ),
                _buildNotificationToggle(
                  title: 'Weather Alerts',
                  subtitle: 'Weather updates for your location',
                  value: _weatherAlerts,
                  onChanged: (value) {
                    setState(() {
                      _weatherAlerts = value;
                    });
                  },
                ),
                _buildNotificationToggle(
                  title: 'Emergency Alerts',
                  subtitle: 'Important safety and emergency information',
                  value: _emergencyAlerts,
                  onChanged: (value) {
                    setState(() {
                      _emergencyAlerts = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Cultural Settings
            _buildSectionCard(
              title: 'Cultural & Events',
              children: [
                _buildNotificationToggle(
                  title: 'Cultural Events',
                  subtitle: 'Notifications about local cultural events',
                  value: _culturalEvents,
                  onChanged: (value) {
                    setState(() {
                      _culturalEvents = value;
                    });
                  },
                ),
                _buildNotificationToggle(
                  title: 'Promotional Offers',
                  subtitle: 'Special offers and discounts',
                  value: _promotionalOffers,
                  onChanged: (value) {
                    setState(() {
                      _promotionalOffers = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Notification History
            _buildNotificationHistory(),
            const SizedBox(height: 20),
            
            // Clear All Button
            _buildClearAllButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildNotificationToggle({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationHistory() {
    final notifications = [
      {
        'title': 'Daily Lesson Reminder',
        'message': 'Time to practice your Amharic!',
        'time': '2 hours ago',
        'read': false,
        'type': 'lesson',
      },
      {
        'title': 'Weather Update',
        'message': 'Sunny weather expected in Addis Ababa today',
        'time': '4 hours ago',
        'read': true,
        'type': 'weather',
      },
      {
        'title': 'Cultural Event',
        'message': 'Traditional coffee ceremony at Meskel Square',
        'time': '1 day ago',
        'read': true,
        'type': 'event',
      },
      {
        'title': 'Location Recommendation',
        'message': 'You\'re near the National Museum of Ethiopia',
        'time': '2 days ago',
        'read': true,
        'type': 'location',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Notifications',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: _markAllAsRead,
                child: const Text(
                  'Mark all as read',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...notifications.map((notification) => _buildNotificationItem(
            title: notification['title'] as String,
            message: notification['message'] as String,
            time: notification['time'] as String,
            isRead: notification['read'] as bool,
            type: notification['type'] as String,
          )).toList(),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildNotificationItem({
    required String title,
    required String message,
    required String time,
    required bool isRead,
    required String type,
  }) {
    IconData icon;
    Color color;
    
    switch (type) {
      case 'lesson':
        icon = Icons.school;
        color = AppColors.primary;
        break;
      case 'weather':
        icon = Icons.wb_sunny;
        color = Colors.orange;
        break;
      case 'event':
        icon = Icons.event;
        color = Colors.purple;
        break;
      case 'location':
        icon = Icons.location_on;
        color = Colors.green;
        break;
      default:
        icon = Icons.notifications;
        color = AppColors.grey400;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isRead ? Colors.transparent : AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: isRead ? null : Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
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
                    fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          if (!isRead)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildClearAllButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: _clearAllNotifications,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.error),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Clear All Notifications',
          style: TextStyle(
            color: AppColors.error,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  void _saveSettings() {
    // TODO: Implement save settings functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification settings saved'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _markAllAsRead() {
    // TODO: Implement mark all as read functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _clearAllNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text('Are you sure you want to clear all notifications? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement clear all functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All notifications cleared'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
