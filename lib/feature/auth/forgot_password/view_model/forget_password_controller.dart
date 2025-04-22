import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/auth_service/i_auth_service.dart';

class ForgotPasswordController extends GetxController {
  final IAuthService _authService;

  ForgotPasswordController({required IAuthService authService})
      : _authService = authService;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      SnackBarUtil.showError("Error", "Please enter your email");
      return false;
    }

    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      await _authService.resetPassword(email);
      SnackBarUtil.showSuccess("Success", "Password reset email sent");
      return true;
    } on AuthException catch (e) {
      _errorMessage = e.message;
      SnackBarUtil.showError("Error", _errorMessage!);
      return false;
    } catch (e) {
      SnackBarUtil.showError("Error", "Something went wrong");
      return false;
    } finally {
      _inProgress = false;
      update();
    }
  }
}
