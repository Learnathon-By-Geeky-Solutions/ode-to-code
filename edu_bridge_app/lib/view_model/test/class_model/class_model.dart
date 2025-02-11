class ClassModel {
  final String id;
  final String name;

  ClassModel({
    required this.id,
    required this.name,
  });

  // Factory constructor to create an instance from Firestore data
  factory ClassModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ClassModel(
      id: id,
      name: data['name'] ?? '', // Providing a fallback to avoid null issues
    );
  }

  // Method to convert the instance back to Firestore format
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
    };
  }
}
