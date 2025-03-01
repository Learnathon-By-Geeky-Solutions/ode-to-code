class BannerModel {
  final String? id;
  final String image;
  final String createdAt;
  final String imageLink;

  BannerModel({
    this.id,
    required this.image,
    required this.createdAt,
    required this.imageLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'created_at': createdAt,
      'image_link': imageLink,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'],
      image: map['image'] ?? '',
      createdAt: map['created_at'] ?? '',
      imageLink: map['image_link'] ?? '',
    );
  }
}
