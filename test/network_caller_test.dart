import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockLogger extends Mock implements Logger {}

void main() {
  late NetworkCaller networkCaller;
  late MockSupabaseClient mockSupabaseClient;
  late MockLogger mockLogger;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockLogger = MockLogger();
    networkCaller =
        NetworkCaller(client: mockSupabaseClient, logger: mockLogger);
  });

  group('NetworkCaller Tests', () {
    test('GET request should return success', () async {
      // Arrange
      final responseData = [
        {'id': 1, 'name': 'Course 1'}
      ]; // Mocked response

      // Create a mock PostgrestFilterBuilder
      final mockPostgrestFilterBuilder = MockPostgrestFilterBuilder();

      // Mock the SupabaseClient's from() and select() method
      when(() => mockSupabaseClient.from('courses').select())
          .thenReturn(mockPostgrestFilterBuilder);

      // Mock the behavior of the PostgrestFilterBuilder's execute() method
      when(() => mockPostgrestFilterBuilder.execute())
          .thenAnswer((_) async => responseData);

      // Act
      final result = await networkCaller.getRequest(tableName: 'courses');

      // Assert
      expect(result.isSuccess, true);
      expect(result.responseData, responseData);
      expect(result.errorMessage, '');
    });
  });
}

@override
class MockPostgrestFilterBuilder extends Mock
    implements PostgrestFilterBuilder<PostgrestList> {
  Future<List<Map<String, Object>>> execute() {
    return Future.value([
      {'id': 1, 'name': 'Course 1'},
    ]);
  }
}
