import 'package:edu_bridge_app/data/services/firebase_auth_services.dart';
import 'package:edu_bridge_app/view_model/auth/sign_in_controller.dart';
import 'package:edu_bridge_app/view_model/auth/sign_up_controller.dart';
import 'package:edu_bridge_app/view_model/banner_controller.dart';
import 'package:edu_bridge_app/view_model/category_controller.dart';
import 'package:edu_bridge_app/view_model/chapters_controller.dart';
import 'package:edu_bridge_app/view_model/class_controller.dart';
import 'package:edu_bridge_app/view_model/content_controller.dart';
import 'package:edu_bridge_app/view_model/mentor_controller.dart';
import 'package:edu_bridge_app/view_model/popular_course_content_controller.dart';
import 'package:edu_bridge_app/view_model/popularcourse_controller.dart';
import 'package:edu_bridge_app/view_model/subject_controller.dart';
import 'package:edu_bridge_app/view_model/user_controller.dart';
import 'package:edu_bridge_app/view_model/user_profile_controller.dart';

import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    //Get.put(SignInController(authService: FirebaseAuthServices()));
    //Get.put(SignUpController(authService: FirebaseAuthServices()));
    //Get.put(ForgotPasswordController());
    //Get.put(SubjectsController());
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(UserController());
    Get.put(BannerController());
    Get.put(CategoryController());
    Get.put(ChapterController());
    Get.put(ClassController());
    Get.put(CourseContentController());
    Get.put(MentorController());
    Get.put(PopularCourseController());
    Get.put(PopularCourseContentController());
    Get.put(SubjectController());
    Get.put(UserProfileController());
  }
}
