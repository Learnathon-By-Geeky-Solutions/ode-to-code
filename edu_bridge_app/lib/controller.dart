import 'package:edu_bridge_app/data/services/firebase_auth_services.dart';
import 'package:edu_bridge_app/view_model/auth/forgot_password_controller.dart';
import 'package:edu_bridge_app/view_model/auth/sign_in_controller.dart';
import 'package:edu_bridge_app/view_model/auth/sign_up_controller.dart';
import 'package:edu_bridge_app/view_model/subject_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController(authService: FirebaseAuthServices()));
    Get.put(SignUpController(authService: FirebaseAuthServices()));
    Get.put(ForgotPasswordController());
    Get.put(SubjectsController());
  }
}
