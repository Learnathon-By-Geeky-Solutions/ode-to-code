class ChapterModel {
  final String? id;
  final String subjectId;
  final String chapterName;
  final String createdAt;
  final String image;

  ChapterModel({
    this.id,
    required this.subjectId,
    required this.chapterName,
    required this.createdAt,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'subject_id': subjectId,
      'chapter_name': chapterName,
      'image': image,
      'created_at': createdAt,
    };
  }

  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    return ChapterModel(
      id: map['id'],
      subjectId: map['subject_id'] ?? '',
      chapterName: map['chapter_name'] ?? '',
      image: map['image'],
      createdAt: map['created_at'] ?? '',
    );
  }
}
