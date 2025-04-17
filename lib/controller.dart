import 'package:edu_bridge_app/core/resources/export.dart';

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
    Get.put<CategoryController>(
        CategoryController(repository: Get.find<ICategoryRepository>()));

    Get.put<ClassController>(
        ClassController(repository: Get.find<IClassRepository>()));

    Get.put<SubjectController>(
        SubjectController(repository: Get.find<ISubjectRepository>()));

    Get.put<ChapterController>(
        ChapterController(repository: Get.find<IChapterRepository>()));

    Get.lazyPut<CourseContentController>(() =>
        CourseContentController(repository: Get.find<IContentRepository>()));

    Get.lazyPut<MentorController>(() => MentorController());

    Get.lazyPut<PopularCourseController>(() => PopularCourseController(
        repository: Get.find<IPopularCourseRepository>()));

    Get.lazyPut<PopularCourseContentController>(() =>
        PopularCourseContentController(
            repository: Get.find<IPopularCourseContentRepository>()));
    Get.lazyPut<UserProfileController>(() => UserProfileController());
  }
}
