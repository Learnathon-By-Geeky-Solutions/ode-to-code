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
    return BannerModel(
      id: map['id'],
      details: map['details'] ?? '',
      createdAt: map['created_at'] ?? '',
      imageLink: map['image_link'] ?? '',
    );
  }
}
