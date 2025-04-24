import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/auth_service/i_auth_service.dart';
import 'package:edu_bridge_app/feature/auth/forgot_password/view_model/forget_password_controller.dart';
import 'package:edu_bridge_app/feature/auth/reset_password/view_model/reset_password_controller.dart';
import 'package:edu_bridge_app/feature/user_saved_item/controller/user_saved_item_controller.dart';
import 'package:edu_bridge_app/feature/user_saved_item/repo/i_user_saved_item_repository.dart';
import 'package:edu_bridge_app/feature/user_saved_item/repo/user_saved_item_repository.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Registering repositories
    Get.lazyPut<IBannerRepository>(() => BannerRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<ICategoryRepository>(() => CategoryRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<IChapterRepository>(() => ChapterRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<IClassRepository>(() => ClassRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<IContentRepository>(() => ContentRepository(networkCaller: NetworkCaller()));
    Get.put<IUserSavedItemRepository>(UserSavedItemRepository(networkCaller: NetworkCaller()));

    Get.lazyPut<IPopularCourseRepository>(() => PopularCourseRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<IPopularCourseContentRepository>(() => PopularCourseContentRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<ISubjectRepository>(() => SubjectRepository(networkCaller: NetworkCaller()));
    Get.lazyPut<IBannerRepository>(() => BannerRepository(networkCaller: NetworkCaller()));


    // Theme and localization
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<LocalizationController>(() => LocalizationController());

    // Authentication Service Binding
    Get.put<IAuthService>(AuthService());


    // Authentication controllers
    Get.put<SignInController>(SignInController(authService: Get.find<IAuthService>()));
    Get.put<SignUpController>(SignUpController(authService: Get.find<IAuthService>()));
    Get.put<ForgotPasswordController>(ForgotPasswordController(authService: Get.find<IAuthService>()));
    Get.put<ResetPasswordController>(ResetPasswordController(authService: Get.find<IAuthService>()));

    // App-specific controllers
    Get.lazyPut<BannerController>(() => BannerController(repository: Get.find<IBannerRepository>()), fenix: true);
    Get.lazyPut<CategoryController>(() => CategoryController(repository: Get.find<ICategoryRepository>()), fenix: true);

    Get.put<ClassController>(ClassController(repository: Get.find<IClassRepository>()));
    Get.put<SubjectController>(SubjectController(repository: Get.find<ISubjectRepository>()));
    Get.put<ChapterController>(ChapterController(repository: Get.find<IChapterRepository>()));
    Get.put<PopularCourseController>(PopularCourseController(repository: Get.find<IPopularCourseRepository>()));

    Get.lazyPut<CourseContentController>(() => CourseContentController(repository: Get.find<IContentRepository>()));

    Get.lazyPut<MentorController>(() => MentorController());


    Get.lazyPut<PopularCourseContentController>(() => PopularCourseContentController(repository: Get.find<IPopularCourseContentRepository>()));

    Get.put<UserProfileController>(UserProfileController(repository: UserProfileRepository(networkCaller: NetworkCaller())));
    Get.put<UserSavedItemController>( UserSavedItemController(repository: Get.find<IUserSavedItemRepository>()));
    Get.put<BannerController>(BannerController(repository: Get.find<IBannerRepository>()));

  }
}
