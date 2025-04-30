import 'package:edu_bridge_app/core/export.dart';

class SignUpController extends GetxController {
  final IAuthService _authService;

  SignUpController({required IAuthService authService})
      : _authService = authService;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _errorMessage = "Please enter email and password";
      SnackBarUtil.showError("Error", _errorMessage!);
      return false;
    }

    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      final response = await _authService.signUpWithEmail(email, password);
      if (response.user != null) {
        SnackBarUtil.showSuccess(
            "Check Mail for Conformation ", "Account created successfully!");
        return true;
      } else {
        _errorMessage = "Failed to create an account. Please try again.";
        SnackBarUtil.showError("Error", _errorMessage!);
        return false;
      }
    } on AuthException catch (e) {
      _errorMessage = e.message;
      SnackBarUtil.showError("Error", _errorMessage!);
      return false;
    } catch (e) {
      _errorMessage = null;
      return false;
    } finally {
      _inProgress = false;
      update();
    }
  }
}
