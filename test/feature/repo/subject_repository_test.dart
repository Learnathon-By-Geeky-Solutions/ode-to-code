import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:edu_bridge_app/core/resources/export.dart';

class MockSubjectRepository extends Mock implements ISubjectRepository {}

void main() {
  late MockSubjectRepository mockSubjectRepository;

  setUp(() {
    mockSubjectRepository = MockSubjectRepository();
  });

  group('ISubjectRepository tests', () {
    test('addSubject should return true when subject is added successfully',
        () async {
      // Arrange
      final subjectModel = SubjectModel(
        classId: 'class1',
        subjectName: 'Subject 1',
        image: 'subject_image_url',
      );
      when(() => mockSubjectRepository.addSubject(subjectModel))
          .thenAnswer((_) async => true);

      // Act
      final result = await mockSubjectRepository.addSubject(subjectModel);

      // Assert
      expect(result, true);
      verify(() => mockSubjectRepository.addSubject(subjectModel)).called(1);
    });

    test('fetchSubjectsByClassId should return a list of subjects', () async {
      // Arrange
      const classId = 'class1';
      final subjectList = [
        SubjectModel(
          classId: classId,
          subjectName: 'Subject 1',
          image: 'subject_image_url',
        ),
        SubjectModel(
          classId: classId,
          subjectName: 'Subject 2',
          image: 'subject_image_url',
        ),
      ];
      when(() => mockSubjectRepository.fetchSubjectsByClassId(classId))
          .thenAnswer((_) async => subjectList);

      // Act
      final result =
          await mockSubjectRepository.fetchSubjectsByClassId(classId);

      // Assert
      expect(result, subjectList);
      expect(result.length, 2);
      verify(() => mockSubjectRepository.fetchSubjectsByClassId(classId))
          .called(1);
    });

    test(
        'fetchSubjectsByClassId should return an empty list when no subjects are found',
        () async {
      // Arrange
      const classId = 'class2';
      when(() => mockSubjectRepository.fetchSubjectsByClassId(classId))
          .thenAnswer((_) async => []);

      // Act
      final result =
          await mockSubjectRepository.fetchSubjectsByClassId(classId);

      // Assert
      expect(result, isEmpty);
      verify(() => mockSubjectRepository.fetchSubjectsByClassId(classId))
          .called(1);
    });

    test(
        'uploadSubjectImage should return image URL when image is uploaded successfully',
        () async {
      // Arrange
      final imageFile = File('path_to_image');
      when(() => mockSubjectRepository.uploadSubjectImage(imageFile))
          .thenAnswer((_) async => 'uploaded_image_url');

      // Act
      final result = await mockSubjectRepository.uploadSubjectImage(imageFile);

      // Assert
      expect(result, 'uploaded_image_url');
      verify(() => mockSubjectRepository.uploadSubjectImage(imageFile))
          .called(1);
    });
  });
}
