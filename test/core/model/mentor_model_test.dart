import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MentorModel', () {
    const testMap = {
      'id': '1',
      'name': 'John Doe',
      'designation': 'Senior Developer',
      'what_he_do': 'Mentoring and Coding',
      'description':
          'An experienced developer and mentor in the field of Flutter.',
      'created_at': '2025-04-19',
      'image': 'https://example.com/mentor.jpg',
    };

    test('fromMap should create a valid MentorModel', () {
      final mentor = MentorModel.fromMap(testMap);

      expect(mentor.id, '1');
      expect(mentor.name, 'John Doe');
      expect(mentor.designation, 'Senior Developer');
      expect(mentor.whatHeDo, 'Mentoring and Coding');
      expect(mentor.description,
          'An experienced developer and mentor in the field of Flutter.');
      expect(mentor.createdAt, '2025-04-19');
      expect(mentor.image, 'https://example.com/mentor.jpg');
    });

    test('toMap should return a valid map', () {
      final mentor = MentorModel(
        id: '1',
        name: 'John Doe',
        designation: 'Senior Developer',
        whatHeDo: 'Mentoring and Coding',
        description:
            'An experienced developer and mentor in the field of Flutter.',
        createdAt: '2025-04-19',
        image: 'https://example.com/mentor.jpg',
      );

      final map = mentor.toMap();

      expect(map['name'], 'John Doe');
      expect(map['designation'], 'Senior Developer');
      expect(map['what_he_do'], 'Mentoring and Coding');
      expect(map['description'],
          'An experienced developer and mentor in the field of Flutter.');
      expect(map['image'], 'https://example.com/mentor.jpg');
    });

    test('fromMap should handle missing optional fields', () {
      final incompleteMap = {
        'name': 'John Doe',
        'designation': 'Senior Developer',
        'what_he_do': 'Mentoring and Coding',
        'description':
            'An experienced developer and mentor in the field of Flutter.',
        'image': 'https://example.com/mentor.jpg',
      };

      final mentor = MentorModel.fromMap(incompleteMap);

      expect(mentor.id, null);
      expect(mentor.createdAt, null);
    });
  });
}
