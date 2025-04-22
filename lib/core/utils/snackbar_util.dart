// core/utils/snackbar_util.dart

import 'package:edu_bridge_app/core/resources/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SnackBarUtil {
  static bool isTestMode = false; // Flag to determine if we're in test mode

  static void showSuccess(String title, String message) {
    if (kIsWeb || !isTesting()) {
      // Only show snackbar if not in test mode
      if (!isTestMode) {
        Get.snackbar(
          title,
          message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.green,
          colorText: AppColors.white,
        );
      }
    }
  }

  static void showError(String title, String message) {
    if (kIsWeb || !isTesting()) {
      // Only show snackbar if not in test mode
      if (!isTestMode) {
        Get.snackbar(
          title,
          message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
      }
    }
  }

  // Add a simple method to check if the app is in a test environment
  static bool isTesting() {
    // This can be further customized based on your testing setup
    return false; // Change this to true during testing if needed
  }
}
