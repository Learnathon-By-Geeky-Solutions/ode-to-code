class ChapterModel {
  final String? id;
  final String subjectId;
  final String chapterName;
  final String? createdAt;
  final String? image;

  ChapterModel({
    this.id,
    required this.subjectId,
    required this.chapterName,
    this.createdAt,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'subject_id': subjectId,
      'chapter_name': chapterName,
    };
  }

  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    return ChapterModel(
      id: map['id'],
      subjectId: map['subject_id']?.toString() ?? '',
      chapterName: map['chapter_name']?.toString() ?? '',
      createdAt: map['created_at']?.toString(),
      image: map['image']?.toString(),
    );
  }
}
