import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContentModel', () {
    test('should create ContentModel from map correctly', () {
      final Map<String, dynamic> mockMap = {
        'id': '1',
        'chapters_id': '101',
        'number': '1',
        'name': 'Chapter 1',
        'link': 'http://example.com',
        'created_at': '2025-04-24',
        'note': 'Important note'
      };

      final contentModel = ContentModel.fromMap(mockMap);

      expect(contentModel.id, '1');
      expect(contentModel.chaptersId, '101');
      expect(contentModel.number, '1');
      expect(contentModel.name, 'Chapter 1');
      expect(contentModel.link, 'http://example.com');
      expect(contentModel.createdAt, '2025-04-24');
      expect(contentModel.note, 'Important note');
    });

    test('should convert ContentModel to map correctly', () {
      final contentModel = ContentModel(
        id: '1',
        chaptersId: '101',
        number: '1',
        name: 'Chapter 1',
        link: 'http://example.com',
        createdAt: '2025-04-24',
        note: 'Important note',
      );

      final map = contentModel.toMap();

      expect(map['chapters_id'], '101');
      expect(map['number'], '1');
      expect(map['name'], 'Chapter 1');
      expect(map['link'], 'http://example.com');
      expect(map['note'], 'Important note');
    });

    test('should handle missing fields gracefully', () {
      final Map<String, dynamic> incompleteMap = {
        'chapters_id': '101',
        'number': '1',
        'name': 'Chapter 1',
        'created_at': '2025-04-24',
      };

      final contentModel = ContentModel.fromMap(incompleteMap);

      expect(contentModel.id, isNull); // id is missing in the map
      expect(contentModel.link, isNull); // link is missing in the map
      expect(contentModel.note, isNull); // note is missing in the map
    });
  });
}
