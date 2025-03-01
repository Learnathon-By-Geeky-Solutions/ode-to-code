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
      // Inserting the subject into the "subjects" table
      await _supabase.from("subjects").insert(subjectModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  // Method to fetch all subjects from the database
  Future<List<SubjectModel>> fetchSubjects() async {
    final response = await _supabase.from("subjects").select();
    return response.map((data) => SubjectModel.fromMap(data)).toList();
  }

  // Method to fetch a subject by its ID
  Future<SubjectModel?> fetchSubjectById(String id) async {
    final response =
        await _supabase.from("subjects").select().eq('id', id).single();
    if (response != null) {
      return SubjectModel.fromMap(response);
    } else {
      return null;
    }
  }
}
