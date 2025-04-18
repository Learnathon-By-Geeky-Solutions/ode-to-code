class MentorModel {
  final String? id;
  final String name;
  final String designation;
  final String whatHeDo;
  final String description;
  final String? createdAt;
  final String image;

  MentorModel({
    this.id,
    required this.name,
    required this.designation,
    required this.whatHeDo,
    required this.description,
    this.createdAt,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'designation': designation,
      'what_he_do': whatHeDo,
      'description': description,
      'image': image,
    };
  }

  factory MentorModel.fromMap(Map<String, dynamic> map) {
    return MentorModel(
      id: map['id'],
      name: map['name']?.toString() ?? '',
      designation: map['designation']?.toString() ?? '',
      whatHeDo: map['what_he_do']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      createdAt: map['created_at']?.toString(),
      image: map['image']?.toString() ?? '',
    );
  }
}
