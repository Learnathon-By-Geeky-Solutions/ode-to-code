import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PopularCourseContentModel', () {
    const testMapContent = {
      'id': 1,
      'courses_id': '101',
      'number': '1',
      'title': 'Introduction to Flutter',
      'link': 'https://example.com/video',
      'note': 'Basic Introduction',
      'created_at': '2025-04-19',
    };

    test('fromMap should create a valid PopularCourseContentModel', () {
      final content = PopularCourseContentModel.fromMap(testMapContent);

      expect(content.id, 1);
      expect(content.coursesId, '101');
      expect(content.number, '1');
      expect(content.title, 'Introduction to Flutter');
      expect(content.link, 'https://example.com/video');
      expect(content.note, 'Basic Introduction');
      expect(content.createdAt, '2025-04-19');
    });

    test('toMap should return a valid map', () {
      final content = PopularCourseContentModel(
        id: 1,
        coursesId: '101',
        number: '1',
        title: 'Introduction to Flutter',
        link: 'https://example.com/video',
        note: 'Basic Introduction',
        createdAt: '2025-04-19',
      );

      final map = content.toMap();

      expect(map['courses_id'], '101');
      expect(map['number'], '1');
      expect(map['title'], 'Introduction to Flutter');
      expect(map['link'], 'https://example.com/video');
      expect(map['note'], 'Basic Introduction');
    });

    test('fromMap should handle missing optional fields', () {
      final incompleteMapContent = {
        'courses_id': '101',
        'number': '1',
        'title': 'Introduction to Flutter',
      };

      final content = PopularCourseContentModel.fromMap(incompleteMapContent);

      expect(content.id, null);
      expect(content.link, null);
      expect(content.note, null);
      expect(content.createdAt, null);
    });
  });
}
