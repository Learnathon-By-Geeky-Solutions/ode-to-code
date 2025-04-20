import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/auth_service/i_auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements IAuthService {}

class MockSession extends Mock implements Session {}

class MockUser extends Mock implements User {}

void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });

  group('IAuthService Supabase Tests', () {
    const testEmail = 'test@example.com';
    const testPassword = 'strongPassword123';
    const newPassword = 'updatedPassword456';
    final mockUser = MockUser();
    final mockSession = MockSession();

    test('signUpWithEmail returns AuthResponse with user and session',
        () async {
      final response = AuthResponse(session: mockSession, user: mockUser);

      when(() => mockAuthService.signUpWithEmail(testEmail, testPassword))
          .thenAnswer((_) async => response);

      final result =
          await mockAuthService.signUpWithEmail(testEmail, testPassword);

      expect(result.user, isNotNull);
      expect(result.session, isNotNull);
    });

    test('signInWithEmail returns AuthResponse with only user', () async {
      final response = AuthResponse(session: null, user: mockUser);

      when(() => mockAuthService.signInWithEmail(testEmail, testPassword))
          .thenAnswer((_) async => response);

      final result =
          await mockAuthService.signInWithEmail(testEmail, testPassword);

      expect(result.user, isNotNull);
      expect(result.session, isNull);
    });

    test('resetPassword completes without exception', () async {
      when(() => mockAuthService.resetPassword(testEmail))
          .thenAnswer((_) async => Future.value());

      await mockAuthService.resetPassword(testEmail);

      verify(() => mockAuthService.resetPassword(testEmail)).called(1);
    });

    test('updatePasswordAfterReset completes without error', () async {
      when(() => mockAuthService.updatePasswordAfterReset(newPassword))
          .thenAnswer((_) async => Future.value());

      await mockAuthService.updatePasswordAfterReset(newPassword);

      verify(() => mockAuthService.updatePasswordAfterReset(newPassword))
          .called(1);
    });

    test('signOut completes successfully', () async {
      when(() => mockAuthService.signOut())
          .thenAnswer((_) async => Future.value());

      await mockAuthService.signOut();

      verify(() => mockAuthService.signOut()).called(1);
    });

    test('currentUser returns a valid user', () {
      when(() => mockAuthService.currentUser).thenReturn(mockUser);

      final user = mockAuthService.currentUser;

      expect(user, isA<User>());
    });

    test('authStateChanges emits AuthState with signedIn event and session',
        () async {
      final testSession = MockSession();
      final authState = AuthState(AuthChangeEvent.signedIn, testSession);

      final stream = Stream<AuthState>.fromIterable([authState]);

      when(() => mockAuthService.authStateChanges).thenAnswer((_) => stream);

      final emittedStates = await mockAuthService.authStateChanges.toList();

      expect(emittedStates, hasLength(1));
      expect(emittedStates.first.event, AuthChangeEvent.signedIn);
      expect(emittedStates.first.session, testSession);
    });
  });
}
