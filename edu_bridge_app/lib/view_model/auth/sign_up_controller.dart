import 'package:edu_bridge_app/data/repositories/auth_resposity.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpController extends GetxController {
  final AuthService _authService = AuthService();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter email and password");
      return false;
    }

    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      await _authService.signUpWithEmail(email, password);
      Get.snackbar("Success", "Account created successfully!");
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
