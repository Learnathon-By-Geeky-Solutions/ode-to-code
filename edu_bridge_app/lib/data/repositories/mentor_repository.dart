import 'dart:io';
import 'package:edu_bridge_app/data/models/mentor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MentorRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to upload mentor image to Supabase Storage
  Future<String?> uploadMentorImage(File imageFile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'mentor_images/$fileName';

      // Uploading the file to Supabase storage
      await _supabase.storage.from('mentor_images').upload(filePath, imageFile);

      // Returning the public URL of the uploaded image
      return _supabase.storage.from('mentor_images').getPublicUrl(filePath);
    } catch (e) {
      return null;
    }
  }

  // Method to add a new mentor to the database
  Future<bool> addMentor(MentorModel mentor) async {
    try {
      // Inserting the mentor into the "mentors" table
      await _supabase.from("mentors").insert(mentor.toMap());
      print("Mentor added successfully!");
      return true;
    } catch (e) {
      print("Error adding mentor: $e"); // Debugging
      return false;
    }
  }

  // Method to fetch all mentors from the database
  Future<List<MentorModel>> fetchMentors() async {
    final response = await _supabase.from("mentors").select();
    return response.map((data) => MentorModel.fromMap(data)).toList();
  }
}
