class CategoryModel {
  final String? id;
  final String categoryName;
  final String? createdAt;
  final String imageUrl;

  CategoryModel({
    this.id,
    required this.categoryName,
    this.createdAt,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'category_name': categoryName,
      'image': imageUrl,
    };
  }

  // Convert Map to CategoryModel
  factory CategoryModel.fromMap(Map<String, dynamic> data, String id) {
    return CategoryModel(
      id: id,
      categoryName: data['category_name'] ?? '',
      createdAt: data['created_at'],
      imageUrl: data['image'] ?? '',
    );
  }
}
