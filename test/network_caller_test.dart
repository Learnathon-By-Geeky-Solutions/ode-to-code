import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:edu_bridge_app/core/services/network_caller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockLogger extends Mock implements Logger {}

void main() {
  late MockSupabaseClient mockClient;
  late MockGoTrueClient mockAuth;
  late MockLogger mockLogger;
  late NetworkCaller caller;

  setUp(() {
    mockClient = MockSupabaseClient();
    mockAuth = MockGoTrueClient();
    mockLogger = MockLogger();

    when(() => mockClient.auth).thenReturn(mockAuth);

    caller = NetworkCaller(client: mockClient, logger: mockLogger);
  });

  test('getCurrentUserId returns user id when available', () {
    const mockUser = User(
      id: 'user123',
      appMetadata: {},
      aud: '',
      createdAt: '',
      email: 'test@example.com',
      emailConfirmedAt: '',
      phone: '',
      role: '',
      userMetadata: {},
      identities: [],
    );

    when(() => mockAuth.currentUser).thenReturn(mockUser);

    final result = caller.getCurrentUserId();

    expect(result, 'user123');
  });
}
