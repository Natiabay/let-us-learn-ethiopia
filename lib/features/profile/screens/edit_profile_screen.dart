import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_assistive_app/core/constants/app_colors.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  
  bool _isLoading = false;

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

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    // Load current user data
    _nameController.text = "John Doe";
    _emailController.text = "john.doe@example.com";
    _phoneController.text = "+251 9X XXX XXXX";
    _bioController.text = "Passionate traveler exploring Ethiopia's rich history and culture.";
  }

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
        'Edit Profile',
        style: TextStyle(
          color: _textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : _saveProfile,
          child: Text(
            'Save',
            style: TextStyle(
              color: _isLoading ? _textTertiary : _turquoise,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
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
          _buildProfilePictureSection(),
          const SizedBox(height: 30),
          _buildFormSection(),
          const SizedBox(height: 30),
          _buildPreferencesSection(),
          const SizedBox(height: 30),
          _buildAccountSection(),
        ],
      ),
    );
  }

  Widget _buildProfilePictureSection() {
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
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [_turquoise, _blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _turquoise.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: _textPrimary,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _turquoise,
                    shape: BoxShape.circle,
                    border: Border.all(color: _navyCard, width: 3),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 18,
                    color: _textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Tap to change photo',
            style: TextStyle(
              color: _textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal Information',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            _buildInputField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildInputField(
              controller: _emailController,
              label: 'Email Address',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildInputField(
              controller: _phoneController,
              label: 'Phone Number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            _buildInputField(
              controller: _bioController,
              label: 'Bio',
              icon: Icons.info_outline,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: _textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: _textSecondary),
        prefixIcon: Icon(icon, color: _turquoise),
        filled: true,
        fillColor: _navyBlue,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _textTertiary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _textTertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _turquoise, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _red, width: 2),
        ),
      ),
    );
  }

  Widget _buildPreferencesSection() {
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
            'Preferences',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          _buildPreferenceItem(
            icon: Icons.language,
            title: 'Language',
            subtitle: 'English',
            onTap: () => _showLanguageDialog(),
          ),
          const Divider(color: _textTertiary, height: 32),
          _buildPreferenceItem(
            icon: Icons.dark_mode,
            title: 'Theme',
            subtitle: 'Dark Mode',
            onTap: () => _showThemeDialog(),
          ),
          const Divider(color: _textTertiary, height: 32),
          _buildPreferenceItem(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Enabled',
            onTap: () => _showNotificationDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
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

  Widget _buildAccountSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navyCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _red.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: _red.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account Actions',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          _buildActionItem(
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () => _showChangePasswordDialog(),
          ),
          const Divider(color: _textTertiary, height: 32),
          _buildActionItem(
            icon: Icons.logout,
            title: 'Sign Out',
            subtitle: 'Sign out of your account',
            onTap: () => _showSignOutDialog(),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? _red : _turquoise;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDestructive ? _red : _textPrimary,
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

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() => _isLoading = false);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile updated successfully!'),
          backgroundColor: _turquoise,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _navyCard,
        title: const Text('Select Language', style: TextStyle(color: _textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('English', true),
            _buildLanguageOption('Amharic', false),
            _buildLanguageOption('French', false),
            _buildLanguageOption('Arabic', false),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save', style: TextStyle(color: _turquoise)),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String language, bool isSelected) {
    return ListTile(
      title: Text(language, style: const TextStyle(color: _textPrimary)),
      trailing: isSelected ? const Icon(Icons.check, color: _turquoise) : null,
      onTap: () => Navigator.pop(context),
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _navyCard,
        title: const Text('Select Theme', style: TextStyle(color: _textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption('Dark Mode', true),
            _buildThemeOption('Light Mode', false),
            _buildThemeOption('System Default', false),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save', style: TextStyle(color: _turquoise)),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(String theme, bool isSelected) {
    return ListTile(
      title: Text(theme, style: const TextStyle(color: _textPrimary)),
      trailing: isSelected ? const Icon(Icons.check, color: _turquoise) : null,
      onTap: () => Navigator.pop(context),
    );
  }

  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _navyCard,
        title: const Text('Notification Settings', style: TextStyle(color: _textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNotificationOption('Push Notifications', true),
            _buildNotificationOption('Email Notifications', true),
            _buildNotificationOption('SMS Notifications', false),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save', style: TextStyle(color: _turquoise)),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationOption(String option, bool isEnabled) {
    return ListTile(
      title: Text(option, style: const TextStyle(color: _textPrimary)),
      trailing: Switch(
        value: isEnabled,
        onChanged: (value) {},
        activeColor: _turquoise,
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _navyCard,
        title: const Text('Change Password', style: TextStyle(color: _textPrimary)),
        content: const Text(
          'Password change functionality will be implemented here.',
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

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _navyCard,
        title: const Text('Sign Out', style: TextStyle(color: _textPrimary)),
        content: const Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: _textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement sign out logic
            },
            child: const Text('Sign Out', style: TextStyle(color: _red)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}
