import 'package:edu_bridge_app/view_model/auth/sign_in_controller.dart';
import 'package:edu_bridge_app/view_model/auth/sign_up_controller.dart';
import 'package:edu_bridge_app/view_model/banner_controller.dart';
import 'package:edu_bridge_app/view_model/category_controller.dart';
import 'package:edu_bridge_app/view_model/chapters_controller.dart';
import 'package:edu_bridge_app/view_model/class_controller.dart';
import 'package:edu_bridge_app/view_model/content_controller.dart';
import 'package:edu_bridge_app/view_model/mentor_controller.dart';
import 'package:edu_bridge_app/view_model/popular_course_content_controller.dart';
import 'package:edu_bridge_app/view_model/popular_course_controller.dart';
import 'package:edu_bridge_app/view_model/subject_controller.dart';
import 'package:edu_bridge_app/view_model/theming_and_localization/localization_controller.dart';
import 'package:edu_bridge_app/view_model/theming_and_localization/theme_controller.dart';
import 'package:edu_bridge_app/view_model/user_profile_controller.dart';

import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<LocalizationController>(() => LocalizationController());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<BannerController>(() => BannerController(),
        fenix:
            true); // Optional: 'fenix: true' keeps the controller alive after the first use
    Get.put(CategoryController());
    Get.lazyPut<ChapterController>(() => ChapterController());
    Get.lazyPut<ClassController>(() => ClassController());
    Get.lazyPut<CourseContentController>(() => CourseContentController());
    Get.lazyPut<MentorController>(() => MentorController());
    Get.lazyPut<PopularCourseController>(() => PopularCourseController());
    Get.lazyPut<PopularCourseContentController>(
        () => PopularCourseContentController());
    Get.lazyPut<SubjectController>(() => SubjectController());
    Get.lazyPut<UserProfileController>(() => UserProfileController());
  }
}
