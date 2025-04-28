import 'package:edu_bridge_app/core/export.dart';

abstract class IPopularCourseContentRepository {
  Future<bool> addPopularCourseContent(PopularCourseContentModel courseModel);
  Future<List<PopularCourseContentModel>> fetchPopularCourseContentById(
      String courseId);
}
