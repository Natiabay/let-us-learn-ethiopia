import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tourist_assistive_app/core/services/api_key_manager.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';

/// Automated API Setup Wizard
/// Guides users through setting up their OpenAI API key
class ApiSetupWizard extends ConsumerStatefulWidget {
  const ApiSetupWizard({super.key});

  @override
  ConsumerState<ApiSetupWizard> createState() => _ApiSetupWizardState();
}

class _ApiSetupWizardState extends ConsumerState<ApiSetupWizard> {
  final _apiKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  bool _showAdvancedOptions = false;
  bool _useTemporaryKey = false;

  @override
  void initState() {
    super.initState();
    _checkExistingSetup();
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  Future<void> _checkExistingSetup() async {
    final apiManager = ApiKeyManager();
    await apiManager.initialize();
    
    if (apiManager.hasWorkingApiKey) {
      // Already configured, close wizard
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('AI Assistant Setup'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildSetupOptions(),
            const SizedBox(height: 24),
            if (_showAdvancedOptions) _buildAdvancedOptions(),
            const SizedBox(height: 32),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.psychology, color: AppColors.primary, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Setup Your AI Assistant',
                      style: AppTheme.heading2.copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Get ChatGPT-like responses for your Ethiopian travel questions',
                      style: AppTheme.bodyMedium.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSetupOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Setup Method',
          style: AppTheme.heading3,
        ),
        const SizedBox(height: 16),
        
        // Option 1: Quick Setup (Temporary Key)
        _buildOptionCard(
          title: 'Quick Start (Recommended)',
          subtitle: 'Start chatting immediately with pre-loaded knowledge',
          icon: Icons.rocket_launch,
          color: AppColors.success,
          onTap: () {
            setState(() {
              _useTemporaryKey = true;
              _showAdvancedOptions = false;
            });
          },
          isSelected: _useTemporaryKey,
        ),
        
        const SizedBox(height: 12),
        
        // Option 2: Full AI Setup
        _buildOptionCard(
          title: 'Full AI Experience',
          subtitle: 'Get real-time ChatGPT responses with your API key',
          icon: Icons.auto_awesome,
          color: AppColors.primary,
          onTap: () {
            setState(() {
              _useTemporaryKey = false;
              _showAdvancedOptions = true;
            });
          },
          isSelected: !_useTemporaryKey,
        ),
      ],
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? color : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: color, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OpenAI API Key Setup',
          style: AppTheme.heading3,
        ),
        const SizedBox(height: 16),
        
        // Step 1: Get API Key
        _buildStepCard(
          step: 1,
          title: 'Get Your API Key',
          description: 'Visit OpenAI Platform to get your free API key',
          action: 'Get API Key',
          onAction: () => _launchOpenaiPlatform(),
        ),
        
        const SizedBox(height: 16),
        
        // Step 2: Enter API Key
        _buildStepCard(
          step: 2,
          title: 'Enter Your API Key',
          description: 'Paste your API key below (starts with sk-)',
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _apiKeyController,
                  decoration: InputDecoration(
                    labelText: 'OpenAI API Key',
                    hintText: 'sk-...',
                    prefixIcon: const Icon(Icons.key),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your API key';
                    }
                    if (!value.startsWith('sk-')) {
                      return 'API key must start with "sk-"';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage!,
                    style: AppTheme.bodySmall.copyWith(color: AppColors.error),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepCard({
    required int step,
    required String title,
    required String description,
    String? action,
    VoidCallback? onAction,
    Widget? child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    '$step',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      description,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (action != null && onAction != null)
                ElevatedButton(
                  onPressed: onAction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(action),
                ),
            ],
          ),
          if (child != null) ...[
            const SizedBox(height: 16),
            child,
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleSetup,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    _useTemporaryKey ? 'Start Chatting Now' : 'Test & Save API Key',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Skip for Now',
            style: AppTheme.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchOpenaiPlatform() async {
    try {
      await launchUrl(
        Uri.parse('https://platform.openai.com/api-keys'),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open browser: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _handleSetup() async {
    if (_useTemporaryKey) {
      await _setupTemporaryKey();
    } else {
      await _setupWithApiKey();
    }
  }

  Future<void> _setupTemporaryKey() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final apiManager = ApiKeyManager();
      await apiManager.initialize();
      await apiManager.createTemporaryKey();

      if (mounted) {
        _showSuccessDialog(
          'Quick Start Complete!',
          'You can now chat with Selam, your AI assistant. She has comprehensive knowledge about Ethiopia and will help you with travel questions, cultural insights, and more!',
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Setup failed: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _setupWithApiKey() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final apiManager = ApiKeyManager();
      await apiManager.initialize();
      
      final success = await apiManager.storeOpenaiKey(_apiKeyController.text.trim());
      
      if (success) {
        if (mounted) {
          _showSuccessDialog(
            'API Key Setup Complete!',
            'Your OpenAI API key has been validated and saved. You now have access to the full AI experience with real-time ChatGPT responses!',
          );
        }
      } else {
        setState(() {
          _errorMessage = 'Invalid API key. Please check your key and try again.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Setup failed: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessDialog(String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.success, size: 28),
            const SizedBox(width: 12),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(true); // Close wizard
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
            ),
            child: const Text('Start Chatting'),
          ),
        ],
      ),
    );
  }
}

