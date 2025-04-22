import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/auth_service/i_auth_service.dart';
import 'package:edu_bridge_app/feature/auth/forgot_password/view_model/forget_password_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements IAuthService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // 🛠️ This is the fix!

  late ForgotPasswordController controller;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    controller = ForgotPasswordController(authService: mockAuthService);

    // Set test mode to true to skip snackbar during tests
    SnackBarUtil.isTestMode = true;
  });

  group('ForgotPasswordController Tests', () {
    test('should show snackbar if email is empty', () async {
      final result = await controller.sendPasswordResetEmail('');
      expect(result, false);
      expect(controller.errorMessage, null); // Because it doesn't throw error
    });

    test('should call resetPassword on valid email', () async {
      when(() => mockAuthService.resetPassword('test@example.com'))
          .thenAnswer((_) async {});

      final result =
          await controller.sendPasswordResetEmail('test@example.com');

      expect(result, true);
      expect(controller.errorMessage, null);
      verify(() => mockAuthService.resetPassword('test@example.com')).called(1);
    });

    test('should handle AuthException properly', () async {
      when(() => mockAuthService.resetPassword('error@example.com'))
          .thenThrow(const AuthException('Auth failed'));

      final result =
          await controller.sendPasswordResetEmail('error@example.com');

      expect(result, false);
      expect(controller.errorMessage, 'Auth failed');
    });

    test('should handle generic error', () async {
      when(() => mockAuthService.resetPassword('oops@example.com'))
          .thenThrow(Exception('Something broke'));

      final result =
          await controller.sendPasswordResetEmail('oops@example.com');

      expect(result, false);
      expect(
          controller.errorMessage, null); // Because generic errors are not set
    });
  });
}
