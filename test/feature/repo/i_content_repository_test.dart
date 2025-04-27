import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContentRepository extends Mock implements IContentRepository {}

void main() {
  late MockContentRepository mockContentRepository;

  setUp(() {
    mockContentRepository = MockContentRepository();
  });

  group('IContentRepository tests', () {
    test('addContent should return true when content is added successfully',
        () async {
      // Arrange
      final contentModel = ContentModel(
        chaptersId: 'chapter1',
        number: '1',
        name: 'Content 1',
        createdAt: '2025-04-19',
      );
      when(() => mockContentRepository.addContent(contentModel))
          .thenAnswer((_) async => true);

      // Act
      final result = await mockContentRepository.addContent(contentModel);

      // Assert
      expect(result, true);
      verify(() => mockContentRepository.addContent(contentModel)).called(1);
    });

    test('fetchContentsByChapterId should return list of contents', () async {
      // Arrange
      const chapterId = 'chapter1';
      final contentList = [
        ContentModel(
          chaptersId: chapterId,
          number: '1',
          name: 'Content 1',
          createdAt: '2025-04-19',
        ),
        ContentModel(
          chaptersId: chapterId,
          number: '2',
          name: 'Content 2',
          createdAt: '2025-04-19',
        ),
      ];
      when(() => mockContentRepository.fetchContentsByChapterId(chapterId))
          .thenAnswer((_) async => contentList);

      // Act
      final result =
          await mockContentRepository.fetchContentsByChapterId(chapterId);

      // Assert
      expect(result, contentList);
      expect(result.length, 2);
      verify(() => mockContentRepository.fetchContentsByChapterId(chapterId))
          .called(1);
    });

    test(
        'fetchContentsByChapterId should return an empty list when no contents are found',
        () async {
      // Arrange
      const chapterId = 'chapter2';
      when(() => mockContentRepository.fetchContentsByChapterId(chapterId))
          .thenAnswer((_) async => []);

      // Act
      final result =
          await mockContentRepository.fetchContentsByChapterId(chapterId);

      // Assert
      expect(result, isEmpty);
      verify(() => mockContentRepository.fetchContentsByChapterId(chapterId))
          .called(1);
    });
  });
}
