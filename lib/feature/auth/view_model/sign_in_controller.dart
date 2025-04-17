import 'package:edu_bridge_app/core/resources/export.dart';

class SignInController extends GetxController {
  final AuthService _authService = AuthService();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter email and password");
      return false;
    }

    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      await _authService.signInWithEmail(email, password);
      Get.snackbar("Success", "Signed in successfully!");
      return true;
    } on AuthException catch (e) {
      _errorMessage = e.message;
      Get.snackbar("Error", _errorMessage!);
      return false;
    } finally {
      _inProgress = false;
      update();
    }
  }
}
