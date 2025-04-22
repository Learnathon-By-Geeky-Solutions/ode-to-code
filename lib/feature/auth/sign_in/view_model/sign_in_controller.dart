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
    if (!_isValidInput(email, password)) return false;

    _startProgress();

    final result = await _attemptSignIn(email, password);

    _stopProgress();
    return result;
  }

  bool _isValidInput(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      SnackBarUtil.showError("Error", "Please enter email and password");
      return false;
    }
    return true;
  }

  void _startProgress() {
    _inProgress = true;
    _errorMessage = null;
    update();
  }

  void _stopProgress() {
    _inProgress = false;
    update();
  }

  Future<bool> _attemptSignIn(String email, String password) async {
    try {
      final response = await _authService.signInWithEmail(email, password);
      if (response.user != null) {
        SnackBarUtil.showSuccess("Success", "Signed in successfully!");
        return true;
      }
      _handleError("Failed to sign in. Please check your credentials.");
    } on AuthException catch (e) {
      _handleError(e.message);
    } catch (_) {
      _handleError();
    }
    return false;
  }

  void _handleError([String? message]) {
    _errorMessage = message;
    if (message != null) {
      SnackBarUtil.showError("Error", message);
    }
  }
}
