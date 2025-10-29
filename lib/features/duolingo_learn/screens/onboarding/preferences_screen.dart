import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

/// Preferences Screen for Language Learning Setup
/// Final screen to set learning preferences and complete setup
class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  int _dailyGoal = 10; // minutes
  String _reminderTime = '09:00';
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Preferences',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Almost there!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ).animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .slideX(begin: -0.3, end: 0, delay: 200.ms),

              const SizedBox(height: 8),

              Text(
                'Set your learning preferences to get started',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 16,
                ),
              ).animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideX(begin: -0.3, end: 0, delay: 400.ms),

              const SizedBox(height: 32),

              // Preferences
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Daily Goal
                      _buildPreferenceCard(
                        title: 'Daily Goal',
                        subtitle: 'How many minutes per day?',
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$_dailyGoal minutes',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: _dailyGoal > 5
                                          ? () => setState(() => _dailyGoal -= 5)
                                          : null,
                                      icon: const Icon(Icons.remove_rounded),
                                      style: IconButton.styleFrom(
                                        backgroundColor: const Color(0xFF2A2A2A),
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      onPressed: _dailyGoal < 60
                                          ? () => setState(() => _dailyGoal += 5)
                                          : null,
                                      icon: const Icon(Icons.add_rounded),
                                      style: IconButton.styleFrom(
                                        backgroundColor: const Color(0xFF58CC02),
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Slider(
                              value: _dailyGoal.toDouble(),
                              min: 5,
                              max: 60,
                              divisions: 11,
                              activeColor: const Color(0xFF58CC02),
                              inactiveColor: Colors.white.withValues(alpha: 0.2),
                              onChanged: (value) {
                                setState(() {
                                  _dailyGoal = value.round();
                                });
                              },
                            ),
                          ],
                        ),
                        delay: 200,
                      ),

                      const SizedBox(height: 16),

                      // Reminder Time
                      _buildPreferenceCard(
                        title: 'Daily Reminder',
                        subtitle: 'When should we remind you to practice?',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _reminderTime,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: _selectTime,
                              icon: const Icon(Icons.access_time_rounded),
                              label: const Text('Change'),
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF58CC02),
                              ),
                            ),
                          ],
                        ),
                        delay: 400,
                      ),

                      const SizedBox(height: 16),

                      // Notifications
                      _buildPreferenceCard(
                        title: 'Notifications',
                        subtitle: 'Get reminders and updates',
                        child: Switch(
                          value: _notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                          activeColor: const Color(0xFF58CC02),
                        ),
                        delay: 600,
                      ),

                      const SizedBox(height: 16),

                      // Sound
                      _buildPreferenceCard(
                        title: 'Sound Effects',
                        subtitle: 'Play sounds during lessons',
                        child: Switch(
                          value: _soundEnabled,
                          onChanged: (value) {
                            setState(() {
                              _soundEnabled = value;
                            });
                          },
                          activeColor: const Color(0xFF58CC02),
                        ),
                        delay: 800,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Complete Setup Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _completeSetup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF58CC02),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Complete Setup',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ).animate()
                .fadeIn(delay: 1000.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, delay: 1000.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceCard({
    required String title,
    required String subtitle,
    required Widget child,
    required int delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    ).animate()
      .fadeIn(delay: delay.ms, duration: 600.ms)
      .slideX(begin: -0.3, end: 0, delay: delay.ms);
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_reminderTime.split(':')[0]),
        minute: int.parse(_reminderTime.split(':')[1]),
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF58CC02),
              onPrimary: Colors.white,
              surface: Color(0xFF2A2A2A),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _reminderTime = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  void _completeSetup() {
    // Save preferences and navigate to dashboard
    // TODO: Save preferences to storage/provider
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Setup complete! Welcome to your learning journey!'),
        backgroundColor: Color(0xFF58CC02),
      ),
    );

    // Navigate to language dashboard
    context.go('/language');
  }
}
