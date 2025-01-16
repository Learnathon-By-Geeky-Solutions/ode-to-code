import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _forgotPasswordApiInProgress = false;
  String _error = '';

  bool get forgotPasswordApiInProgress => _forgotPasswordApiInProgress;
  String get error => _error;

  Future<bool> forgotPassword(String email) async {
    bool isSuccess = false;
    try {
      _forgotPasswordApiInProgress = true;
      update();

      await _auth.sendPasswordResetEmail(email: email);
      isSuccess = true; // Only set this to true if no exception is thrown
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        _error = 'The email address is not valid. Please check and try again.';
      } else if (e.code == 'user-not-found') {
        _error = 'No user found with this email address.';
      } else {
        _error = 'An error occurred: ${e.message}';
      }
      Get.snackbar('Warning', _error);
    } finally {
      _forgotPasswordApiInProgress = false;
      update();
    }
    return isSuccess;
  }
}
