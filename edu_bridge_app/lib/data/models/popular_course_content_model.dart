class PopularCourseContentModel {
  final int? id;
  final String coursesId;
  final String number;
  final String title;
  final String link;
  final String? createdAt;

  PopularCourseContentModel({
    this.id,
    required this.coursesId,
    required this.number,
    required this.title,
    required this.link,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'courses_id': coursesId,
      'number': number,
      'title': title,
      'link': link,
    };
  }

  factory PopularCourseContentModel.fromMap(Map<String, dynamic> map) {
    return PopularCourseContentModel(
      id: map['id'],
      coursesId: map['courses_id'] ?? '',
      number: map['number'] ?? '',
      title: map['title'] ?? '',
      link: map['link'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }
}
