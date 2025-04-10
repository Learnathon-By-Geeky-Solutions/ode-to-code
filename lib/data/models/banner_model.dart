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

  Map<String, dynamic> toMap() => {
        'details': details,
        'image_link': imageLink,
      };

  factory BannerModel.fromMap(Map<String, dynamic> map) => BannerModel(
        id: map['id'] as String?,
        details: map['details']?.toString() ?? '',
        createdAt: map['created_at']?.toString(),
        imageLink: map['image_link']?.toString() ?? '',
      );
}
