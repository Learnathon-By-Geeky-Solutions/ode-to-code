import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:edu_bridge_app/core/resources/export.dart';

class MockPopularCourseRepository extends Mock
    implements IPopularCourseRepository {}

void main() {
  late MockPopularCourseRepository mockPopularCourseRepository;

  setUp(() {
    mockPopularCourseRepository = MockPopularCourseRepository();
  });

  group('IPopularCourseRepository tests', () {
    test(
        'uploadCourseImage should return image URL when image is uploaded successfully',
        () async {
      // Arrange
      final imageFile = File('path/to/image.png');
      const imageUrl = 'https://example.com/image.png';
      when(() => mockPopularCourseRepository.uploadCourseImage(imageFile))
          .thenAnswer((_) async => imageUrl);

      // Act
      final result =
          await mockPopularCourseRepository.uploadCourseImage(imageFile);

      // Assert
      expect(result, imageUrl);
      verify(() => mockPopularCourseRepository.uploadCourseImage(imageFile))
          .called(1);
    });

    test(
        'addPopularCourse should return true when course is added successfully',
        () async {
      // Arrange
      final courseModel = PopularCourseModel(
        imageLink: 'https://example.com/image.png',
        title: 'Course 1',
        price: '100',
        type: 'Online',
      );
      when(() => mockPopularCourseRepository.addPopularCourse(courseModel))
          .thenAnswer((_) async => true);

      // Act
      final result =
          await mockPopularCourseRepository.addPopularCourse(courseModel);

      // Assert
      expect(result, true);
      verify(() => mockPopularCourseRepository.addPopularCourse(courseModel))
          .called(1);
    });

    test('fetchPopularCourses should return a list of popular courses',
        () async {
      // Arrange
      final courseList = [
        PopularCourseModel(
          imageLink: 'https://example.com/image1.png',
          title: 'Course 1',
          price: '100',
          type: 'Online',
        ),
        PopularCourseModel(
          imageLink: 'https://example.com/image2.png',
          title: 'Course 2',
          price: '150',
          type: 'Offline',
        ),
      ];
      when(() => mockPopularCourseRepository.fetchPopularCourses())
          .thenAnswer((_) async => courseList);

      // Act
      final result = await mockPopularCourseRepository.fetchPopularCourses();

      // Assert
      expect(result, courseList);
      expect(result.length, 2);
      verify(() => mockPopularCourseRepository.fetchPopularCourses()).called(1);
    });

    test(
        'saveCourseForUser should return true when course is saved successfully',
        () async {
      // Arrange
      const courseId = 'course1';
      when(() => mockPopularCourseRepository.saveCourseForUser(courseId))
          .thenAnswer((_) async => true);

      // Act
      final result =
          await mockPopularCourseRepository.saveCourseForUser(courseId);

      // Assert
      expect(result, true);
      verify(() => mockPopularCourseRepository.saveCourseForUser(courseId))
          .called(1);
    });

    test('isCourseSaved should return true if course is saved', () async {
      // Arrange
      const courseId = 'course1';
      when(() => mockPopularCourseRepository.isCourseSaved(courseId))
          .thenAnswer((_) async => true);

      // Act
      final result = await mockPopularCourseRepository.isCourseSaved(courseId);

      // Assert
      expect(result, true);
      verify(() => mockPopularCourseRepository.isCourseSaved(courseId))
          .called(1);
    });

    test(
        'unsaveCourseForUser should return true when course is unsaved successfully',
        () async {
      // Arrange
      const courseId = 'course1';
      when(() => mockPopularCourseRepository.unsaveCourseForUser(courseId))
          .thenAnswer((_) async => true);

      // Act
      final result =
          await mockPopularCourseRepository.unsaveCourseForUser(courseId);

      // Assert
      expect(result, true);
      verify(() => mockPopularCourseRepository.unsaveCourseForUser(courseId))
          .called(1);
    });

    test('fetchSavedCourses should return list of saved courses', () async {
      // Arrange
      final savedCourseList = [
        PopularCourseModel(
          imageLink: 'https://example.com/saved1.png',
          title: 'Saved Course 1',
          price: '100',
          type: 'Online',
        ),
        PopularCourseModel(
          imageLink: 'https://example.com/saved2.png',
          title: 'Saved Course 2',
          price: '150',
          type: 'Offline',
        ),
      ];
      when(() => mockPopularCourseRepository.fetchSavedCourses())
          .thenAnswer((_) async => savedCourseList);

      // Act
      final result = await mockPopularCourseRepository.fetchSavedCourses();

      // Assert
      expect(result, savedCourseList);
      expect(result.length, 2);
      verify(() => mockPopularCourseRepository.fetchSavedCourses()).called(1);
    });
  });
}
