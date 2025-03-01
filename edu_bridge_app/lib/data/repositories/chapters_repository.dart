import 'dart:io';

import 'package:edu_bridge_app/data/models/chapter_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChapterRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to upload chapter image to Supabase Storage
  Future<String?> uploadChapterImage(File imageFile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'chapter_images/$fileName';

      // Uploading the file to Supabase storage
      await _supabase.storage
          .from('chapter_images')
          .upload(filePath, imageFile);

      // Returning the public URL of the uploaded image
      return _supabase.storage.from('chapter_images').getPublicUrl(filePath);
    } catch (e) {
      return null;
    }
  }

  // Method to add a new chapter to the database
  Future<bool> addChapter(ChapterModel chapterModel) async {
    try {
      // Inserting the chapter into the "chapters" table
      await _supabase.from("chapters").insert(chapterModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  // Method to fetch all chapters from the database
  Future<List<ChapterModel>> fetchChapters() async {
    final response = await _supabase.from("chapters").select();
    return response.map((data) => ChapterModel.fromMap(data)).toList();
  }

  // Method to fetch a chapter by its ID
  Future<ChapterModel?> fetchChapterById(String id) async {
    final response =
        await _supabase.from("chapters").select().eq('id', id).single();
    if (response != null) {
      return ChapterModel.fromMap(response);
    } else {
      return null;
    }
  }
}
