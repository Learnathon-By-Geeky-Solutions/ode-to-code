import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/auth_service/i_auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Create mock classes for AuthResponse and User
class MockAuthService extends Mock implements IAuthService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SignInController controller;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    controller = SignInController(authService: mockAuthService);

    // Set test mode to true to skip snackbar during tests
    SnackbarUtil.isTestMode = true;

    // Register fallback values for complex types
    registerFallbackValue(AuthResponse(
        user: const User(
            id: '1',
            email: 'test@example.com',
            appMetadata: {},
            userMetadata: {},
            aud: '',
            createdAt: '')));
    registerFallbackValue(const User(
        id: '1',
        email: 'test@example.com',
        appMetadata: {},
        userMetadata: {},
        aud: '',
        createdAt: ''));
  });

  group('SignInController Tests', () {
    test('should show snackbar if email or password is empty', () async {
      final result = await controller.signIn('', '');
      expect(result, false);
      expect(controller.errorMessage, null); // Because it doesn't throw error
    });

    test('should call signInWithEmail on valid credentials', () async {
      when(() =>
              mockAuthService.signInWithEmail('test@example.com', 'password'))
          .thenAnswer((_) async => AuthResponse(
                  user: const User(
                id: '1',
                email: 'test@example.com',
                appMetadata: {},
                userMetadata: {},
                aud: '',
                createdAt: '',
              )));

      final result = await controller.signIn('test@example.com', 'password');

      expect(result, true);
      expect(controller.errorMessage, null);
      verify(() =>
              mockAuthService.signInWithEmail('test@example.com', 'password'))
          .called(1);
    });

    test('should handle sign in failure when user is null', () async {
      when(() => mockAuthService.signInWithEmail(
              'wrong@example.com', 'wrongpassword'))
          .thenAnswer((_) async => AuthResponse(user: null));

      final result =
          await controller.signIn('wrong@example.com', 'wrongpassword');

      expect(result, false);
      expect(controller.errorMessage,
          'Failed to sign in. Please check your credentials.');
    });

    test('should handle AuthException properly', () async {
      when(() =>
              mockAuthService.signInWithEmail('error@example.com', 'password'))
          .thenThrow(const AuthException('Auth failed'));

      final result = await controller.signIn('error@example.com', 'password');

      expect(result, false);
      expect(controller.errorMessage, 'Auth failed');
    });

    test('should handle generic error', () async {
      when(() =>
              mockAuthService.signInWithEmail('oops@example.com', 'password'))
          .thenThrow(Exception('Something broke'));

      final result = await controller.signIn('oops@example.com', 'password');

      expect(result, false);
      expect(
          controller.errorMessage, null); // Because generic errors are not set
    });
  });
}
