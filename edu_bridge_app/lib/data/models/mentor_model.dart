class MentorModel {
  final String? id;
  final String name;
  final String designation;
  final String whatHeDo;
  final String description;
  final String? createdAt;
  final String image; // New image field

  MentorModel({
    this.id,
    required this.name,
    required this.designation,
    required this.whatHeDo,
    required this.description,
    this.createdAt,
    required this.image, // Add image to the constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'designation': designation,
      'what_he_do': whatHeDo,
      'description': description,
      'image': image, // Include image in the map
    };
  }

  factory MentorModel.fromMap(Map<String, dynamic> map) {
    return MentorModel(
      id: map['id'],
      name: map['name'] ?? '',
      designation: map['designation'] ?? '',
      whatHeDo: map['what_he_do'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['created_at'] ?? '',
      image: map['image'] ?? '', // Ensure the image field is handled
    );
  }
}
