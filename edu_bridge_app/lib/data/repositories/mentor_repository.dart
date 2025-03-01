import 'package:edu_bridge_app/data/models/mentor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MentorRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to add a new mentor to the database
  Future<bool> addMentor(MentorModel mentorModel) async {
    try {
      // Insert the mentor into the "mentors" table
      await _supabase.from("mentors").insert(mentorModel.toMap());
      return true;
    } catch (e) {
      print("Error adding mentor: $e");
      return false;
    }
  }

  // Method to fetch all mentors from the database
  Future<List<MentorModel>> fetchMentors() async {
    final response = await _supabase.from("mentors").select();
    if (response is List) {
      return response.map((data) => MentorModel.fromMap(data)).toList();
    }
    return [];
  }

  // Method to fetch a mentor by their ID
  Future<MentorModel?> fetchMentorById(String id) async {
    final response =
        await _supabase.from("mentors").select().eq('id', id).single();
    if (response != null) {
      return MentorModel.fromMap(response);
    }
    return null;
  }

  // Method to update a mentor's information
  Future<bool> updateMentor(MentorModel mentorModel) async {
    try {
      await _supabase
          .from("mentors")
          .update(mentorModel.toMap())
          .eq('id', mentorModel.id!);
      return true;
    } catch (e) {
      print("Error updating mentor: $e");
      return false;
    }
  }

  // Method to delete a mentor by their ID
  Future<bool> deleteMentor(String id) async {
    try {
      await _supabase.from("mentors").delete().eq('id', id);
      return true;
    } catch (e) {
      print("Error deleting mentor: $e");
      return false;
    }
  }
}
