import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoryRepository extends Mock implements ICategoryRepository {}

void main() {
  late MockCategoryRepository mockCategoryRepository;

  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
  });

  group('ICategoryRepository tests', () {
    test('uploadCategoryImage should return a valid URL when image is uploaded',
        () async {
      // Arrange
      final imageFile = File('path/to/image.png');
      const imageUrl = 'https://example.com/image.png';
      when(() => mockCategoryRepository.uploadCategoryImage(imageFile))
          .thenAnswer((_) async => imageUrl);

      // Act
      final result =
          await mockCategoryRepository.uploadCategoryImage(imageFile);

      // Assert
      expect(result, imageUrl);
      verify(() => mockCategoryRepository.uploadCategoryImage(imageFile))
          .called(1);
    });

    test('addCategory should return true when category is added successfully',
        () async {
      // Arrange
      const categoryModel = CategoryModel(
        categoryName: 'Technology',
        imageUrl: 'https://example.com/image.png',
      );
      when(() => mockCategoryRepository.addCategory(categoryModel))
          .thenAnswer((_) async => true);

      // Act
      final result = await mockCategoryRepository.addCategory(categoryModel);

      // Assert
      expect(result, true);
      verify(() => mockCategoryRepository.addCategory(categoryModel)).called(1);
    });

    test('fetchCategories should return a list of categories', () async {
      // Arrange
      final categoryList = [
        const CategoryModel(
          id: '1',
          categoryName: 'Technology',
          createdAt: '2025-04-19',
          imageUrl: 'https://example.com/image1.png',
        ),
        const CategoryModel(
          id: '2',
          categoryName: 'Science',
          createdAt: '2025-04-19',
          imageUrl: 'https://example.com/image2.png',
        ),
      ];
      when(() => mockCategoryRepository.fetchCategories())
          .thenAnswer((_) async => categoryList);

      // Act
      final result = await mockCategoryRepository.fetchCategories();

      // Assert
      expect(result, categoryList);
      expect(result.length, 2);
      verify(() => mockCategoryRepository.fetchCategories()).called(1);
    });

    test(
        'fetchCategoriesWithCondition should return categories based on condition',
        () async {
      // Arrange
      const column = 'category_name';
      const value = 'Technology';
      final categoryList = [
        const CategoryModel(
          id: '1',
          categoryName: 'Technology',
          createdAt: '2025-04-19',
          imageUrl: 'https://example.com/image1.png',
        ),
      ];
      when(() => mockCategoryRepository.fetchCategoriesWithCondition(
            column: column,
            value: value,
          )).thenAnswer((_) async => categoryList);

      // Act
      final result = await mockCategoryRepository.fetchCategoriesWithCondition(
          column: column, value: value);

      // Assert
      expect(result, categoryList);
      expect(result.length, 1);
      verify(() => mockCategoryRepository.fetchCategoriesWithCondition(
            column: column,
            value: value,
          )).called(1);
    });
  });
}
