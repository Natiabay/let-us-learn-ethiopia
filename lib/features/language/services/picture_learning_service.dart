import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pictureLearningServiceProvider = Provider<PictureLearningService>((ref) {
  return PictureLearningService();
});

class PictureLearningService {
  final ImagePicker _imagePicker = ImagePicker();
  List<CameraDescription>? _cameras;

  Future<void> initialize() async {
    try {
      _cameras = await availableCameras();
    } catch (e) {
      debugPrint('Camera initialization error: $e');
    }
  }

  // Get picture for a word
  Future<PictureData?> getPictureForWord(String word, String category) async {
    try {
      // In a real app, you would fetch from a database or API
      // For now, we'll return mock data
      return _getMockPictureData(word, category);
    } catch (e) {
      debugPrint('Get picture error: $e');
      return null;
    }
  }

  // Take picture with camera
  Future<PictureData?> takePicture() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        return PictureData(
          imagePath: image.path,
          source: PictureSource.camera,
          timestamp: DateTime.now(),
        );
      }
    } catch (e) {
      debugPrint('Take picture error: $e');
    }
    return null;
  }

  // Pick picture from gallery
  Future<PictureData?> pickPictureFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        return PictureData(
          imagePath: image.path,
          source: PictureSource.gallery,
          timestamp: DateTime.now(),
        );
      }
    } catch (e) {
      debugPrint('Pick picture error: $e');
    }
    return null;
  }

  // Download picture from URL
  Future<PictureData?> downloadPicture(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final picturesDir = Directory('${directory.path}/pictures');
        if (!await picturesDir.exists()) {
          await picturesDir.create(recursive: true);
        }

        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        final filePath = '${picturesDir.path}/$fileName';
        final file = File(filePath);
        
        await file.writeAsBytes(response.bodyBytes);
        
        return PictureData(
          imagePath: filePath,
          source: PictureSource.network,
          timestamp: DateTime.now(),
        );
      }
    } catch (e) {
      debugPrint('Download picture error: $e');
    }
    return null;
  }

  // Get mock picture data for demo
  PictureData? _getMockPictureData(String word, String category) {
    final mockPictures = {
      'Hello': PictureData(
        imagePath: 'assets/images/greetings.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'A friendly greeting gesture',
        tags: ['greeting', 'friendly', 'welcome'],
      ),
      'Coffee': PictureData(
        imagePath: 'assets/images/coffee.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'Traditional Ethiopian coffee ceremony',
        tags: ['coffee', 'ceremony', 'traditional', 'ethiopian'],
      ),
      'Injera': PictureData(
        imagePath: 'assets/images/injera.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'Traditional Ethiopian flatbread',
        tags: ['injera', 'bread', 'traditional', 'ethiopian', 'food'],
      ),
      'One': PictureData(
        imagePath: 'assets/images/one.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'Number one',
        tags: ['number', 'one', 'counting'],
      ),
      'Two': PictureData(
        imagePath: 'assets/images/two.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'Number two',
        tags: ['number', 'two', 'counting'],
      ),
      'Three': PictureData(
        imagePath: 'assets/images/three.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'Number three',
        tags: ['number', 'three', 'counting'],
      ),
      'Milk': PictureData(
        imagePath: 'assets/images/milk.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'Fresh milk',
        tags: ['milk', 'dairy', 'drink'],
      ),
      'Water': PictureData(
        imagePath: 'assets/images/water.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'Clean water',
        tags: ['water', 'drink', 'liquid'],
      ),
      'Food': PictureData(
        imagePath: 'assets/images/food.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'Traditional Ethiopian food',
        tags: ['food', 'ethiopian', 'traditional', 'meal'],
      ),
      'Hotel': PictureData(
        imagePath: 'assets/images/hotel.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'Hotel building',
        tags: ['hotel', 'accommodation', 'building'],
      ),
      'Restaurant': PictureData(
        imagePath: 'assets/images/Restaurant.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'Restaurant',
        tags: ['restaurant', 'food', 'dining'],
      ),
      'Market': PictureData(
        imagePath: 'assets/images/Logo.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'Local market',
        tags: ['market', 'shopping', 'local'],
      ),
      'Hospital': PictureData(
        imagePath: 'assets/images/hospital.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'Hospital building',
        tags: ['hospital', 'medical', 'health'],
      ),
      'Police': PictureData(
        imagePath: 'assets/images/polices.png',
        source: PictureSource.asset,
        timestamp: DateTime.now(),
        description: 'Police officer',
        tags: ['police', 'officer', 'security'],
      ),
    };

    return mockPictures[word];
  }

  // Get pictures by category
  Future<List<PictureData>> getPicturesByCategory(String category) async {
    try {
      // In a real app, you would fetch from a database
      // For now, return mock data
      return _getMockPicturesByCategory(category);
    } catch (e) {
      debugPrint('Get pictures by category error: $e');
      return [];
    }
  }

  List<PictureData> _getMockPicturesByCategory(String category) {
    final categoryPictures = {
      'greetings': [
        PictureData(
          imagePath: 'assets/images/greetings.png',
          source: PictureSource.asset,
          timestamp: DateTime.now(),
          description: 'A friendly greeting gesture',
          tags: ['greeting', 'friendly', 'welcome'],
        ),
      ],
      'food': [
        PictureData(
          imagePath: 'assets/images/coffee.png',
          source: PictureSource.asset,
          timestamp: DateTime.now(),
          description: 'Traditional Ethiopian coffee ceremony',
          tags: ['coffee', 'ceremony', 'traditional', 'ethiopian'],
        ),
        PictureData(
          imagePath: 'assets/images/injera.png',
          source: PictureSource.asset,
          timestamp: DateTime.now(),
          description: 'Traditional Ethiopian flatbread',
          tags: ['injera', 'bread', 'traditional', 'ethiopian', 'food'],
        ),
        PictureData(
          imagePath: 'assets/images/food.png',
          source: PictureSource.asset,
          timestamp: DateTime.now(),
          description: 'Traditional Ethiopian food',
          tags: ['food', 'ethiopian', 'traditional', 'meal'],
        ),
      ],
      'numbers': [
        PictureData(
          imagePath: 'assets/images/one.png',
          source: PictureSource.asset,
          timestamp: DateTime.now(),
          description: 'Number one',
          tags: ['number', 'one', 'counting'],
        ),
        PictureData(
          imagePath: 'assets/images/two.png',
          source: PictureSource.asset,
          timestamp: DateTime.now(),
          description: 'Number two',
          tags: ['number', 'two', 'counting'],
        ),
        PictureData(
          imagePath: 'assets/images/three.png',
          source: PictureSource.asset,
          timestamp: DateTime.now(),
          description: 'Number three',
          tags: ['number', 'three', 'counting'],
        ),
      ],
      'places': [
        PictureData(
          imagePath: 'assets/images/hotel.png',
          source: PictureSource.asset,
          timestamp: DateTime.now(),
          description: 'Hotel building',
          tags: ['hotel', 'accommodation', 'building'],
        ),
        PictureData(
          imagePath: 'assets/images/Restaurant.png',
          source: PictureSource.asset,
          timestamp: DateTime.now(),
          description: 'Restaurant',
          tags: ['restaurant', 'food', 'dining'],
        ),
        PictureData(
          imagePath: 'assets/images/Logo.png',
          source: PictureSource.asset,
          timestamp: DateTime.now(),
          description: 'Local market',
          tags: ['market', 'shopping', 'local'],
        ),
        PictureData(
          imagePath: 'assets/images/hospital.png',
          source: PictureSource.asset,
          timestamp: DateTime.now(),
          description: 'Hospital building',
          tags: ['hospital', 'medical', 'health'],
        ),
      ],
    };

    return categoryPictures[category] ?? [];
  }

  // Save picture to favorites
  Future<void> saveToFavorites(PictureData picture) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final favoritesDir = Directory('${directory.path}/favorites');
      if (!await favoritesDir.exists()) {
        await favoritesDir.create(recursive: true);
      }

      // In a real app, you would save to a database
      debugPrint('Picture saved to favorites: ${picture.imagePath}');
    } catch (e) {
      debugPrint('Save to favorites error: $e');
    }
  }

  // Get favorite pictures
  Future<List<PictureData>> getFavoritePictures() async {
    try {
      // In a real app, you would fetch from a database
      return [];
    } catch (e) {
      debugPrint('Get favorites error: $e');
      return [];
    }
  }

  // Delete picture
  Future<void> deletePicture(PictureData picture) async {
    try {
      if (picture.source == PictureSource.camera || 
          picture.source == PictureSource.gallery ||
          picture.source == PictureSource.network) {
        final file = File(picture.imagePath);
        if (await file.exists()) {
          await file.delete();
        }
      }
    } catch (e) {
      debugPrint('Delete picture error: $e');
    }
  }

  // Get camera count
  int get cameraCount => _cameras?.length ?? 0;

  // Get cameras
  List<CameraDescription>? get cameras => _cameras;
}

class PictureData {
  final String imagePath;
  final PictureSource source;
  final DateTime timestamp;
  final String? description;
  final List<String> tags;

  PictureData({
    required this.imagePath,
    required this.source,
    required this.timestamp,
    this.description,
    this.tags = const [],
  });
}

enum PictureSource {
  asset,
  network,
  camera,
  gallery,
}

