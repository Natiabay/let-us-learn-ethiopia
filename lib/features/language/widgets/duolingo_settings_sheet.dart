import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

class DuolingoSettingsSheet extends StatefulWidget {
  const DuolingoSettingsSheet({super.key});

  @override
  State<DuolingoSettingsSheet> createState() => _DuolingoSettingsSheetState();
}

class _DuolingoSettingsSheetState extends State<DuolingoSettingsSheet> {
  bool notificationsEnabled = true;
  bool soundEnabled = true;
  bool hapticEnabled = true;
  String selectedLanguage = 'English';
  String selectedVoice = 'Female';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.settings_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          
          // Settings Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                // Notifications Section
                _buildSettingsSection(
                  'Notifications',
                  Icons.notifications_rounded,
                  [
                    _buildSwitchTile(
                      'Push Notifications',
                      'Get reminded to practice',
                      notificationsEnabled,
                      (value) => setState(() => notificationsEnabled = value),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Audio Section
                _buildSettingsSection(
                  'Audio',
                  Icons.volume_up_rounded,
                  [
                    _buildSwitchTile(
                      'Sound Effects',
                      'Play sounds for interactions',
                      soundEnabled,
                      (value) => setState(() => soundEnabled = value),
                    ),
                    _buildSwitchTile(
                      'Haptic Feedback',
                      'Feel vibrations for feedback',
                      hapticEnabled,
                      (value) => setState(() => hapticEnabled = value),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Language Section
                _buildSettingsSection(
                  'Language',
                  Icons.language_rounded,
                  [
                    _buildDropdownTile(
                      'Interface Language',
                      'Choose your preferred language',
                      selectedLanguage,
                      ['English', 'Amharic', 'French', 'Spanish'],
                      (value) => setState(() => selectedLanguage = value!),
                    ),
                    _buildDropdownTile(
                      'Voice',
                      'Choose your preferred voice',
                      selectedVoice,
                      ['Female', 'Male'],
                      (value) => setState(() => selectedVoice = value!),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Learning Section
                _buildSettingsSection(
                  'Learning',
                  Icons.school_rounded,
                  [
                    _buildActionTile(
                      'Reset Progress',
                      'Start over with your learning',
                      Icons.refresh_rounded,
                      () => _showResetDialog(),
                    ),
                    _buildActionTile(
                      'Export Data',
                      'Download your progress',
                      Icons.download_rounded,
                      () => _exportData(),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // About Section
                _buildSettingsSection(
                  'About',
                  Icons.info_rounded,
                  [
                    _buildActionTile(
                      'Privacy Policy',
                      'Read our privacy policy',
                      Icons.privacy_tip_rounded,
                      () => _openPrivacyPolicy(),
                    ),
                    _buildActionTile(
                      'Terms of Service',
                      'Read our terms of service',
                      Icons.description_rounded,
                      () => _openTermsOfService(),
                    ),
                    _buildActionTile(
                      'Contact Support',
                      'Get help from our team',
                      Icons.support_agent_rounded,
                      () => _contactSupport(),
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildSettingsSection(String title, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.grey50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.grey200, width: 1),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
      ),
    );
  }

  Widget _buildDropdownTile(
    String title,
    String subtitle,
    String value,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        underline: const SizedBox.shrink(),
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionTile(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      leading: Icon(
        icon,
        color: AppColors.primary,
        size: 20,
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: onTap,
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reset Progress'),
        content: const Text(
          'Are you sure you want to reset all your progress? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              // TODO: Reset progress
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Progress reset successfully'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.textOnPrimary,
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _exportData() {
    // TODO: Implement data export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data export started'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _openPrivacyPolicy() {
    // TODO: Open privacy policy
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening privacy policy...'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _openTermsOfService() {
    // TODO: Open terms of service
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening terms of service...'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _contactSupport() {
    // TODO: Open support contact
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening support...'),
        backgroundColor: AppColors.info,
      ),
    );
  }
}

