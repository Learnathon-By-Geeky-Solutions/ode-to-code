import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/auth_service/i_auth_service.dart';

class SignInController extends GetxController {
  final IAuthService _authService;

  SignInController({required IAuthService authService})
      : _authService = authService;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      SnackbarUtil.showError("Error", "Please enter email and password");
      return false;
    }

    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      final response = await _authService.signInWithEmail(email, password);
      if (response.user != null) {
        SnackbarUtil.showSuccess("Success", "Signed in successfully!");
        return true;
      } else {
        _errorMessage = "Failed to sign in. Please check your credentials.";
        SnackbarUtil.showError("Error", _errorMessage!);
        return false;
      }
    } on AuthException catch (e) {
      _errorMessage = e.message;
      SnackbarUtil.showError("Error", _errorMessage!);
      return false;
    } catch (e) {
      // Handle any other kind of exception
      // Optional: You could also log this error somewhere
      _errorMessage = null; // Or provide a fallback message
      return false;
    } finally {
      _inProgress = false;
      update();
    }
  }
}
