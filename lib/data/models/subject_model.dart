class SubjectModel {
  final String? id;
  final String classId;
  final String subjectName;
  final String? createdAt;
  final String image;

  SubjectModel({
    this.id,
    required this.classId,
    required this.subjectName,
    this.createdAt,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'class_id': classId,
      'subject_name': subjectName,
      'image': image,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      id: map['id'],
      classId: map['class_id']?.toString() ?? '',
      subjectName: map['subject_name']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      createdAt: map['created_at']?.toString(),
    );
  }
}
