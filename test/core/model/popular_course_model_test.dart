import 'package:flutter_test/flutter_test.dart';
import 'package:edu_bridge_app/core/resources/export.dart';

void main() {
  group('PopularCourseModel', () {
    const testMap = {
      'id': '1',
      'image_link': 'https://example.com/image.jpg',
      'title': 'Flutter for Beginners',
      'price': 'Free',
      'type': 'Online',
      'created_at': '2025-04-19',
    };

    test('fromMap should create a valid PopularCourseModel', () {
      final course = PopularCourseModel.fromMap(testMap);

      expect(course.id, '1');
      expect(course.imageLink, 'https://example.com/image.jpg');
      expect(course.title, 'Flutter for Beginners');
      expect(course.price, 'Free');
      expect(course.type, 'Online');
      expect(course.createdAt, '2025-04-19');
    });

    test('toMap should return a valid map', () {
      final course = PopularCourseModel(
        id: '1',
        imageLink: 'https://example.com/image.jpg',
        title: 'Flutter for Beginners',
        price: 'Free',
        type: 'Online',
        createdAt: '2025-04-19',
      );

      final map = course.toMap();

      expect(map['image_link'], 'https://example.com/image.jpg');
      expect(map['title'], 'Flutter for Beginners');
      expect(map['price'], 'Free');
      expect(map['type'], 'Online');
    });

    test('fromMap should handle missing optional fields', () {
      final incompleteMap = {
        'image_link': 'https://example.com/image.jpg',
        'title': 'Flutter for Beginners',
        'price': 'Free',
        'type': 'Online',
      };

      final course = PopularCourseModel.fromMap(incompleteMap);

      expect(course.id, null);
      expect(course.createdAt, null);
    });
  });
}
