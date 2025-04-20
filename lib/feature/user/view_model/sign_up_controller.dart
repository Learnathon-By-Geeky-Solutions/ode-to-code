import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/auth_service/i_auth_service.dart';

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
      SnackbarUtil.showError("Error", _errorMessage!);
      return false;
    }

    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      final response = await _authService.signUpWithEmail(email, password);
      if (response.user != null) {
        SnackbarUtil.showSuccess("Success", "Account created successfully!");
        return true;
      } else {
        _errorMessage = "Failed to create an account. Please try again.";
        SnackbarUtil.showError("Error", _errorMessage!);
        return false;
      }
    } on AuthException catch (e) {
      _errorMessage = e.message;
      SnackbarUtil.showError("Error", _errorMessage!);
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
