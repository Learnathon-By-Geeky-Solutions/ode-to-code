import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocking IAuthService
class MockAuthService extends Mock implements IAuthService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SignUpController controller;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    controller = SignUpController(authService: mockAuthService);

    // Enable test mode to prevent snackbars from actually showing
    SnackBarUtil.isTestMode = true;

    registerFallbackValue(AuthResponse(
      user: const User(
        id: '1',
        email: 'test@example.com',
        appMetadata: {},
        userMetadata: {},
        aud: '',
        createdAt: '',
      ),
    ));

    registerFallbackValue(const User(
      id: '1',
      email: 'test@example.com',
      appMetadata: {},
      userMetadata: {},
      aud: '',
      createdAt: '',
    ));
  });

  group('SignUpController Tests', () {
    test('should show error if email or password is empty', () async {
      final result = await controller.signUp('', '');
      expect(result, false);
      expect(controller.errorMessage, "Please enter email and password");
    });

    test('should call signUpWithEmail on valid input', () async {
      when(() =>
              mockAuthService.signUpWithEmail('test@example.com', 'password'))
          .thenAnswer((_) async => AuthResponse(
                user: const User(
                  id: '1',
                  email: 'test@example.com',
                  appMetadata: {},
                  userMetadata: {},
                  aud: '',
                  createdAt: '',
                ),
              ));

      final result = await controller.signUp('test@example.com', 'password');

      expect(result, true);
      expect(controller.errorMessage, null);
      verify(() =>
              mockAuthService.signUpWithEmail('test@example.com', 'password'))
          .called(1);
    });

    test('should handle sign up failure when sign_up is null', () async {
      when(() =>
              mockAuthService.signUpWithEmail('invalid@example.com', '123456'))
          .thenAnswer((_) async => AuthResponse(user: null));

      final result = await controller.signUp('invalid@example.com', '123456');

      expect(result, false);
      expect(controller.errorMessage,
          "Failed to create an account. Please try again.");
    });

    test('should handle AuthException correctly', () async {
      when(() =>
              mockAuthService.signUpWithEmail('error@example.com', 'password'))
          .thenThrow(const AuthException('Registration failed'));

      final result = await controller.signUp('error@example.com', 'password');

      expect(result, false);
      expect(controller.errorMessage, 'Registration failed');
    });

    test('should toggle inProgress during signUp', () async {
      when(() =>
              mockAuthService.signUpWithEmail('test@example.com', 'password'))
          .thenAnswer((_) async => AuthResponse(
                user: const User(
                  id: '1',
                  email: 'test@example.com',
                  appMetadata: {},
                  userMetadata: {},
                  aud: '',
                  createdAt: '',
                ),
              ));

      final future = controller.signUp('test@example.com', 'password');

      expect(controller.inProgress, true);

      final result = await future;

      expect(result, true);
      expect(controller.inProgress, false);
    });
  });
}
