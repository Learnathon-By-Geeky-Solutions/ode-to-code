import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:edu_bridge_app/data/models/chapter_model.dart';

class ChapterRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to add a new chapter to the database
  Future<bool> addChapter(ChapterModel chapterModel) async {
    try {
      final chapterData = chapterModel.toMap();
      print("Chapter Data being sent to Supabase: \$chapterData"); // Debugging

      // Inserting into Supabase
      await _supabase.from("chapters").insert(chapterData);

      print("Chapter added successfully!");
      return true;
    } catch (e) {
      print("Error adding chapter: \$e"); // Debugging
      return false;
    }
  }

  // Method to fetch chapters by subject ID
  Future<List<ChapterModel>> fetchChaptersBySubjectId(String subjectId) async {
    try {
      // Query to fetch chapters based on subjectId
      final response =
          await _supabase.from('chapters').select().eq('subject_id', subjectId);

      // Mapping the response data to a list of ChapterModel objects
      return response
          .map<ChapterModel>((data) => ChapterModel.fromMap(data))
          .toList();
    } catch (e) {
      return []; // Returning an empty list if an error occurs
    }
  }
}
