import 'package:flutter/material.dart';
import '../services/voice_service.dart';
import '../../../core/services/audio_service.dart';

/// Test widget for voice functionality
/// This widget can be used to test TTS functionality
class VoiceTestWidget extends StatefulWidget {
  const VoiceTestWidget({Key? key}) : super(key: key);

  @override
  State<VoiceTestWidget> createState() => _VoiceTestWidgetState();
}

class _VoiceTestWidgetState extends State<VoiceTestWidget> {
  final AudioService _audioService = AudioService();
  bool _isSpeaking = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Voice Test',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Amharic test
          Row(
            children: [
              Expanded(
                child: Text('Amharic: ሰላም (Hello)'),
              ),
              IconButton(
                onPressed: _isSpeaking ? null : () => _testAmharic(),
                icon: Icon(
                  _isSpeaking ? Icons.volume_up : Icons.volume_up_outlined,
                  color: _isSpeaking ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // English test
          Row(
            children: [
              Expanded(
                child: Text('English: Hello'),
              ),
              IconButton(
                onPressed: _isSpeaking ? null : () => _testEnglish(),
                icon: Icon(
                  _isSpeaking ? Icons.volume_up : Icons.volume_up_outlined,
                  color: _isSpeaking ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Status
          Text(
            _isSpeaking ? 'Speaking...' : 'Ready to test',
            style: TextStyle(
              color: _isSpeaking ? Colors.blue : Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _testAmharic() async {
    setState(() {
      _isSpeaking = true;
    });

    try {
      await _audioService.speakAmharic('ሰላም');
      print('✅ Amharic TTS test completed');
    } catch (e) {
      print('❌ Amharic TTS test failed: $e');
    } finally {
      setState(() {
        _isSpeaking = false;
      });
    }
  }

  Future<void> _testEnglish() async {
    setState(() {
      _isSpeaking = true;
    });

    try {
      await _audioService.speakEnglish('Hello');
      print('✅ English TTS test completed');
    } catch (e) {
      print('❌ English TTS test failed: $e');
    } finally {
      setState(() {
        _isSpeaking = false;
      });
    }
  }
}
