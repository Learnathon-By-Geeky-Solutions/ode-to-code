import 'package:edu_bridge_app/core/resources/export.dart';

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
      SnackBarUtil.showError("Error", "Please enter your new password");
      return false;
    }

    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      await _authService.updatePasswordAfterReset(newPassword);
      SnackBarUtil.showSuccess("Success", "Password updated successfully");
      return true;
    } catch (e) {
      Logger().e("Password reset error: $e");
      _errorMessage = "Something went wrong";
      SnackBarUtil.showError("Error", _errorMessage!);
      return false;
    } finally {
      _inProgress = false;
      update();
    }
  }
}
