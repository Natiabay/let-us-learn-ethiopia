import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LocationsColors {
  static const deepNavy = Color(0xFF0A1929);
  static const navyCard = Color(0xFF1A2F44);
  static const turquoise = Color(0xFF00D9B8);
  static const brightYellow = Color(0xFFFFD43B);
  static const brightBlue = Color(0xFF1CB0F6);
  static const brightGreen = Color(0xFF4CAF50);
  static const brightRed = Color(0xFFFF4B4B);
  static const pureWhite = Color(0xFFFFFFFF);
  static const lightGray = Color(0xFFE2E8F0);
  static const mediumGray = Color(0xFF94A3B8);
}

/// AR View Screen - Placeholder for future AR implementation
class ARLocationViewScreen extends StatefulWidget {
  final String locationName;
  final String locationImage;

  const ARLocationViewScreen({
    super.key,
    required this.locationName,
    required this.locationImage,
  });

  @override
  State<ARLocationViewScreen> createState() => _ARLocationViewScreenState();
}

class _ARLocationViewScreenState extends State<ARLocationViewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LocationsColors.deepNavy,
      body: Stack(
        children: [
          _buildARViewPlaceholder(),
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                const Spacer(),
                _buildBottomControls(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildARViewPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            LocationsColors.deepNavy,
            LocationsColors.navyCard,
            LocationsColors.deepNavy,
          ],
        ),
      ),
      child: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Image.asset(
              widget.locationImage,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: LocationsColors.navyCard,
                );
              },
            ),
          ),
          if (_isScanning)
            Center(
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    width: 200 + (_pulseController.value * 50),
                    height: 200 + (_pulseController.value * 50),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: LocationsColors.turquoise.withValues(
                          alpha: 1 - _pulseController.value,
                        ),
                        width: 2,
                      ),
                    ),
                  );
                },
              ),
            ),
          CustomPaint(
            size: Size.infinite,
            painter: _ARGridPainter(
              color: LocationsColors.turquoise.withValues(alpha: 0.2),
            ),
          ),
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: LocationsColors.turquoise,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt_rounded,
                    color: LocationsColors.turquoise,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _isScanning ? 'Scanning...' : 'Point at location',
                    style: const TextStyle(
                      color: LocationsColors.pureWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.locationName,
                    style: const TextStyle(
                      color: LocationsColors.lightGray,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                  duration: 2000.ms,
                  color: LocationsColors.turquoise.withValues(alpha: 0.3),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: LocationsColors.pureWhite,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.view_in_ar_rounded,
                  color: LocationsColors.turquoise,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'AR View',
                  style: TextStyle(
                    color: LocationsColors.pureWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.info_outline_rounded),
              color: LocationsColors.pureWhite,
              onPressed: _showARInfo,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildARFeatureButton(
                Icons.view_in_ar_rounded,
                '360° View',
                () => _show360View(),
              ),
              _buildARFeatureButton(
                Icons.camera_rounded,
                'Capture',
                () => _captureARPhoto(),
              ),
              _buildARFeatureButton(
                Icons.info_rounded,
                'Info',
                () => _showLocationInfo(),
              ),
              _buildARFeatureButton(
                Icons.share_rounded,
                'Share',
                () => _shareAR(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isScanning = !_isScanning;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isScanning
                    ? LocationsColors.brightRed
                    : LocationsColors.turquoise,
                foregroundColor: LocationsColors.deepNavy,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isScanning
                        ? Icons.stop_rounded
                        : Icons.radar_rounded,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isScanning ? 'Stop Scanning' : 'Start AR Scan',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildARFeatureButton(
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: LocationsColors.navyCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: LocationsColors.turquoise.withValues(alpha: 0.3),
            ),
          ),
          child: IconButton(
            icon: Icon(icon),
            color: LocationsColors.turquoise,
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: LocationsColors.lightGray,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  void _showARInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: LocationsColors.navyCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.view_in_ar_rounded,
                color: LocationsColors.turquoise,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'AR View Info',
                  style: TextStyle(
                    color: LocationsColors.pureWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: const Text(
            'AR (Augmented Reality) View allows you to:\n\n'
            '• View locations in 3D space\n'
            '• Get real-time information overlays\n'
            '• Take immersive photos\n'
            '• Navigate with AR directions\n\n'
            'Note: This is a preview feature. Full AR functionality coming soon!',
            style: TextStyle(
              color: LocationsColors.lightGray,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Got it',
                style: TextStyle(
                  color: LocationsColors.turquoise,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show360View() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('360° View feature coming soon!'),
        backgroundColor: LocationsColors.navyCard,
      ),
    );
  }

  void _captureARPhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('AR Photo captured! (Preview feature)'),
        backgroundColor: LocationsColors.navyCard,
      ),
    );
  }

  void _showLocationInfo() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: LocationsColors.deepNavy,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: LocationsColors.mediumGray,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.locationName,
                style: const TextStyle(
                  color: LocationsColors.pureWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'AR information and details would appear here with interactive elements.',
                style: TextStyle(
                  color: LocationsColors.lightGray,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _shareAR() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('AR experience shared! (Preview feature)'),
        backgroundColor: LocationsColors.navyCard,
      ),
    );
  }
}

class _ARGridPainter extends CustomPainter {
  final Color color;

  const _ARGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const gridSpacing = 50.0;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += gridSpacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += gridSpacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ARGridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
