import 'package:edu_bridge_app/view_model/auth/forgot_password_controller.dart';
import 'package:edu_bridge_app/view_model/auth/login_in_controller.dart';
import 'package:edu_bridge_app/view_model/auth/sign_up_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(ForgotPasswordController());
  }
}
