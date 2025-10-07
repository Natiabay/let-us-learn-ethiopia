class LocationModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String city;
  final double latitude;
  final double longitude;
  final double rating;
  final String imageUrl;
  final bool isFavorite;
  final String openingHours;
  final String entryFee;
  final List<String> features;
  
  // Global location fields
  final String? country;
  final String? region;
  final bool? isEthiopian;
  final int? priority;
  final List<String>? tags;

  const LocationModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.imageUrl,
    required this.isFavorite,
    required this.openingHours,
    required this.entryFee,
    required this.features,
    this.country,
    this.region,
    this.isEthiopian,
    this.priority,
    this.tags,
  });

  LocationModel copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? city,
    double? latitude,
    double? longitude,
    double? rating,
    String? imageUrl,
    bool? isFavorite,
    String? openingHours,
    String? entryFee,
    List<String>? features,
    String? country,
    String? region,
    bool? isEthiopian,
    int? priority,
    List<String>? tags,
  }) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      openingHours: openingHours ?? this.openingHours,
      entryFee: entryFee ?? this.entryFee,
      features: features ?? this.features,
      country: country ?? this.country,
      region: region ?? this.region,
      isEthiopian: isEthiopian ?? this.isEthiopian,
      priority: priority ?? this.priority,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
      'openingHours': openingHours,
      'entryFee': entryFee,
      'features': features,
      'country': country,
      'region': region,
      'isEthiopian': isEthiopian,
      'priority': priority,
      'tags': tags,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      city: json['city'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      isFavorite: json['isFavorite'] as bool,
      openingHours: json['openingHours'] as String,
      entryFee: json['entryFee'] as String,
      features: List<String>.from(json['features'] as List),
      country: json['country'] as String?,
      region: json['region'] as String?,
      isEthiopian: json['isEthiopian'] as bool?,
      priority: json['priority'] as int?,
      tags: json['tags'] != null ? List<String>.from(json['tags'] as List) : null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LocationModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}



