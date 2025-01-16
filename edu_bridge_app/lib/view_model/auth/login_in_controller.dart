import 'package:edu_bridge_app/data/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  // Reactive variables for cleaner state management
  final _logInApiInProgress = false.obs;
  final _errorMessage = ''.obs;

  bool get signInApiInProgress => _logInApiInProgress.value;
  String get errorMessage => _errorMessage.value;

  Future<bool> logIn(String email, String password) async {
    _logInApiInProgress.value = true;
    try {
      User? user = await _auth.logInWithEmailAndPassword(email, password);
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
