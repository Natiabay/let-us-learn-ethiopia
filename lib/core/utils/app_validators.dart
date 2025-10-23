/// Professional form validation utilities
/// Provides consistent validation logic across the app
class AppValidators {
  // Private constructor to prevent instantiation
  AppValidators._();

  /// Email validation regex pattern
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// Phone number validation regex pattern (Ethiopian format)
  static final RegExp _phoneRegex = RegExp(
    r'^(\+251|0)[79]\d{8}$',
  );

  /// Password validation regex pattern
  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$',
  );

  /// Validates email address format
  /// Returns null if valid, error message if invalid
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  /// Validates password strength
  /// Returns null if valid, error message if invalid
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    
    if (!_passwordRegex.hasMatch(value)) {
      return 'Password must contain uppercase, lowercase, and number';
    }
    
    return null;
  }

  /// Validates password confirmation
  /// Returns null if valid, error message if invalid
  static String? validatePasswordConfirmation(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  /// Validates phone number (Ethiopian format)
  /// Returns null if valid, error message if invalid
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    if (!_phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid Ethiopian phone number';
    }
    
    return null;
  }

  /// Validates required text field
  /// Returns null if valid, error message if invalid
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    return null;
  }

  /// Validates name field (letters and spaces only)
  /// Returns null if valid, error message if invalid
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }
    
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
      return 'Name can only contain letters and spaces';
    }
    
    return null;
  }

  /// Validates age (must be between min and max)
  /// Returns null if valid, error message if invalid
  static String? validateAge(String? value, {int min = 13, int max = 120}) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    
    final age = int.tryParse(value);
    if (age == null) {
      return 'Please enter a valid age';
    }
    
    if (age < min || age > max) {
      return 'Age must be between $min and $max';
    }
    
    return null;
  }

  /// Validates URL format
  /// Returns null if valid, error message if invalid
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }
    
    try {
      final uri = Uri.parse(value.trim());
      if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
        return 'Please enter a valid URL (starting with http:// or https://)';
      }
    } catch (e) {
      return 'Please enter a valid URL';
    }
    
    return null;
  }

  /// Validates text length within specified range
  /// Returns null if valid, error message if invalid
  static String? validateLength(
    String? value, {
    int? minLength,
    int? maxLength,
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    final length = value.trim().length;
    
    if (minLength != null && length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters long';
    }
    
    if (maxLength != null && length > maxLength) {
      return '${fieldName ?? 'This field'} must be no more than $maxLength characters long';
    }
    
    return null;
  }

  /// Validates numeric input within specified range
  /// Returns null if valid, error message if invalid
  static String? validateNumber(
    String? value, {
    double? min,
    double? max,
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    final number = double.tryParse(value.trim());
    if (number == null) {
      return 'Please enter a valid number';
    }
    
    if (min != null && number < min) {
      return '${fieldName ?? 'Value'} must be at least $min';
    }
    
    if (max != null && number > max) {
      return '${fieldName ?? 'Value'} must be no more than $max';
    }
    
    return null;
  }

  /// Combines multiple validators
  /// Returns the first error found, or null if all pass
  static String? combineValidators(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}

