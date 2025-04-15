import 'package:edu_bridge_app/data/repositories/banner/banner_repository.dart';
import 'package:edu_bridge_app/data/repositories/banner/i_banner_repository.dart';
import 'package:edu_bridge_app/data/repositories/category/category_repository.dart';
import 'package:edu_bridge_app/data/repositories/category/i_category_repository.dart';
import 'package:edu_bridge_app/data/repositories/chapters/chapters_repository.dart';
import 'package:edu_bridge_app/data/repositories/chapters/i_chapters_repository.dart';
import 'package:edu_bridge_app/data/repositories/classes/classes_repository.dart';
import 'package:edu_bridge_app/data/repositories/classes/i_classes_repository.dart';
import 'package:edu_bridge_app/data/repositories/content/content_repository.dart';
import 'package:edu_bridge_app/data/repositories/content/i_content_repository.dart';
import 'package:edu_bridge_app/data/repositories/popular_course/i_popular_course_repository.dart';
import 'package:edu_bridge_app/data/repositories/popular_course/popular_courses_repository.dart';
import 'package:edu_bridge_app/data/repositories/popular_course_content/i_popular_course_content_repository.dart';
import 'package:edu_bridge_app/data/repositories/popular_course_content/popular_course_content_repository.dart';
import 'package:edu_bridge_app/data/repositories/subjects/i_subjects_repository.dart';
import 'package:edu_bridge_app/data/repositories/subjects/subjects_repository.dart';
import 'package:edu_bridge_app/data/service/network_caller.dart';
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
    // Registering repositories
    Get.lazyPut<IBannerRepository>(
        () => BannerRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<ICategoryRepository>(
        () => CategoryRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<IChapterRepository>(
        () => ChapterRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<IClassRepository>(
        () => ClassRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<IContentRepository>(
        () => ContentRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<IPopularCourseRepository>(
        () => PopularCourseRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<IPopularCourseContentRepository>(
        () => PopularCourseContentRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<ISubjectRepository>(
        () => SubjectRepository(networkCaller: NetworkCaller()));

    // Theme and localization
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<LocalizationController>(() => LocalizationController());

    // Authentication
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<SignUpController>(() => SignUpController());

    // App-specific controllers
    Get.lazyPut<BannerController>(
        () => BannerController(repository: Get.find<IBannerRepository>()),
        fenix: true);
    Get.lazyPut<CategoryController>(
        () => CategoryController(repository: Get.find<ICategoryRepository>()));
    Get.lazyPut<ChapterController>(
        () => ChapterController(repository: Get.find<IChapterRepository>()));
    Get.lazyPut<ClassController>(
        () => ClassController(repository: Get.find<IClassRepository>()));
    Get.lazyPut<CourseContentController>(() =>
        CourseContentController(repository: Get.find<IContentRepository>()));
    Get.lazyPut<MentorController>(() => MentorController());
    Get.lazyPut<PopularCourseController>(() => PopularCourseController(
        repository: Get.find<IPopularCourseRepository>()));
    Get.lazyPut<PopularCourseContentController>(() =>
        PopularCourseContentController(
            repository: Get.find<IPopularCourseContentRepository>()));
    Get.lazyPut<SubjectController>(
        () => SubjectController(repository: Get.find<ISubjectRepository>()));
    Get.lazyPut<UserProfileController>(() => UserProfileController());
  }
}
