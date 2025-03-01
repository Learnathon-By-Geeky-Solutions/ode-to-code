class MentorModel {
  final String? id;
  final String name;
  final String designation;
  final String whatHeDo;
  final String description;
  final String createdAt;

  MentorModel({
    this.id,
    required this.name,
    required this.designation,
    required this.whatHeDo,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'designation': designation,
      'what_he_do': whatHeDo,
      'description': description,
      'created_at': createdAt,
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
    );
  }
}
