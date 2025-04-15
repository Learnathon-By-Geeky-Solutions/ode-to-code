import 'package:edu_bridge_app/data/models/popular_course_content_model.dart';

abstract class IPopularCourseContentRepository {
  Future<bool> addPopularCourseContent(PopularCourseContentModel courseModel);
  Future<List<PopularCourseContentModel>> fetchPopularCourseContentById(
      String courseId);
}
