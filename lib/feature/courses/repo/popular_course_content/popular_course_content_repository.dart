import 'package:edu_bridge_app/core/resources/export.dart';

class PopularCourseContentRepository extends IPopularCourseContentRepository {
  final INetworkCaller _networkCaller;

  PopularCourseContentRepository({required INetworkCaller networkCaller})
      : _networkCaller = networkCaller;

  @override
  Future<bool> addPopularCourseContent(
      PopularCourseContentModel courseModel) async {
    final response = await _networkCaller.postRequest(
      tableName: "popular_course_content",
      data: courseModel.toMap(),
    );
    return _handlePostResponse(response);
  }

  @override
  Future<List<PopularCourseContentModel>> fetchPopularCourseContentById(
      String courseId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'popular_course_content',
      eqColumn: 'courses_id',
      eqValue: courseId,
    );
    return _handleGetResponse(response, courseId);
  }

  List<PopularCourseContentModel> _handleGetResponse(
      ApiResponse response, String courseId) {
    if (response.isSuccess) {
      final List filteredData = (response.responseData as List).where((data) {
        return data['courses_id'] == courseId;
      }).toList();

      if (filteredData.isNotEmpty) {
        return filteredData
            .map<PopularCourseContentModel>(
                (data) => PopularCourseContentModel.fromMap(data))
            .toList();
      }
    }
    return [];
  }

  bool _handlePostResponse(ApiResponse response) {
    return response.isSuccess;
  }
}
