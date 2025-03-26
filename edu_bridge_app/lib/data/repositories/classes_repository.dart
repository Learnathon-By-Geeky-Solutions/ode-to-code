import 'dart:io';
import 'package:edu_bridge_app/data/models/class_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClassRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to upload class image to Supabase Storage
  Future<String?> uploadClassImage(File imageFile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'class_images/$fileName';

      // Uploading the file to Supabase storage
      await _supabase.storage.from('class_images').upload(filePath, imageFile);

      // Returning the public URL of the uploaded image
      return _supabase.storage.from('class_images').getPublicUrl(filePath);
    } catch (e) {
      return null;
    }
  }

  // Method to add a new class to the database
  Future<bool> addClass(ClassModel classModel) async {
    try {
      final classData = classModel.toMap();
      print("Class Data being sent to Supabase: $classData"); // Debugging

      // Inserting into Supabase
      await _supabase.from("classes").insert(classData);

      print("Class added successfully!");
      return true;
    } catch (e) {
      print("Error adding class: $e"); // Debugging
      return false;
    }
  }

  // Method to fetch a class by its ID
  Future<List<ClassModel>> fetchClassesByCategoryId(String categoryId) async {
    try {
      // Query to fetch classes based on categoryId
      final response = await _supabase
          .from('classes')
          .select()
          .eq('category_id', categoryId);

      // Mapping the response data to a list of ClassModel objects
      return response
          .map<ClassModel>((data) => ClassModel.fromMap(data))
          .toList();
    } catch (e) {
      return []; // Returning an empty list if an error occurs
    }
  }
}
