import 'package:app_links/app_links.dart';
import 'package:edu_bridge_app/core/export.dart';
import 'package:edu_bridge_app/feature/auth/reset_password/view/reset_password_view.dart';

class DeepLinkService {
  static void configure() {
    final appLinks = AppLinks();
    appLinks.uriLinkStream.listen((uri) {
      Logger().i("Received deep link: $uri");

      if (uri.host == 'password-reset') {
        Get.offAll(() => const ResetPasswordView());
      }
    });
  }
}
