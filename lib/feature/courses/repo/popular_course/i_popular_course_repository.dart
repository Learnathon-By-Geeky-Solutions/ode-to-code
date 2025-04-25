import 'package:edu_bridge_app/core/resources/export.dart';

abstract class IPopularCourseRepository {
  Future<String?> uploadCourseImage(File imageFile);
  Future<bool> addPopularCourse(PopularCourseModel course);
  Future<List<PopularCourseModel>> fetchPopularCourses();
  Future<bool> saveCourseForUser(String courseId);
  Future<bool> isCourseSaved(String courseId);
  Future<bool> unsaveCourseForUser(String courseId);
  Future<List<PopularCourseModel>> fetchSavedCourses();
}
