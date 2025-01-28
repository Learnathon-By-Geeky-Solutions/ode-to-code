import 'package:edu_bridge_app/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final AuthService _authService;
  SignInController({required AuthService authService})
      : _authService = authService;

  // Reactive variables for cleaner state management
  final _logInApiInProgress = false.obs;
  final _errorMessage = ''.obs;

  bool get signInApiInProgress => _logInApiInProgress.value;
  String get errorMessage => _errorMessage.value;

  Future<bool> logIn(String email, String password) async {
    _logInApiInProgress.value = true;
    try {
      User? user =
          await _authService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        _errorMessage.value = '';
        return true;
      } else {
        _errorMessage.value = 'Something went wrong';
        return false;
      }
    } catch (e) {
      _errorMessage.value = e.toString();
      return false;
    } finally {
      _logInApiInProgress.value = false;
    }
  }
}
