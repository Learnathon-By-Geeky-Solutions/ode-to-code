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
      // Inserting the class into the "classes" table
      await _supabase.from("classes").insert(classModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  // Method to fetch all classes from the database
  Future<List<ClassModel>> fetchClasses() async {
    final response = await _supabase.from("classes").select();
    return response.map((data) => ClassModel.fromMap(data)).toList();
  }

  // Method to fetch a class by its ID
  Future<ClassModel?> fetchClassById(String id) async {
    final response =
        await _supabase.from("classes").select().eq('id', id).single();
    if (response != null) {
      return ClassModel.fromMap(response);
    } else {
      return null;
    }
  }
}
