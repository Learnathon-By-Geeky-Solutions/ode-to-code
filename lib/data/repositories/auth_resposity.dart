import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _authService = Supabase.instance.client;

  Future<AuthResponse> signUpWithEmail(String email, String password) async {
    return await _authService.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signInWithEmail(String email, String password) async {
    return await _authService.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _authService.auth.signOut();
  }

  User? get currentUser {
    return _authService.auth.currentUser;
  }

  Stream<AuthState> get authStateChanges {
    return _authService.auth.onAuthStateChange;
  }
}
