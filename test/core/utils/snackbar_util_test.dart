// test/utils/snackbar_util_test.dart

import 'package:edu_bridge_app/core/resources/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

typedef SnackbarCallback = void Function(String title, String message,
    SnackPosition position, Color bgColor, Color textColor);

class SnackbarUtil {
  static bool isTestMode = false;

  // Default to using Get.snackbar
  static SnackbarCallback snackbarCallback = (
    String title,
    String message,
    SnackPosition position,
    Color bgColor,
    Color textColor,
  ) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: bgColor,
      colorText: textColor,
    );
  };

  static void showSuccess(String title, String message) {
    if (kIsWeb || !isTesting()) {
      if (!isTestMode) {
        snackbarCallback(title, message, SnackPosition.TOP, AppColors.green,
            AppColors.white);
      }
    }
  }

  static void showError(String title, String message) {
    if (kIsWeb || !isTesting()) {
      if (!isTestMode) {
        snackbarCallback(
            title, message, SnackPosition.TOP, AppColors.red, AppColors.white);
      }
    }
  }

  static bool isTesting() => false; // Can toggle for other cases
}

void main() {
  group('SnackbarUtil', () {
    late List<String> callLog;

    setUp(() {
      callLog = [];

      // Inject custom snackbar callback for testing
      SnackbarUtil.snackbarCallback = (
        String title,
        String message,
        SnackPosition position,
        Color bgColor,
        Color textColor,
      ) {
        callLog.add('$title - $message');
      };
    });

    test('should call snackbarCallback on showSuccess when not in test mode',
        () {
      SnackbarUtil.isTestMode = false;

      SnackbarUtil.showSuccess('Success', 'Operation was successful');

      expect(callLog.length, 1);
      expect(callLog.first, 'Success - Operation was successful');
    });

    test('should NOT call snackbarCallback on showSuccess when in test mode',
        () {
      SnackbarUtil.isTestMode = true;

      SnackbarUtil.showSuccess('Success', 'Operation was successful');

      expect(callLog.isEmpty, true);
    });

    test('should call snackbarCallback on showError when not in test mode', () {
      SnackbarUtil.isTestMode = false;

      SnackbarUtil.showError('Error', 'Something went wrong');

      expect(callLog.length, 1);
      expect(callLog.first, 'Error - Something went wrong');
    });

    test('should NOT call snackbarCallback on showError when in test mode', () {
      SnackbarUtil.isTestMode = true;

      SnackbarUtil.showError('Error', 'Something went wrong');

      expect(callLog.isEmpty, true);
    });
  });
}
