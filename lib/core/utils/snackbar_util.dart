import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter/foundation.dart';

class SnackBarUtil {
  static bool isTestMode = false;

  static void showSuccess(String title, String message) {
    if (kIsWeb || !isTesting()) {
      if (!isTestMode) {
        Get.bottomSheet(
          _buildBottomSheet(
              title, message.tr, AppColors.green, Icons.check_circle),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
      }
    }
  }

  static void showError(String title, String message) {
    if (kIsWeb || !isTesting()) {
      if (!isTestMode) {
        Get.bottomSheet(
          _buildBottomSheet(title, message, AppColors.red, Icons.error),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
      }
    }
  }

  static Widget _buildBottomSheet(
      String title, String message, Color backgroundColor, IconData icon) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.white, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title.tr,
                    customStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: message.tr,
                    customStyle: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.white, size: 20),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }

  static bool isTesting() {
    return false;
  }
}
