import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Observable variables for reactive UI updates
  var isApiInProgress = false.obs;
  var errorMessage = ''.obs;

  Future<bool> sendPasswordReset(String email) async {
    try {
      isApiInProgress.value = true;

      // Send password reset email
      await _auth.sendPasswordResetEmail(email: email);

      // Success case
      return true;
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth errors
      errorMessage.value = _getErrorMessage(e);
      Get.snackbar('Warning', errorMessage.value);
      return false;
    } finally {
      isApiInProgress.value = false;
    }
  }

  // Helper method to map error codes to user-friendly messages
  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid. Please check and try again.';
      case 'user-not-found':
        return 'No user found with this email address.';
      default:
        return 'An error occurred: ${e.message ?? "Unknown error"}';
    }
  }
}
