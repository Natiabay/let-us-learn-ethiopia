class TourGuide {
  final String id;
  final String name;
  final String photoUrl;
  final double rating;
  final int reviewCount;
  final List<String> languages;
  final List<String> specialties;
  final String bio;
  final int yearsOfExperience;
  final bool isVerified;
  final String phone;
  final String email;

  const TourGuide({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.rating,
    required this.reviewCount,
    required this.languages,
    required this.specialties,
    required this.bio,
    required this.yearsOfExperience,
    required this.isVerified,
    required this.phone,
    required this.email,
  });
}

// Sample tour guides data
class EthiopianTourGuides {
  static List<TourGuide> get all => [
    const TourGuide(
      id: 'guide-1',
      name: 'Abebe Tadesse',
      photoUrl: 'assets/images/Logo.png',
      rating: 4.9,
      reviewCount: 234,
      languages: ['Amharic', 'English', 'French'],
      specialties: ['Historical Sites', 'Religious Tours', 'Cultural Heritage'],
      bio: 'Expert in Ethiopian history with 15 years of experience. Specializes in Lalibela and ancient church tours.',
      yearsOfExperience: 15,
      isVerified: true,
      phone: '+251-911-234567',
      email: 'abebe.tours@ethiopia.et',
    ),
    const TourGuide(
      id: 'guide-2',
      name: 'Tigist Bekele',
      photoUrl: 'assets/images/Logo.png',
      rating: 4.8,
      reviewCount: 189,
      languages: ['Amharic', 'English', 'German', 'Spanish'],
      specialties: ['Nature & Wildlife', 'Trekking', 'Photography Tours'],
      bio: 'Wildlife expert and mountain guide. Passionate about Simien and Bale Mountains ecosystems.',
      yearsOfExperience: 10,
      isVerified: true,
      phone: '+251-911-345678',
      email: 'tigist.nature@ethiopia.et',
    ),
    const TourGuide(
      id: 'guide-3',
      name: 'Solomon Gebre',
      photoUrl: 'assets/images/Logo.png',
      rating: 4.7,
      reviewCount: 156,
      languages: ['Amharic', 'English', 'Italian', 'Arabic'],
      specialties: ['Adventure Tours', 'Danakil Depression', 'Geological Tours'],
      bio: 'Adventure specialist with extensive knowledge of Ethiopia\'s unique geological formations.',
      yearsOfExperience: 12,
      isVerified: true,
      phone: '+251-911-456789',
      email: 'solomon.adventure@ethiopia.et',
    ),
    const TourGuide(
      id: 'guide-4',
      name: 'Hanna Alemayehu',
      photoUrl: 'assets/images/Logo.png',
      rating: 4.9,
      reviewCount: 278,
      languages: ['Amharic', 'English', 'Mandarin'],
      specialties: ['Cultural Tours', 'Coffee Tours', 'Local Cuisine'],
      bio: 'Cultural ambassador showcasing Ethiopia\'s rich traditions, coffee heritage, and culinary excellence.',
      yearsOfExperience: 8,
      isVerified: true,
      phone: '+251-911-567890',
      email: 'hanna.culture@ethiopia.et',
    ),
  ];
}


