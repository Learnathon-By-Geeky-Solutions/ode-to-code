import 'package:flutter_test/flutter_test.dart';
import 'package:edu_bridge_app/core/resources/export.dart';

void main() {
  group('ContentModel', () {
    const testMap = {
      'id': '1',
      'chapters_id': '101',
      'number': '1',
      'name': 'Introduction to Flutter',
      'link': 'https://example.com/content',
      'created_at': '2025-04-19',
      'note': 'This is a basic introduction.',
    };

    test('fromMap should create a valid ContentModel', () {
      final content = ContentModel.fromMap(testMap);

      expect(content.id, '1');
      expect(content.chaptersId, '101');
      expect(content.number, '1');
      expect(content.name, 'Introduction to Flutter');
      expect(content.link, 'https://example.com/content');
      expect(content.createdAt, '2025-04-19');
      expect(content.note, 'This is a basic introduction.');
    });

    test('toMap should return a valid map (excluding id and createdAt)', () {
      final content = ContentModel(
        id: '1',
        chaptersId: '101',
        number: '1',
        name: 'Introduction to Flutter',
        link: 'https://example.com/content',
        createdAt: '2025-04-19',
        note: 'This is a basic introduction.',
      );

      final map = content.toMap();

      expect(map['chapters_id'], '101');
      expect(map['number'], '1');
      expect(map['name'], 'Introduction to Flutter');
      expect(map['link'], 'https://example.com/content');
      expect(map['note'], 'This is a basic introduction.');
      expect(map.containsKey('id'), false);
      expect(map.containsKey('created_at'), false);
    });

    test('fromMap should handle missing optional fields', () {
      final incompleteMap = {
        'chapters_id': '101',
        'number': '1',
        'name': 'Introduction to Flutter',
        'created_at': '2025-04-19',
      };

      final content = ContentModel.fromMap(incompleteMap);

      expect(content.id, null);
      expect(content.link, null);
      expect(content.note, null);
      expect(content.createdAt, '2025-04-19');
      expect(content.chaptersId, '101');
      expect(content.number, '1');
      expect(content.name, 'Introduction to Flutter');
    });
  });
}
