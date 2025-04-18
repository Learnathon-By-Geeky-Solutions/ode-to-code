import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChapterModel', () {
    const testMap = {
      'id': '1',
      'subject_id': '101',
      'chapter_name': 'Chapter 1',
      'created_at': '2025-04-19',
      'image': 'image_url',
    };

    test('fromMap should create a valid ChapterModel', () {
      final chapter = ChapterModel.fromMap(testMap);

      expect(chapter.id, '1');
      expect(chapter.subjectId, '101');
      expect(chapter.chapterName, 'Chapter 1');
      expect(chapter.createdAt, '2025-04-19');
      expect(chapter.image, 'image_url');
    });

    test('toMap should return a valid map', () {
      final chapter = ChapterModel(
        id: '1',
        subjectId: '101',
        chapterName: 'Chapter 1',
        createdAt: '2025-04-19',
        image: 'image_url',
      );

      final map = chapter.toMap();

      expect(map['subject_id'], '101');
      expect(map['chapter_name'], 'Chapter 1');
    });

    test('fromMap should handle missing optional fields', () {
      final incompleteMap = {
        'subject_id': '101',
        'chapter_name': 'Chapter 1',
      };

      final chapter = ChapterModel.fromMap(incompleteMap);

      expect(chapter.id, null);
      expect(chapter.createdAt, null);
      expect(chapter.image, null);
    });
  });
}
