class PopularCourseContentModel {
  final int? id;
  final String coursesId;
  final String number;
  final String title;
  final String? link; // Make link nullable (optional)
  final String? note; // Add note as an optional field
  final String? createdAt;

  PopularCourseContentModel({
    this.id,
    required this.coursesId,
    required this.number,
    required this.title,
    this.link, // Make link nullable
    this.note, // Make note nullable
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'courses_id': coursesId,
      'number': number,
      'title': title,
      'link': link, // Link can now be null
      'note': note, // Include note in the map
    };
  }

  factory PopularCourseContentModel.fromMap(Map<String, dynamic> map) {
    return PopularCourseContentModel(
      id: map['id'],
      coursesId: map['courses_id']?.toString() ?? '',
      number: map['number']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      link: map['link']?.toString(), // Link can be null
      note: map['note']?.toString(), // Note can be null
      createdAt: map['created_at']?.toString(),
    );
  }
}
