class CategoryModel {
  final String? id;
  final String categoryName;
  final String? createdAt;
  final String imageUrl;

  const CategoryModel({
    this.id,
    required this.categoryName,
    this.createdAt,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() => {
        'category_name': categoryName,
        'image': imageUrl,
      };

  factory CategoryModel.fromMap(Map<String, dynamic> data, String id) {
    return CategoryModel(
      id: id,
      categoryName: data['category_name']?.toString() ?? '',
      createdAt: data['created_at']?.toString(),
      imageUrl: data['image']?.toString() ?? '',
    );
  }
}
