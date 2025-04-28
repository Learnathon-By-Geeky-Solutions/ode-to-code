import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Assuming Logger and Query are actual interfaces or abstract classes
class MockLogger extends Mock implements Logger {}

abstract class Query {
  void eq(String column, dynamic value);
  void order(String column, {required bool ascending});
}

class MockQuery extends Mock implements Query {}

void main() {
  late NetworkUtils networkUtils;
  late MockLogger mockLogger;
  late MockQuery mockQuery;

  setUpAll(() {
    registerFallbackValue('');
    registerFallbackValue(Exception('Test'));
  });

  setUp(() {
    mockLogger = MockLogger();
    mockQuery = MockQuery();
    networkUtils = NetworkUtils(logger: mockLogger);
  });

  test('applyEqFilter should call eq and log', () {
    networkUtils.applyEqFilter(mockQuery, 'name', 'John');

    verify(() => mockQuery.eq('name', 'John')).called(1);
    verify(() => mockLogger.d('Added filter: name = John')).called(1);
  });

  test('applyOrdering should call order and log', () {
    networkUtils.applyOrdering(mockQuery, 'name', 'asc');

    verify(() => mockQuery.order('name', ascending: true)).called(1);
    verify(() => mockLogger.d(
          'Added ordering: name = asc',
          time: any(named: 'time'),
          error: any(named: 'error'),
          stackTrace: any(named: 'stackTrace'),
        )).called(1);
  });

  test('handleError should log error and return failed ApiResponse', () {
    final error = Exception('Boom');

    final response = networkUtils.handleError('POST', 'TestAPI', error);

    expect(response.isSuccess, false);
    expect(response.errorMessage, error.toString());

    verify(() => mockLogger.e(
          'POST Request Failed | Target: TestAPI',
          error: error,
        )).called(1);
  });
}
