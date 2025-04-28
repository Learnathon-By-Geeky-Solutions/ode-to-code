import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockClassRepository extends Mock implements IClassRepository {}

void main() {
  late MockClassRepository mockClassRepository;

  setUp(() {
    mockClassRepository = MockClassRepository();
  });

  group('IClassRepository tests', () {
    test(
        'uploadClassImage should return a string URL when image is uploaded successfully',
        () async {
      // Arrange
      final imageFile = File('path/to/image.jpg');
      const imageUrl = 'http://example.com/image.jpg';
      when(() => mockClassRepository.uploadClassImage(imageFile))
          .thenAnswer((_) async => imageUrl);

      // Act
      final result = await mockClassRepository.uploadClassImage(imageFile);

      // Assert
      expect(result, imageUrl);
      verify(() => mockClassRepository.uploadClassImage(imageFile)).called(1);
    });

    test('addClass should return true when class is added successfully',
        () async {
      // Arrange
      final classModel = ClassModel(
        categoryId: 'category1',
        className: 'Class 1',
        image: 'image_url',
      );
      when(() => mockClassRepository.addClass(classModel))
          .thenAnswer((_) async => true);

      // Act
      final result = await mockClassRepository.addClass(classModel);

      // Assert
      expect(result, true);
      verify(() => mockClassRepository.addClass(classModel)).called(1);
    });

    test('fetchClassesByCategoryId should return list of classes', () async {
      // Arrange
      const categoryId = 'category1';
      final classList = [
        ClassModel(
          id: '1',
          categoryId: categoryId,
          className: 'Class 1',
          image: 'image_url_1',
        ),
        ClassModel(
          id: '2',
          categoryId: categoryId,
          className: 'Class 2',
          image: 'image_url_2',
        ),
      ];
      when(() => mockClassRepository.fetchClassesByCategoryId(categoryId))
          .thenAnswer((_) async => classList);

      // Act
      final result =
          await mockClassRepository.fetchClassesByCategoryId(categoryId);

      // Assert
      expect(result, classList);
      expect(result.length, 2);
      verify(() => mockClassRepository.fetchClassesByCategoryId(categoryId))
          .called(1);
    });

    test(
        'fetchClassesByCategoryId should return an empty list when no classes are found',
        () async {
      // Arrange
      const categoryId = 'category2';
      when(() => mockClassRepository.fetchClassesByCategoryId(categoryId))
          .thenAnswer((_) async => []);

      // Act
      final result =
          await mockClassRepository.fetchClassesByCategoryId(categoryId);

      // Assert
      expect(result, isEmpty);
      verify(() => mockClassRepository.fetchClassesByCategoryId(categoryId))
          .called(1);
    });
  });
}
