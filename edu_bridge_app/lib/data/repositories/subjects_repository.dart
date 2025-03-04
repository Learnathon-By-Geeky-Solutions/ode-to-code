import 'dart:io';
import 'package:edu_bridge_app/data/models/subject_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubjectRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to upload subject image to Supabase Storage
  Future<String?> uploadSubjectImage(File imageFile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'subject_images/$fileName';

      // Uploading the file to Supabase storage
      await _supabase.storage
          .from('subject_images')
          .upload(filePath, imageFile);

      // Returning the public URL of the uploaded image
      return _supabase.storage.from('subject_images').getPublicUrl(filePath);
    } catch (e) {
      return null;
    }
  }

  // Method to add a new subject to the database
  Future<bool> addSubject(SubjectModel subjectModel) async {
    try {
      final subjectData = subjectModel.toMap();
      print("Subject Data being sent to Supabase: $subjectData"); // Debugging

      // Inserting into Supabase
      await _supabase.from("subjects").insert(subjectData);

      print("Subject added successfully!");
      return true;
    } catch (e) {
      print("Error adding subject: $e"); // Debugging
      return false;
    }
  }

  // Method to fetch subjects by class ID
  Future<List<SubjectModel>> fetchSubjectsByClassId(String classId) async {
    try {
      final response =
          await _supabase.from('subjects').select().eq('class_id', classId);

      return response
          .map<SubjectModel>((data) => SubjectModel.fromMap(data))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
