class ClassModel {
  final String? id;
  final String categoryId;
  final String className;
  final String? createdAt;
  final String image;

  ClassModel({
    this.id,
    required this.categoryId,
    required this.className,
    this.createdAt,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'class_name': className,
      'image': image,
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'],
      categoryId: map['category_id']?.toString() ?? '',
      className: map['class_name']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      createdAt: map['created_at']?.toString(),
    );
  }
}
