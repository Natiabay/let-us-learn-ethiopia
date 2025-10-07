import 'package:flutter/material.dart';
import '../services/voice_service.dart';

/// Speaker Button Widget
/// Provides a reusable button for text-to-speech functionality
class SpeakerButton extends StatefulWidget {
  final String text;
  final String languageCode;
  final Color? color;
  final double size;
  final bool showText;
  final String? tooltip;

  const SpeakerButton({
    Key? key,
    required this.text,
    required this.languageCode,
    this.color,
    this.size = 24.0,
    this.showText = false,
    this.tooltip,
  }) : super(key: key);

  @override
  State<SpeakerButton> createState() => _SpeakerButtonState();
}

class _SpeakerButtonState extends State<SpeakerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (_isSpeaking) {
      await VoiceService.stopSpeaking();
      setState(() {
        _isSpeaking = false;
      });
      return;
    }

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    setState(() {
      _isSpeaking = true;
    });

    try {
      if (widget.languageCode == 'am') {
        await VoiceService.speakAmharic(widget.text);
      } else {
        await VoiceService.speakNative(widget.text, widget.languageCode);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to play audio: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSpeaking = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip ?? 'Listen to pronunciation',
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: _isSpeaking 
                      ? (widget.color ?? Theme.of(context).primaryColor).withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isSpeaking ? Icons.volume_up : Icons.volume_up_outlined,
                      color: _isSpeaking 
                          ? widget.color ?? Theme.of(context).primaryColor
                          : widget.color ?? Colors.grey[600],
                      size: widget.size,
                    ),
                    if (widget.showText) ...[
                      const SizedBox(width: 4),
                      Text(
                        _isSpeaking ? 'Speaking...' : 'Listen',
                        style: TextStyle(
                          color: _isSpeaking 
                              ? widget.color ?? Theme.of(context).primaryColor
                              : widget.color ?? Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Compact Speaker Button for lesson exercises
class CompactSpeakerButton extends StatelessWidget {
  final String text;
  final String languageCode;
  final Color? color;
  final double size;

  const CompactSpeakerButton({
    Key? key,
    required this.text,
    required this.languageCode,
    this.color,
    this.size = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeakerButton(
      text: text,
      languageCode: languageCode,
      color: color,
      size: size,
      tooltip: 'Listen to pronunciation',
    );
  }
}

/// Floating Speaker Button for lesson screens
class FloatingSpeakerButton extends StatelessWidget {
  final String text;
  final String languageCode;
  final Color? backgroundColor;
  final Color? iconColor;

  const FloatingSpeakerButton({
    Key? key,
    required this.text,
    required this.languageCode,
    this.backgroundColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SpeakerButton(
        text: text,
        languageCode: languageCode,
        color: iconColor ?? Colors.white,
        size: 24.0,
        tooltip: 'Listen to pronunciation',
      ),
    );
  }
}












































