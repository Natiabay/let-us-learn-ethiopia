import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const UrlLauncherTestApp());
}

class UrlLauncherTestApp extends StatelessWidget {
  const UrlLauncherTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Launcher Test',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('URL Launcher Test'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Testing URL Launcher Package'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final Uri phoneUri = Uri(scheme: 'tel', path: '+1234567890');
                  if (await canLaunchUrl(phoneUri)) {
                    await launchUrl(phoneUri);
                  }
                },
                child: const Text('Test Phone Call'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final Uri emailUri = Uri(scheme: 'mailto', path: 'test@example.com');
                  if (await canLaunchUrl(emailUri)) {
                    await launchUrl(emailUri);
                  }
                },
                child: const Text('Test Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

