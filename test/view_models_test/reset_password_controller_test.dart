import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements IAuthService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // 🛠️ This is the fix!

  late ResetPasswordController controller;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    controller = ResetPasswordController(authService: mockAuthService);

    // Set test mode to true to skip snackbar during tests
    SnackBarUtil.isTestMode = true;
  });

  group('ResetPasswordController Tests', () {
    test('should show snackbar if new password is empty', () async {
      final result = await controller.updatePassword('');
      expect(result, false);
      expect(controller.errorMessage, null); // Because it doesn't throw error
    });

    test('should call updatePasswordAfterReset on valid new password',
        () async {
      when(() => mockAuthService.updatePasswordAfterReset('newPassword'))
          .thenAnswer((_) async {});

      final result = await controller.updatePassword('newPassword');

      expect(result, true);
      expect(controller.errorMessage, null);
      verify(() => mockAuthService.updatePasswordAfterReset('newPassword'))
          .called(1);
    });

    test('should handle error properly during password update', () async {
      when(() => mockAuthService.updatePasswordAfterReset('newPassword'))
          .thenThrow(Exception('Password update failed'));

      final result = await controller.updatePassword('newPassword');

      expect(result, false);
      expect(controller.errorMessage, 'Something went wrong');
    });
  });
}
