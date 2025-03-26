import 'dart:io';
import 'package:edu_bridge_app/data/models/content_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContentRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> addContent(ContentModel contentModel) async {
    try {
      final response =
          await _supabase.from("content").insert(contentModel.toMap());

      print("Supabase Response: $response");

      return true;
    } catch (e) {
      print("Supabase Error: $e");
      return false;
    }
  }

  Future<List<ContentModel>> fetchContentsByChapterId(String chapterId) async {
    try {
      // Query to fetch contents based on chapterId
      final response =
          await _supabase.from('content').select().eq('chapters_id', chapterId);

      // Mapping the response data to a list of ContentModel objects
      return response
          .map<ContentModel>((data) => ContentModel.fromMap(data))
          .toList();
    } catch (e) {
      return []; // Returning an empty list if an error occurs
    }
  }
}
