import 'package:edu_bridge_app/core/resources/export.dart';

class PopularCourseRepository extends IPopularCourseRepository {
  final INetworkCaller _networkCaller;

  PopularCourseRepository({required INetworkCaller networkCaller})
      : _networkCaller = networkCaller;

  @override
  Future<String?> uploadCourseImage(File imageFile) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = 'course_images/$fileName';

    final response = await _networkCaller.uploadFile(
      bucketName: 'course_images',
      filePath: filePath,
      file: imageFile,
    );

    return _handleFileUploadResponse(response);
  }

  @override
  Future<bool> addPopularCourse(PopularCourseModel course) async {
    final response = await _networkCaller.postRequest(
      tableName: "courses",
      data: course.toMap(),
    );
    return _handlePostResponse(response);
  }

  @override
  Future<List<PopularCourseModel>> fetchPopularCourses() async {
    final response = await _networkCaller.getRequest(tableName: 'courses');
    return _handleGetResponse(response);
  }

  @override
  Future<bool> saveCourseForUser(String courseId) async {
    final userId = _networkCaller.getCurrentUserId();
    if (userId == null) return false;

    final response = await _networkCaller.postRequest(
      tableName: "user_saved_courses",
      data: {'user_id': userId, 'course_id': courseId},
    );
    return _handlePostResponse(response);
  }

  @override
  Future<bool> isCourseSaved(String courseId) async {
    final userId = _networkCaller.getCurrentUserId();
    if (userId == null) return false;

    final response = await _networkCaller.getRequest(
      tableName: 'user_saved_courses',
      queryParams: {'user_id': userId, 'course_id': courseId},
    );
    return _handleIsCourseSavedResponse(response);
  }

  @override
  Future<bool> unsaveCourseForUser(String courseId) async {
    final userId = _networkCaller.getCurrentUserId();
    if (userId == null) return false;

    final response = await _networkCaller.deleteRequest(
      tableName: 'user_saved_courses',
      queryParams: {'user_id': userId, 'course_id': courseId},
    );
    return _handlePostResponse(response);
  }

  @override
  Future<List<PopularCourseModel>> fetchSavedCourses() async {
    final userId = _networkCaller.getCurrentUserId();
    if (userId == null) return [];

    final savedResponse = await _networkCaller.getRequest(
      tableName: 'user_saved_courses',
      queryParams: {'user_id': userId},
    );

    if (!savedResponse.isSuccess) return [];

    final savedCourseIds = (savedResponse.responseData as List)
        .map<String>((item) => item['course_id'].toString())
        .toList();

    if (savedCourseIds.isEmpty) return [];

    final coursesResponse = await _networkCaller.getRequest(
      tableName: 'courses',
      queryParams: {'id': savedCourseIds},
    );

    return _handleGetResponse(coursesResponse);
  }

  // Helper methods
  String? _handleFileUploadResponse(ApiResponse response) {
    if (response.isSuccess) {
      return response.responseData;
    }
    return null;
  }

  bool _handlePostResponse(ApiResponse response) {
    return response.isSuccess;
  }

  bool _handleIsCourseSavedResponse(ApiResponse response) {
    return response.isSuccess && (response.responseData as List).isNotEmpty;
  }

  List<PopularCourseModel> _handleGetResponse(ApiResponse response) {
    if (response.isSuccess && response.responseData != null) {
      return (response.responseData as List)
          .map<PopularCourseModel>((data) => PopularCourseModel.fromMap(data))
          .toList();
    }
    return [];
  }
}
