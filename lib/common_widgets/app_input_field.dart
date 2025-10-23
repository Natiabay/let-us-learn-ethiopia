import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/core/constants/app_dimensions.dart';

/// Professional input field component following Material Design 3
/// Provides consistent form input experience across the app
class AppInputField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final String? helperText;
  final FocusNode? focusNode;

  const AppInputField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.errorText,
    this.helperText,
    this.focusNode,
  });

  /// Email input field constructor
  const AppInputField.email({
    super.key,
    this.label = 'Email',
    this.hint = 'Enter your email address',
    this.initialValue,
    this.controller,
    this.enabled = true,
    this.readOnly = false,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.errorText,
    this.helperText,
    this.focusNode,
  }) : keyboardType = TextInputType.emailAddress,
       textInputAction = TextInputAction.next,
       obscureText = false,
       maxLines = 1,
       maxLength = null,
       prefixIcon = Icons.email_outlined,
       suffixIcon = null,
       inputFormatters = null;

  /// Password input field constructor
  const AppInputField.password({
    super.key,
    this.label = 'Password',
    this.hint = 'Enter your password',
    this.initialValue,
    this.controller,
    this.enabled = true,
    this.readOnly = false,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.errorText,
    this.helperText,
    this.focusNode,
  }) : keyboardType = TextInputType.visiblePassword,
       textInputAction = TextInputAction.done,
       obscureText = true,
       maxLines = 1,
       maxLength = null,
       prefixIcon = Icons.lock_outline_rounded,
       suffixIcon = null,
       inputFormatters = null;

  /// Search input field constructor
  const AppInputField.search({
    super.key,
    this.label,
    this.hint = 'Search...',
    this.initialValue,
    this.controller,
    this.enabled = true,
    this.readOnly = false,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.errorText,
    this.helperText,
    this.focusNode,
  }) : keyboardType = TextInputType.text,
       textInputAction = TextInputAction.search,
       obscureText = false,
       maxLines = 1,
       maxLength = null,
       prefixIcon = Icons.search_rounded,
       suffixIcon = null,
       inputFormatters = null;

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  late bool _obscureText;
  late TextEditingController _controller;
  bool _isControllerInternal = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController(text: widget.initialValue);
      _isControllerInternal = true;
    }
  }

  @override
  void dispose() {
    if (_isControllerInternal) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing8),
        ],

        // Input Field
        TextFormField(
          controller: _controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: _obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onFieldSubmitted: widget.onSubmitted,
          inputFormatters: widget.inputFormatters,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: widget.enabled ? AppColors.textPrimary : AppColors.textDisabled,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textTertiary,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: widget.enabled ? AppColors.textSecondary : AppColors.textDisabled,
                  )
                : null,
            suffixIcon: _buildSuffixIcon(),
            errorText: widget.errorText,
            helperText: widget.helperText,
            helperStyle: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
            errorStyle: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.accent,
            ),
            filled: true,
            fillColor: widget.enabled ? AppColors.surface : AppColors.grey100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.grey300,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.grey300,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.accent,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.accent,
                width: 2.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.grey200,
                width: 1.0,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.inputPadding,
              vertical: AppDimensions.spacing12,
            ),
            counterStyle: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    // Password visibility toggle
    if (widget.obscureText) {
      return IconButton(
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: Icon(
          _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColors.textSecondary,
        ),
      );
    }

    // Clear button for search fields
    if (widget.keyboardType == TextInputType.text && 
        widget.prefixIcon == Icons.search_rounded &&
        _controller.text.isNotEmpty) {
      return IconButton(
        onPressed: () {
          _controller.clear();
          if (widget.onChanged != null) {
            widget.onChanged!('');
          }
        },
        icon: const Icon(
          Icons.clear_rounded,
          color: AppColors.textSecondary,
        ),
      );
    }

    return widget.suffixIcon;
  }
}

/// Dropdown field component for selection inputs
class AppDropdownField<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool enabled;
  final IconData? prefixIcon;
  final String? errorText;
  final String? helperText;

  const AppDropdownField({
    super.key,
    this.label,
    this.hint,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.prefixIcon,
    this.errorText,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppDimensions.spacing8),
        ],

        // Dropdown Field
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: enabled ? onChanged : null,
          validator: validator,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: enabled ? AppColors.textPrimary : AppColors.textDisabled,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textTertiary,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: enabled ? AppColors.textSecondary : AppColors.textDisabled,
                  )
                : null,
            errorText: errorText,
            helperText: helperText,
            helperStyle: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
            errorStyle: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.accent,
            ),
            filled: true,
            fillColor: enabled ? AppColors.surface : AppColors.grey100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.grey300,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.grey300,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.accent,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.accent,
                width: 2.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.grey200,
                width: 1.0,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.inputPadding,
              vertical: AppDimensions.spacing12,
            ),
          ),
          dropdownColor: AppColors.surface,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

