import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final bool emailVerified;
  final bool isAdmin;
  
  const AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    required this.emailVerified,
    this.isAdmin = false,
  });
  
  // Admin email constant
  static const String adminEmail = 'kiru72fekadu@gmail.com';
  
  factory AppUser.fromFirebaseUser(User user) {
    // Enhanced admin detection with multiple checks
    final userEmail = user.email?.toLowerCase().trim() ?? '';
    final adminEmailLower = adminEmail.toLowerCase().trim();
    final isAdminByEmail = userEmail == adminEmailLower;
    
    print('🔍 AppUser.fromFirebaseUser: ${user.email} -> isAdmin: $isAdminByEmail');
    print('🔍 Enhanced comparison:');
    print('  - User email: "$userEmail"');
    print('  - Admin email: "$adminEmailLower"');
    print('  - Match: $isAdminByEmail');
    print('  - Admin email constant: $adminEmail');
    
    if (isAdminByEmail) {
      print('✅ ADMIN USER DETECTED: ${user.email}');
      print('✅ Admin verification successful');
    }
    
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
      emailVerified: user.emailVerified,
      isAdmin: isAdminByEmail,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'emailVerified': emailVerified,
      'isAdmin': isAdmin,
    };
  }
  
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      emailVerified: json['emailVerified'] as bool? ?? false,
      isAdmin: json['isAdmin'] as bool? ?? false,
    );
  }
  
  // Helper method to check if user is admin
  bool get isAdminUser => isAdmin;
}