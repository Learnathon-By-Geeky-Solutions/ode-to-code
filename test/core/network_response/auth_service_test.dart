import 'package:flutter_test/flutter_test.dart';
import 'package:edu_bridge_app/core/services/auth_service/auth_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockAuthResponse extends Mock implements AuthResponse {}

class MockUser extends Mock implements User {}

class MockUserResponse extends Mock implements UserResponse {}

class FakeUserAttributes extends Fake implements UserAttributes {}

void main() {
  late MockSupabaseClient mockClient;
  late MockGoTrueClient mockAuth;
  late AuthService authService;

  const testEmail = 'test@example.com';
  const testPassword = 'password123';

  setUpAll(() {
    // Register fallback value for UserAttributes
    registerFallbackValue(FakeUserAttributes());
  });

  // Initialize Supabase before tests
  setUpAll(() async {
    mockClient = MockSupabaseClient();
    mockAuth = MockGoTrueClient();

    when(() => mockClient.auth).thenReturn(mockAuth);

    // Mock initialization (or use a dummy initialization)
    await Supabase.initialize(
      url: 'https://your-project.supabase.co',
      anonKey: 'your-anon-key',
    );

    Supabase.instance.client = mockClient;
  });

  setUp(() {
    authService = AuthService();
  });

  group('AuthService', () {
    test('signUpWithEmail calls signUp and returns AuthResponse', () async {
      final mockResponse = MockAuthResponse();

      when(() => mockAuth.signUp(email: testEmail, password: testPassword))
          .thenAnswer((_) async => mockResponse);

      final result = await authService.signUpWithEmail(testEmail, testPassword);

      expect(result, mockResponse);
      verify(() => mockAuth.signUp(email: testEmail, password: testPassword))
          .called(1);
    });

    test('signInWithEmail calls signInWithPassword and returns AuthResponse',
        () async {
      final mockResponse = MockAuthResponse();

      when(() => mockAuth.signInWithPassword(
          email: testEmail,
          password: testPassword)).thenAnswer((_) async => mockResponse);

      final result = await authService.signInWithEmail(testEmail, testPassword);

      expect(result, mockResponse);
      verify(() => mockAuth.signInWithPassword(
          email: testEmail, password: testPassword)).called(1);
    });

    test('resetPassword calls resetPasswordForEmail', () async {
      when(() => mockAuth.resetPasswordForEmail(any(),
          redirectTo: any(named: 'redirectTo'))).thenAnswer((_) async => {});

      await authService.resetPassword(testEmail);

      verify(() => mockAuth.resetPasswordForEmail(testEmail,
          redirectTo: any(named: 'redirectTo'))).called(1);
    });

    test('signOut calls auth.signOut', () async {
      when(() => mockAuth.signOut()).thenAnswer((_) async => {});

      await authService.signOut();

      verify(() => mockAuth.signOut()).called(1);
    });

    test('updatePasswordAfterReset updates the password', () async {
      final mockUserResponse = MockUserResponse();

      when(() => mockAuth.updateUser(any()))
          .thenAnswer((_) async => mockUserResponse);

      await authService.updatePasswordAfterReset(testPassword);

      verify(() => mockAuth.updateUser(UserAttributes(password: testPassword)))
          .called(1);
    });

    test('currentUser returns user from auth', () {
      final mockUser = MockUser();
      when(() => mockAuth.currentUser).thenReturn(mockUser);

      final user = authService.currentUser;

      expect(user, mockUser);
    });

    test('authStateChanges returns stream from auth', () {
      const stream = Stream<AuthState>.empty();
      when(() => mockAuth.onAuthStateChange).thenAnswer((_) => stream);

      final result = authService.authStateChanges;

      expect(result, stream);
    });
  });
}
