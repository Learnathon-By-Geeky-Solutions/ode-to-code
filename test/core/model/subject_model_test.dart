import 'package:flutter_test/flutter_test.dart';
import 'package:edu_bridge_app/core/resources/export.dart';

void main() {
  group('SubjectModel', () {
    const testMap = {
      'id': '1',
      'class_id': '101',
      'subject_name': 'Mathematics',
      'created_at': '2025-04-19',
      'image': 'https://example.com/subject.jpg',
    };

    test('fromMap should create a valid SubjectModel', () {
      final subject = SubjectModel.fromMap(testMap);

      expect(subject.id, '1');
      expect(subject.classId, '101');
      expect(subject.subjectName, 'Mathematics');
      expect(subject.createdAt, '2025-04-19');
      expect(subject.image, 'https://example.com/subject.jpg');
    });

    test('toMap should return a valid map', () {
      final subject = SubjectModel(
        id: '1',
        classId: '101',
        subjectName: 'Mathematics',
        createdAt: '2025-04-19',
        image: 'https://example.com/subject.jpg',
      );

      final map = subject.toMap();

      expect(map['class_id'], '101');
      expect(map['subject_name'], 'Mathematics');
      expect(map['image'], 'https://example.com/subject.jpg');
    });

    test('fromMap should handle missing optional fields', () {
      final incompleteMap = {
        'class_id': '101',
        'subject_name': 'Mathematics',
        'image': 'https://example.com/subject.jpg',
      };

      final subject = SubjectModel.fromMap(incompleteMap);

      expect(subject.id, null);
      expect(subject.createdAt, null);
    });
  });
}
