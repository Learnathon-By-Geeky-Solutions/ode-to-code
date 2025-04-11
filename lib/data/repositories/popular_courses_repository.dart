import 'dart:io';
import 'package:edu_bridge_app/data/models/popular_course_model.dart';
import 'package:edu_bridge_app/data/network_caller/network_caller.dart';

class PopularCourseRepository {
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

    if (response.isSuccess) {
      print("Popular course added successfully!");
      return true;
    } else {
      print("Error adding popular course: ${response.errorMessage}");
      return false;
    }
  }

  Future<List<PopularCourseModel>> fetchPopularCourses() async {
    final response = await _networkCaller.getRequest(
      tableName: 'courses',
    );

    if (response.isSuccess) {
      return (response.responseData as List)
          .map((data) => PopularCourseModel.fromMap(data))
          .toList();
    } else {
      print("Error fetching popular courses: ${response.errorMessage}");
      return [];
    }
  }
}
