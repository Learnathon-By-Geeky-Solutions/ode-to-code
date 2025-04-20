import 'package:get/get.dart';

class UIUtils {
  static void showError(String message) {
    Get.snackbar("Error", message);
  }

  static void setLoadingState(bool isLoading) {
    if (isLoading) {
    } else {}
  }

  static void showSnackbar(String title, String message) {
    Get.snackbar(title, message);
  }
}
