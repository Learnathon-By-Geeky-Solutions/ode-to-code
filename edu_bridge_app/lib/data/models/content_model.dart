class ContentModel {
  final String? id;
  final String chapterId;
  final String chapterName;
  final String createdAt;

  ContentModel({
    this.id,
    required this.chapterId,
    required this.chapterName,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'chapter_id': chapterId,
      'chapter_name': chapterName,
      'created_at': createdAt,
    };
  }

  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(
      id: map['id'],
      chapterId: map['chapter_id'] ?? '',
      chapterName: map['chapter_name'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }
}
