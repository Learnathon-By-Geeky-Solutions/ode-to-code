import 'package:edu_bridge_app/data/models/course_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CourseRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to add a new course to the database
  Future<bool> addCourse(CourseModel courseModel) async {
    try {
      // Insert the course into the "courses" table
      await _supabase.from("courses").insert(courseModel.toMap());
      return true;
    } catch (e) {
      print("Error adding course: $e");
      return false;
    }
  }

  // Method to fetch all courses from the database
  Future<List<CourseModel>> fetchCourses() async {
    final response = await _supabase.from("courses").select();
    if (response is List) {
      return response.map((data) => CourseModel.fromMap(data)).toList();
    }
    return [];
  }

  // Method to fetch a course by its ID
  Future<CourseModel?> fetchCourseById(String id) async {
    final response =
        await _supabase.from("courses").select().eq('id', id).single();
    if (response != null) {
      return CourseModel.fromMap(response);
    }
    return null;
  }

  // Method to update a course's information
  Future<bool> updateCourse(CourseModel courseModel) async {
    try {
      await _supabase
          .from("courses")
          .update(courseModel.toMap())
          .eq('id', courseModel.id!);
      return true;
    } catch (e) {
      print("Error updating course: $e");
      return false;
    }
  }

  // Method to delete a course by its ID
  Future<bool> deleteCourse(String id) async {
    try {
      await _supabase.from("courses").delete().eq('id', id);
      return true;
    } catch (e) {
      print("Error deleting course: $e");
      return false;
    }
  }
}
