import 'package:edu_bridge_app/core/resources/export.dart';

enum AuthAction { signUp, signIn }

class AuthService extends IAuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<AuthResponse> _handleAuthWithEmail({
    required String email,
    required String password,
    required AuthAction action,
  }) async {
    final handlers = {
      AuthAction.signUp: () =>
          _supabaseClient.auth.signUp(email: email, password: password),
      AuthAction.signIn: () => _supabaseClient.auth
          .signInWithPassword(email: email, password: password),
    };

    return await handlers[action]!();
  }

  @override
  Future<AuthResponse> signUpWithEmail(String email, String password) =>
      _handleAuthWithEmail(
        email: email,
        password: password,
        action: AuthAction.signUp,
      );

  @override
  Future<AuthResponse> signInWithEmail(String email, String password) =>
      _handleAuthWithEmail(
        email: email,
        password: password,
        action: AuthAction.signIn,
      );

  @override
  Future<void> resetPassword(String email) =>
      _supabaseClient.auth.resetPasswordForEmail(
        email,
        redirectTo: 'devcode://password-reset',
      );

  @override
  Future<void> signOut() => _supabaseClient.auth.signOut();

  @override
  User? get currentUser => _supabaseClient.auth.currentUser;

  @override
  Stream<AuthState> get authStateChanges =>
      _supabaseClient.auth.onAuthStateChange;

  @override
  Future<void> updatePasswordAfterReset(String newPassword) async {
    await _supabaseClient.auth
        .updateUser(UserAttributes(password: newPassword));
  }
}
