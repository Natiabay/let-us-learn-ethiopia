class Location {
  final String id;
  final String name;
  final String description;
  final String category;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final double rating;
  final int reviewCount;
  final String price;
  final String openingHours;
  final bool isOpen;
  final bool isFavorite;
  final List<String> tags;
  final List<String> facilities;
  final String? website;
  final String? phone;
  final String? address;

  const Location({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.openingHours,
    required this.isOpen,
    required this.isFavorite,
    required this.tags,
    required this.facilities,
    this.website,
    this.phone,
    this.address,
  });

  Location copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? imageUrl,
    double? latitude,
    double? longitude,
    double? rating,
    int? reviewCount,
    String? price,
    String? openingHours,
    bool? isOpen,
    bool? isFavorite,
    List<String>? tags,
    List<String>? facilities,
    String? website,
    String? phone,
    String? address,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      price: price ?? this.price,
      openingHours: openingHours ?? this.openingHours,
      isOpen: isOpen ?? this.isOpen,
      isFavorite: isFavorite ?? this.isFavorite,
      tags: tags ?? this.tags,
      facilities: facilities ?? this.facilities,
      website: website ?? this.website,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'reviewCount': reviewCount,
      'price': price,
      'openingHours': openingHours,
      'isOpen': isOpen,
      'isFavorite': isFavorite,
      'tags': tags,
      'facilities': facilities,
      'website': website,
      'phone': phone,
      'address': address,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      rating: map['rating']?.toDouble() ?? 0.0,
      reviewCount: map['reviewCount']?.toInt() ?? 0,
      price: map['price'] ?? '',
      openingHours: map['openingHours'] ?? '',
      isOpen: map['isOpen'] ?? false,
      isFavorite: map['isFavorite'] ?? false,
      tags: List<String>.from(map['tags'] ?? []),
      facilities: List<String>.from(map['facilities'] ?? []),
      website: map['website'],
      phone: map['phone'],
      address: map['address'],
    );
  }
}




















