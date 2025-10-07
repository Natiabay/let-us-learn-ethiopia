#!/usr/bin/env dart

/// Script to create admin user in Firebase Auth
/// Run with: dart scripts/create_admin_user.dart

import 'dart:io';

void main() async {
  print('🔧 Admin User Creation Script');
  print('============================');
  print('');
  print('This script will help you create the admin user in Firebase.');
  print('');
  print('Admin Credentials:');
  print('  Email: kiru72fekadu@gmail.com');
  print('  Password: 12332122');
  print('');
  print('Please follow these steps:');
  print('');
  print('1. Go to Firebase Console: https://console.firebase.google.com/');
  print('2. Select your project: ethiopia-tourist-app-2024');
  print('3. Go to Authentication > Users');
  print('4. Click "Add user"');
  print('5. Enter the email: kiru72fekadu@gmail.com');
  print('6. Enter the password: 12332122');
  print('7. Click "Add user"');
  print('');
  print('Alternatively, you can use Firebase CLI:');
  print('  firebase auth:import users.json');
  print('');
  print('Or create the user programmatically in your app:');
  print('  - Sign up with the admin email/password');
  print('  - The app will automatically detect admin status');
  print('');
  print('✅ After creating the user, the admin dashboard will be accessible!');
  print('');
  
  // Check if Firebase CLI is available
  try {
    final result = await Process.run('firebase', ['--version']);
    if (result.exitCode == 0) {
      print('🔧 Firebase CLI detected: ${result.stdout}');
      print('');
      print('You can also create the user using Firebase CLI:');
      print('  firebase auth:export users.json --project ethiopia-tourist-app-2024');
      print('');
    }
  } catch (e) {
    print('⚠️  Firebase CLI not found. Please use the manual method above.');
  }
  
  print('Press Enter to continue...');
  stdin.readLineSync();
}



















