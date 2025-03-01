import 'dart:io';
import 'package:edu_bridge_app/data/models/content_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContentRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to add a new content to the database
  Future<bool> addContent(ContentModel contentModel) async {
    try {
      // Inserting the content into the "contents" table
      await _supabase.from("contents").insert(contentModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  // Method to fetch all content by chapter ID from the database
  Future<List<ContentModel>> fetchContentsByChapterId(String chapterId) async {
    final response =
        await _supabase.from("contents").select().eq('chapter_id', chapterId);
    return response.map((data) => ContentModel.fromMap(data)).toList();
  }

  // Method to fetch a content by its ID
  Future<ContentModel?> fetchContentById(String id) async {
    final response =
        await _supabase.from("contents").select().eq('id', id).single();
    if (response != null) {
      return ContentModel.fromMap(response);
    } else {
      return null;
    }
  }
}
