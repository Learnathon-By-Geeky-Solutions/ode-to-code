import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/auth/sign_in/Sign_In_view.dart';

class OnBoardingController extends GetxController {
  PageController controller = PageController();
  bool onLastPage = false;

  void onPageChanged(int index) {
    onLastPage = (index == 2);
    update();
  }

  void skipToLastPage() {
    controller.jumpToPage(2);
    update();
  }

  void nextPage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void goToSignIn() {
    Get.offAll(() => const SignInView());
  }
}
