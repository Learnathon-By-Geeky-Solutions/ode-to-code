import 'package:edu_bridge_app/core/export.dart';

abstract class IAuthService {
  Future<AuthResponse> signUpWithEmail(String email, String password);
  Future<AuthResponse> signInWithEmail(String email, String password);
  Future<void> resetPassword(String email);
  Future<void> updatePasswordAfterReset(String newPassword); // ✅ Add this line
  Future<void> signOut();
  User? get currentUser;
  Stream<AuthState> get authStateChanges;
}
