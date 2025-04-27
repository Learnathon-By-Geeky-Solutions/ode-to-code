import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChapterRepository extends Mock implements IChapterRepository {}

void main() {
  late MockChapterRepository mockChapterRepository;

  setUp(() {
    mockChapterRepository = MockChapterRepository();
  });

  group('IChapterRepository tests', () {
    test('addChapter should return true when chapter is added successfully',
        () async {
      // Arrange
      final chapterModel = ChapterModel(
        id: '1',
        subjectId: 'subject1',
        chapterName: 'Chapter 1',
        image: "",
      );
      when(() => mockChapterRepository.addChapter(chapterModel))
          .thenAnswer((_) async => true);

      // Act
      final result = await mockChapterRepository.addChapter(chapterModel);

      // Assert
      expect(result, true);
      verify(() => mockChapterRepository.addChapter(chapterModel)).called(1);
    });

    test('fetchChaptersBySubjectId should return list of chapters', () async {
      // Arrange
      const subjectId = 'subject1';
      final chapterList = [
        ChapterModel(
          id: '1',
          subjectId: subjectId,
          chapterName: 'Chapter 1',
          image: "",
        ),
        ChapterModel(
          id: '2',
          subjectId: subjectId,
          chapterName: 'Chapter 2'
              '',
        ),
      ];
      when(() => mockChapterRepository.fetchChaptersBySubjectId(subjectId))
          .thenAnswer((_) async => chapterList);

      // Act
      final result =
          await mockChapterRepository.fetchChaptersBySubjectId(subjectId);

      // Assert
      expect(result, chapterList);
      expect(result.length, 2);
      verify(() => mockChapterRepository.fetchChaptersBySubjectId(subjectId))
          .called(1);
    });

    test(
        'fetchChaptersBySubjectId should return an empty list when no chapters are found',
        () async {
      // Arrange
      const subjectId = 'subject2';
      when(() => mockChapterRepository.fetchChaptersBySubjectId(subjectId))
          .thenAnswer((_) async => []);

      // Act
      final result =
          await mockChapterRepository.fetchChaptersBySubjectId(subjectId);

      // Assert
      expect(result, isEmpty);
      verify(() => mockChapterRepository.fetchChaptersBySubjectId(subjectId))
          .called(1);
    });
  });
}
