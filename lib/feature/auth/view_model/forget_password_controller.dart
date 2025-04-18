import 'package:edu_bridge_app/core/resources/export.dart';

class ForgetPasswordController extends GetxController {
  final AuthService _authService = AuthService();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      Get.snackbar("Error", "Please enter your email");
      return false;
    }

    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      await _authService.resetPassword(email);
      Get.snackbar("Success", "Password reset email sent");
      return true;
    } on AuthException catch (e) {
      _errorMessage = e.message;
      Get.snackbar("Error", _errorMessage!);
      return false;
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      return false;
    } finally {
      _inProgress = false;
      update();
    }
  }
}
