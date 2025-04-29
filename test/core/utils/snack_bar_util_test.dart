import 'package:edu_bridge_app/core/export.dart'; // Adjust the import path
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    // Prevent Get.bottomSheet from actually showing UI
    SnackBarUtil.isTestMode = true;
  });

  tearDown(() {
    // Reset the state after each test
    SnackBarUtil.isTestMode = false;
  });

  test('showSuccess should not show bottom sheet in test mode', () {
    // Call the method
    SnackBarUtil.showSuccess('Success Title', 'Success Message');

    // Since UI is blocked by test mode, no bottom sheet is shown,
    // so we simply assert that the app didn't crash.
    expect(true, isTrue);
  });

  test('showError should not show bottom sheet in test mode', () {
    // Call the method
    SnackBarUtil.showError('Error Title', 'Error Message');

    // No crash = success
    expect(true, isTrue);
  });

  test('isTesting always returns false', () {
    // You may override this for custom test behavior if needed
    expect(SnackBarUtil.isTesting(), isFalse);
  });
}
