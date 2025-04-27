import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularCourseContentRepository extends Mock
    implements IPopularCourseContentRepository {}

void main() {
  late MockPopularCourseContentRepository mockPopularCourseContentRepository;

  setUp(() {
    mockPopularCourseContentRepository = MockPopularCourseContentRepository();
  });

  group('IPopularCourseContentRepository tests', () {
    test(
        'addPopularCourseContent should return true when content is added successfully',
        () async {
      // Arrange
      final courseContentModel = PopularCourseContentModel(
        coursesId: 'course1',
        number: '1',
        title: 'Content 1',
        link: 'https://example.com/content1',
      );
      when(() => mockPopularCourseContentRepository.addPopularCourseContent(
          courseContentModel)).thenAnswer((_) async => true);

      // Act
      final result = await mockPopularCourseContentRepository
          .addPopularCourseContent(courseContentModel);

      // Assert
      expect(result, true);
      verify(() => mockPopularCourseContentRepository
          .addPopularCourseContent(courseContentModel)).called(1);
    });

    test('fetchPopularCourseContentById should return a list of course content',
        () async {
      // Arrange
      const courseId = 'course1';
      final courseContentList = [
        PopularCourseContentModel(
          coursesId: courseId,
          number: '1',
          title: 'Content 1',
          link: 'https://example.com/content1',
        ),
        PopularCourseContentModel(
          coursesId: courseId,
          number: '2',
          title: 'Content 2',
          link: 'https://example.com/content2',
        ),
      ];
      when(() => mockPopularCourseContentRepository
              .fetchPopularCourseContentById(courseId))
          .thenAnswer((_) async => courseContentList);

      // Act
      final result = await mockPopularCourseContentRepository
          .fetchPopularCourseContentById(courseId);

      // Assert
      expect(result, courseContentList);
      expect(result.length, 2);
      verify(() => mockPopularCourseContentRepository
          .fetchPopularCourseContentById(courseId)).called(1);
    });

    test(
        'fetchPopularCourseContentById should return an empty list when no content is found',
        () async {
      // Arrange
      const courseId = 'course2';
      when(() => mockPopularCourseContentRepository
          .fetchPopularCourseContentById(courseId)).thenAnswer((_) async => []);

      // Act
      final result = await mockPopularCourseContentRepository
          .fetchPopularCourseContentById(courseId);

      // Assert
      expect(result, isEmpty);
      verify(() => mockPopularCourseContentRepository
          .fetchPopularCourseContentById(courseId)).called(1);
    });
  });
}
