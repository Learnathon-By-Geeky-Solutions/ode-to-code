import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/feature/auth/repo/IAuthService.dart';

class AuthService implements IAuthService {
  final SupabaseClient _authService = Supabase.instance.client;

  @override
  Future<AuthResponse> signUpWithEmail(String email, String password) async {
    return await _authService.auth.signUp(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    return await _authService.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> resetPassword(String email) async {
    await _authService.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> signOut() async {
    await _authService.auth.signOut();
  }

  @override
  User? get currentUser {
    return _authService.auth.currentUser;
  }

  @override
  Stream<AuthState> get authStateChanges {
    return _authService.auth.onAuthStateChange;
  }
}
