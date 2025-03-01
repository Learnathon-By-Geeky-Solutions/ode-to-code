class SubjectModel {
  final String? id;
  final String classId;
  final String subjectName;
  final String createdAt;
  final String image;

  SubjectModel({
    this.id,
    required this.classId,
    required this.subjectName,
    required this.createdAt,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'class_id': classId,
      'subject_name': subjectName,
      'image': image,
      'created_at': createdAt,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      id: map['id'],
      classId: map['class_id'] ?? '',
      subjectName: map['subject_name'] ?? '',
      image: map['image'],
      createdAt: map['created_at'] ?? '',
    );
  }
}
