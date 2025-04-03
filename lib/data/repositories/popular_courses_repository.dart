import 'dart:io';
import 'package:edu_bridge_app/data/models/popular_course_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PopularCourseRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to upload course image to Supabase Storage
  Future<String?> uploadCourseImage(File imageFile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'course_images/$fileName';

      // Uploading the file to Supabase storage
      await _supabase.storage.from('course_images').upload(filePath, imageFile);

      // Returning the public URL of the uploaded image
      return _supabase.storage.from('course_images').getPublicUrl(filePath);
    } catch (e) {
      return null;
    }
  }

  // Method to add a new popular course to the database
  Future<bool> addPopularCourse(PopularCourseModel course) async {
    try {
      // Inserting the popular course into the "popular_courses" table
      await _supabase.from("courses").insert(course.toMap());
      print("Popular course added successfully!");
      return true;
    } catch (e) {
      print("Error adding popular course: $e"); // Debugging
      return false;
    }
  }

  // Method to fetch all popular courses from the database
  Future<List<PopularCourseModel>> fetchPopularCourses() async {
    final response = await _supabase.from("courses").select();
    return response.map((data) => PopularCourseModel.fromMap(data)).toList();
  }
}
