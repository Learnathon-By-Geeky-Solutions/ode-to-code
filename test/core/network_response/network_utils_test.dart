import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:edu_bridge_app/core/resources/export.dart';

class MockLogger extends Mock implements Logger {}

class MockQuery extends Mock {
  void eq(String column, dynamic value);
  void order(String column, {required bool ascending});
}

void main() {
  late NetworkUtils networkUtils;
  late MockLogger mockLogger;
  late MockQuery mockQuery;

  setUp(() {
    mockLogger = MockLogger();
    mockQuery = MockQuery();
    networkUtils = NetworkUtils(logger: mockLogger);
  });

  group('NetworkUtils Tests', () {
    test('applyEqFilter should add filter and log it', () {
      // Arrange
      const column = 'name';
      const value = 'John';

      // Act
      networkUtils.applyEqFilter(mockQuery, column, value);

      // Assert
      verify(() => mockQuery.eq(column, value)).called(1);
      verify(() => mockLogger.d('Added filter: $column = $value')).called(1);
    });

    test('applyQueryParams should add multiple query params and log them', () {
      // Arrange
      final params = {
        'name': 'John',
        'age': 25,
      };

      // Act
      networkUtils.applyQueryParams(mockQuery, params);

      // Assert
      verify(() => mockQuery.eq('name', 'John')).called(1);
      verify(() => mockQuery.eq('age', 25)).called(1);
      verify(() => mockLogger.d('Added query param: name = John')).called(1);
      verify(() => mockLogger.d('Added query param: age = 25')).called(1);
    });

    test('applyOrdering should add ordering and log it', () {
      // Arrange
      const column = 'name';
      const direction = 'asc';

      // Act
      networkUtils.applyOrdering(mockQuery, column, direction);

      // Assert
      verify(() => mockQuery.order(column, ascending: true)).called(1);
      verify(() => mockLogger.d('Added ordering: $column ($direction)'))
          .called(1);
    });

    test('handleError should return ApiResponse with error', () {
      // Arrange
      const method = 'GET';
      const name = 'TestAPI';
      final error = Exception('Test error');

      // Act
      final result = networkUtils.handleError(method, name, error);

      // Assert
      expect(result.isSuccess, false);
      expect(result.errorMessage, error.toString());
      verify(() => mockLogger.e('$method Request Failed | Target: $name',
          error: error)).called(1);
    });
  });
}
