import 'package:edu_bridge_app/data/models/popular_course_content_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PopularCourseContentRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> addPopularCourseContent(
      PopularCourseContentModel courseModel) async {
    try {
      final response = await _supabase
          .from("popular_course_content")
          .insert(courseModel.toMap());

      print("Supabase Response: $response");

      return true;
    } catch (e) {
      print("Supabase Error: $e");
      return false;
    }
  }

  Future<List<PopularCourseContentModel>> fetchPopularCourseContentById(
      String courseId) async {
    try {
      // Query to fetch popular courses based on courseId
      final response = await _supabase
          .from('popular_course_content')
          .select()
          .eq('courses_id', courseId);

      // Mapping the response data to a list of PopularCourseModel objects
      return response
          .map<PopularCourseContentModel>(
            (data) => PopularCourseContentModel.fromMap(data),
          )
          .toList();
    } catch (e) {
      return []; // Returning an empty list if an error occurs
    }
  }
}
