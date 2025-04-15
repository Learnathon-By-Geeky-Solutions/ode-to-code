import 'dart:io';
import 'package:edu_bridge_app/data/models/popular_course_model.dart';
import 'package:edu_bridge_app/data/repositories/popular_course/i_popular_course_repository.dart';
import 'package:edu_bridge_app/data/service/i_network_caller.dart';
import 'package:edu_bridge_app/data/service/network_caller.dart';

class PopularCourseRepository extends IPopularCourseRepository {
  PopularCourseRepository({required INetworkCaller networkCaller});
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<String?> uploadCourseImage(File imageFile) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = 'course_images/$fileName';

    final response = await _networkCaller.uploadFile(
      bucketName: 'course_images',
      filePath: filePath,
      file: imageFile,
    );

    return response.isSuccess ? response.responseData : null;
  }

  Future<bool> addPopularCourse(PopularCourseModel course) async {
    final response = await _networkCaller.postRequest(
      tableName: "courses",
      data: course.toMap(),
    );
    return response.isSuccess;
  }

  Future<List<PopularCourseModel>> fetchPopularCourses() async {
    final response = await _networkCaller.getRequest(
      tableName: 'courses',
    );

    if (response.isSuccess) {
      return (response.responseData as List)
          .map((data) => PopularCourseModel.fromMap(data))
          .toList();
    }
    return [];
  }

  Future<bool> saveCourseForUser(String courseId) async {
    final userId = _networkCaller.getCurrentUserId();
    if (userId == null) return false;

    final response = await _networkCaller.postRequest(
      tableName: "user_saved_courses",
      data: {
        'user_id': userId,
        'course_id': courseId,
      },
    );
    return response.isSuccess;
  }

  Future<bool> isCourseSaved(String courseId) async {
    final userId = _networkCaller.getCurrentUserId();
    if (userId == null) return false;

    final response = await _networkCaller.getRequest(
      tableName: 'user_saved_courses',
      queryParams: {
        'user_id': userId,
        'course_id': courseId,
      },
    );
    return response.isSuccess && (response.responseData as List).isNotEmpty;
  }

  Future<bool> unsaveCourseForUser(String courseId) async {
    final userId = _networkCaller.getCurrentUserId();
    if (userId == null) return false;

    final response = await _networkCaller.deleteRequest(
      tableName: 'user_saved_courses',
      queryParams: {
        'user_id': userId,
        'course_id': courseId,
      },
    );
    return response.isSuccess;
  }

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

    if (coursesResponse.isSuccess) {
      return (coursesResponse.responseData as List)
          .map((data) => PopularCourseModel.fromMap(data))
          .toList();
    }
    return [];
  }
}
