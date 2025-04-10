class BannerModel {
  final String? id;
  final String details;
  final String? createdAt;
  final String imageLink;

  BannerModel({
    this.id,
    required this.details,
    this.createdAt,
    required this.imageLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'details': details,
      'image_link': imageLink,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    final String? id = map['id'] is String ? map['id'] : null;
    final String details = map['details']?.toString() ?? '';
    final String? createdAt = map['created_at']?.toString();
    final String imageLink = map['image_link']?.toString() ?? '';

    return BannerModel(
      id: id,
      details: details,
      createdAt: createdAt,
      imageLink: imageLink,
    );
  }
}
