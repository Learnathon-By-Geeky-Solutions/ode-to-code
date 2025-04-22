import 'package:edu_bridge_app/core/resources/export.dart';

class UserProfileUtils {
  static Future<void> fetchProfileData(UserProfileController controller) async {
    final supabase = Supabase.instance.client;
    final email = supabase.auth.currentSession?.user.email ?? '';
    if (email.isNotEmpty) {
      try {
        await controller.fetchUserProfile(email);
      } catch (e) {
        SnackBarUtil.showError("Error fetching user profile: $e", "$e");
      }
    } else {
      SnackBarUtil.showError("User is not logged in.", "");
    }
  }
}
