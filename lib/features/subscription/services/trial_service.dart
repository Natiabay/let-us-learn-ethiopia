import 'package:shared_preferences/shared_preferences.dart';

class TrialService {
  static const String _trialStartDateKey = 'trial_start_date';
  static const String _trialActivatedKey = 'trial_activated';
  static const String _trialExpiredKey = 'trial_expired';
  static const String _hasPaidKey = 'has_paid';
  static const int _trialDurationDays = 30; // 1 month

  // Initialize trial for new users
  static Future<void> initializeTrial() async {
    final prefs = await SharedPreferences.getInstance();
    final isActivated = prefs.getBool(_trialActivatedKey) ?? false;
    
    if (!isActivated) {
      final now = DateTime.now();
      await prefs.setString(_trialStartDateKey, now.toIso8601String());
      await prefs.setBool(_trialActivatedKey, true);
      await prefs.setBool(_trialExpiredKey, false);
      await prefs.setBool(_hasPaidKey, false);
    }
  }

  // Check if user has active trial
  static Future<bool> hasActiveTrial() async {
    final prefs = await SharedPreferences.getInstance();
    final isActivated = prefs.getBool(_trialActivatedKey) ?? false;
    final isExpired = prefs.getBool(_trialExpiredKey) ?? false;
    final hasPaid = prefs.getBool(_hasPaidKey) ?? false;
    
    if (hasPaid) return true; // User has paid, unlimited access
    
    if (!isActivated) return false; // Trial not started
    
    if (isExpired) return false; // Trial expired
    
    // Check if trial is still within 30 days
    final startDateStr = prefs.getString(_trialStartDateKey);
    if (startDateStr == null) return false;
    
    final startDate = DateTime.parse(startDateStr);
    final now = DateTime.now();
    final daysPassed = now.difference(startDate).inDays;
    
    if (daysPassed >= _trialDurationDays) {
      await prefs.setBool(_trialExpiredKey, true);
      return false;
    }
    
    return true;
  }

  // Get trial days remaining
  static Future<int> getTrialDaysRemaining() async {
    final prefs = await SharedPreferences.getInstance();
    final hasPaid = prefs.getBool(_hasPaidKey) ?? false;
    
    if (hasPaid) return -1; // Unlimited access
    
    final startDateStr = prefs.getString(_trialStartDateKey);
    if (startDateStr == null) return 0;
    
    final startDate = DateTime.parse(startDateStr);
    final now = DateTime.now();
    final daysPassed = now.difference(startDate).inDays;
    final daysRemaining = _trialDurationDays - daysPassed;
    
    return daysRemaining > 0 ? daysRemaining : 0;
  }

  // Get trial start date
  static Future<DateTime?> getTrialStartDate() async {
    final prefs = await SharedPreferences.getInstance();
    final startDateStr = prefs.getString(_trialStartDateKey);
    if (startDateStr == null) return null;
    return DateTime.parse(startDateStr);
  }

  // Mark user as paid
  static Future<void> markAsPaid() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasPaidKey, true);
  }

  // Check if user has paid
  static Future<bool> hasPaid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasPaidKey) ?? false;
  }

  // Get trial status info
  static Future<Map<String, dynamic>> getTrialStatus() async {
    final hasActive = await hasActiveTrial();
    final daysRemaining = await getTrialDaysRemaining();
    final userHasPaid = await hasPaid();
    final startDate = await getTrialStartDate();
    
    return {
      'hasAccess': hasActive || userHasPaid,
      'isTrialActive': hasActive && !userHasPaid,
      'trialDaysLeft': daysRemaining,
      'needsPayment': !hasActive && !userHasPaid,
      'hasPaid': userHasPaid,
      'trialStartDate': startDate,
      'trialDuration': _trialDurationDays,
    };
  }

  // Reset trial (for testing)
  static Future<void> resetTrial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_trialStartDateKey);
    await prefs.remove(_trialActivatedKey);
    await prefs.remove(_trialExpiredKey);
    await prefs.remove(_hasPaidKey);
  }
}
