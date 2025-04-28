import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock class
class MockNetworkCaller extends Mock implements INetworkCaller {}

void main() {
  late MockNetworkCaller mockNetworkCaller;

  setUp(() {
    mockNetworkCaller = MockNetworkCaller();
  });

  group('INetworkCaller Tests', () {
    test('getRequest should return success response', () async {
      final fakeResponse = ApiResponse(
        isSuccess: true,
        responseData: {'key': 'value'},
        errorMessage: '',
      );

      when(() => mockNetworkCaller.getRequest(
            tableName: 'courses',
            queryParams: any(named: 'queryParams'),
            eqColumn: any(named: 'eqColumn'),
            eqValue: any(named: 'eqValue'),
            orderBy: any(named: 'orderBy'),
            orderDirection: any(named: 'orderDirection'),
          )).thenAnswer((_) async => fakeResponse);

      final response = await mockNetworkCaller.getRequest(tableName: 'courses');

      expect(response.isSuccess, true);
      expect(response.responseData, {'key': 'value'});
    });

    test('postRequest should return error response', () async {
      final fakeResponse = ApiResponse(
        isSuccess: false,
        responseData: null,
        errorMessage: 'Failed to post data',
      );

      when(() => mockNetworkCaller.postRequest(
            tableName: 'users',
            data: any(named: 'data'),
          )).thenAnswer((_) async => fakeResponse);

      final response = await mockNetworkCaller.postRequest(
        tableName: 'users',
        data: {'name': 'Sakif'},
      );

      expect(response.isSuccess, false);
      expect(response.errorMessage, 'Failed to post data');
    });

    test('uploadFile should return success', () async {
      final fakeResponse = ApiResponse(
        isSuccess: true,
        responseData: 'https://example.com/image.png',
        errorMessage: '',
      );

      when(() => mockNetworkCaller.uploadFile(
            bucketName: 'profile',
            filePath: '/image.png',
            file: any(named: 'file'),
          )).thenAnswer((_) async => fakeResponse);

      final response = await mockNetworkCaller.uploadFile(
        bucketName: 'profile',
        filePath: '/image.png',
        file: 'dummy_file',
      );

      expect(response.isSuccess, true);
      expect(response.responseData, contains('https://'));
    });

    test('deleteRequest should return success', () async {
      final fakeResponse = ApiResponse(
        isSuccess: true,
        responseData: null,
        errorMessage: '',
      );

      when(() => mockNetworkCaller.deleteRequest(
            tableName: 'enrollments',
            queryParams: any(named: 'queryParams'),
          )).thenAnswer((_) async => fakeResponse);

      final response = await mockNetworkCaller.deleteRequest(
        tableName: 'enrollments',
      );

      expect(response.isSuccess, true);
    });

    test('saveUserCourse should succeed', () async {
      final fakeResponse = ApiResponse(
        isSuccess: true,
        responseData: null,
        errorMessage: '',
      );

      when(() => mockNetworkCaller.saveUserCourse(
            userId: 'user123',
            courseId: 'course456',
          )).thenAnswer((_) async => fakeResponse);

      final response = await mockNetworkCaller.saveUserCourse(
        userId: 'user123',
        courseId: 'course456',
      );

      expect(response.isSuccess, true);
    });
  });
}
