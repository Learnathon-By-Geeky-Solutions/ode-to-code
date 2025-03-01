class CourseModel {
  final String? id;
  final String imageLink;
  final String title;
  final String price;
  final String type;
  final String createdAt;

  CourseModel({
    this.id,
    required this.imageLink,
    required this.title,
    required this.price,
    required this.type,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'image_link': imageLink,
      'title': title,
      'price': price,
      'type': type,
      'created_at': createdAt,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'],
      imageLink: map['image_link'] ?? '',
      title: map['title'] ?? '',
      price: map['price'] ?? '',
      type: map['type'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }
}
