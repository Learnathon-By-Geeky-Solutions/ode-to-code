import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClassModel', () {
    const testMap = {
      'id': '1',
      'category_id': '101',
      'class_name': 'Advanced Flutter',
      'created_at': '2025-04-19',
      'image': 'https://example.com/class_image.jpg',
    };

    test('fromMap should create a valid ClassModel', () {
      final classModel = ClassModel.fromMap(testMap);

      expect(classModel.id, '1');
      expect(classModel.categoryId, '101');
      expect(classModel.className, 'Advanced Flutter');
      expect(classModel.createdAt, '2025-04-19');
      expect(classModel.image, 'https://example.com/class_image.jpg');
    });

    test('toMap should return a valid map', () {
      final classModel = ClassModel(
        id: '1',
        categoryId: '101',
        className: 'Advanced Flutter',
        createdAt: '2025-04-19',
        image: 'https://example.com/class_image.jpg',
      );

      final map = classModel.toMap();

      expect(map['category_id'], '101');
      expect(map['class_name'], 'Advanced Flutter');
      expect(map['image'], 'https://example.com/class_image.jpg');
    });

    test('fromMap should handle missing optional fields', () {
      final incompleteMap = {
        'category_id': '101',
        'class_name': 'Advanced Flutter',
        'image': 'https://example.com/class_image.jpg',
      };

      final classModel = ClassModel.fromMap(incompleteMap);

      expect(classModel.id, null);
      expect(classModel.createdAt, null);
      expect(classModel.categoryId, '101');
      expect(classModel.className, 'Advanced Flutter');
      expect(classModel.image, 'https://example.com/class_image.jpg');
    });
  });
}
