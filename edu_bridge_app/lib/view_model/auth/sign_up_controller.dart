import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/data/services/firebase_auth_services.dart';
import 'package:edu_bridge_app/view/auth/sign_in/Sign_In_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  // Reactive variables for state management
  final _errorMessage = ''.obs;
  final _signUpApiProgress = false.obs;

  // Getters for reactive variables
  bool get signUpApiInProgress => _signUpApiProgress.value;
  String get errorMessage => _errorMessage.value;

  /// Method to sign up a user using email and password
  Future<bool> signUp(String email, String password) async {
    _signUpApiProgress.value = true;

    try {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        // Save user information in Firestore
        await _saveUserToFirestore(user.uid, email);

        Get.snackbar('Sign Up', 'User successfully created',
            snackPosition: SnackPosition.TOP);
        Get.offAll(() => const SignInView());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _errorMessage.value = e.toString();
      _showErrorSnackbar(_errorMessage.value);
      return false;
    } finally {
      _signUpApiProgress.value = false;
    }
  }

  /// Helper method to save user data to Firestore
  Future<void> _saveUserToFirestore(String userId, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'email': email,
      'createdAt': DateTime.now(),
    });
  }

  /// Helper method to show error SnackBars
  void _showErrorSnackbar(String message) {
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  }
}
