import 'package:edu_bridge_app/core/resources/export.dart';

class PopularCourseContentRepository extends IPopularCourseContentRepository {
  PopularCourseContentRepository({required INetworkCaller networkCaller});
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<bool> addPopularCourseContent(
      PopularCourseContentModel courseModel) async {
    final response = await _networkCaller.postRequest(
      tableName: "popular_course_content",
      data: courseModel.toMap(),
    );

    if (response.isSuccess) {
      print("Popular course content added successfully!");
      return true;
    } else {
      print("Error adding popular course content: ${response.errorMessage}");
      return false;
    }
  }

  Future<List<PopularCourseContentModel>> fetchPopularCourseContentById(
      String courseId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'popular_course_content',
      eqColumn: 'courses_id',
      eqValue: courseId,
    );

    if (response.isSuccess) {
      return (response.responseData as List)
          .map<PopularCourseContentModel>(
            (data) => PopularCourseContentModel.fromMap(data),
          )
          .toList();
    } else {
      print("Error fetching popular course content: ${response.errorMessage}");
      return [];
    }
  }
}
