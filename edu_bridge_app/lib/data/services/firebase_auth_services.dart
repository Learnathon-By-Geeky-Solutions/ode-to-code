/*
import 'package:edu_bridge_app/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices extends AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (error) {
      print('Some error Occur');
    }
    return null;
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (error) {
      print('Some error Occur');
    }
    return null;
  }
}
*/
