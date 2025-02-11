class CategoryModel {
  final String id;
  final String title;
  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> data, String id) {
    return CategoryModel(
      id: id,
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
