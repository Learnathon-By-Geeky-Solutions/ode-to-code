import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/auth_service/i_auth_service.dart';

class ResetPasswordController extends GetxController {
  final IAuthService _authService;

  ResetPasswordController({required IAuthService authService})
      : _authService = authService;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> updatePassword(String newPassword) async {
    if (newPassword.isEmpty) {
      Get.snackbar("Error", "Please enter your new password");
      return false;
    }

    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      await _authService.updatePasswordAfterReset(newPassword);
      Get.snackbar("Success", "Password updated successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      return true;
    } catch (e) {
      Logger().e("Password reset error: $e");
      _errorMessage = "Something went wrong";
      Get.snackbar("Error", _errorMessage!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    } finally {
      _inProgress = false;
      update();
    }
  }
}
