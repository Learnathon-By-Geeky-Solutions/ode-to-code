import 'package:app_links/app_links.dart';
import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/auth_service/i_auth_service.dart';
import 'package:edu_bridge_app/feature/auth/reset_password/view/reset_password_view.dart';

enum AuthAction { signUp, signIn }

class AuthService extends IAuthService {
  final SupabaseClient _authService = Supabase.instance.client;

  Future<AuthResponse> _handleAuthWithEmail({
    required String email,
    required String password,
    required AuthAction action,
  }) async {
    switch (action) {
      case AuthAction.signUp:
        return await _authService.auth.signUp(email: email, password: password);
      case AuthAction.signIn:
        return await _authService.auth
            .signInWithPassword(email: email, password: password);
    }
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
      _authService.auth.resetPasswordForEmail(
        email,
        redirectTo: 'devcode://password-reset',
      );

  @override
  Future<void> signOut() => _authService.auth.signOut();

  @override
  User? get currentUser => _authService.auth.currentUser;

  @override
  Stream<AuthState> get authStateChanges => _authService.auth.onAuthStateChange;

  @override
  Future<void> updatePasswordAfterReset(String newPassword) async {
    await _authService.auth.updateUser(UserAttributes(password: newPassword));
  }

  /// Listens to deep links and navigates accordingly
  static void configDeepLink() {
    final appLinks = AppLinks(); // Singleton
    appLinks.uriLinkStream.listen((uri) {
      Logger().i("Received deep link: $uri");
      if (uri.host == 'password-reset') {
        Get.offAll(() => const ResetPasswordView());
      }
    });
  }
}
