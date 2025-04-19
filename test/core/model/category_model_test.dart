import 'package:flutter_test/flutter_test.dart';
import 'package:edu_bridge_app/core/resources/export.dart';

void main() {
  group('CategoryModel', () {
    const testMap = {
      'category_name': 'Programming',
      'image': 'https://example.com/category.jpg',
      'created_at': '2025-04-19',
    };
    const testId = '1';

    test('fromMap should create a valid CategoryModel', () {
      final category = CategoryModel.fromMap(testMap, testId);

      expect(category.id, testId);
      expect(category.categoryName, 'Programming');
      expect(category.createdAt, '2025-04-19');
      expect(category.imageUrl, 'https://example.com/category.jpg');
    });

    test('toMap should return a valid map', () {
      const category = CategoryModel(
        id: '1',
        categoryName: 'Programming',
        createdAt: '2025-04-19',
        imageUrl: 'https://example.com/category.jpg',
      );

      final map = category.toMap();

      expect(map['category_name'], 'Programming');
      expect(map['image'], 'https://example.com/category.jpg');
    });

    test('fromMap should handle missing optional fields', () {
      final incompleteMap = {
        'category_name': 'Programming',
        'image': 'https://example.com/category.jpg',
      };

      final category = CategoryModel.fromMap(incompleteMap, testId);

      expect(category.id, testId);
      expect(category.categoryName, 'Programming');
      expect(category.createdAt, null);
      expect(category.imageUrl, 'https://example.com/category.jpg');
    });
  });
}
