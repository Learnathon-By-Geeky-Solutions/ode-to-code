import 'dart:io';
import 'package:edu_bridge_app/data/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to upload category image to Supabase Storage
  Future<String?> uploadCategoryImage(File imageFile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'category_images/$fileName';

      // Uploading the file to Supabase storage
      await _supabase.storage
          .from('category_images')
          .upload(filePath, imageFile);

      // Returning the public URL of the uploaded image
      return _supabase.storage.from('category_images').getPublicUrl(filePath);
    } catch (e) {
      return null;
    }
  }

  // Method to add a new category to the database
  Future<bool> addCategory(CategoryModel category) async {
    try {
      // Inserting the category into the "categories" table
      await _supabase.from("categories").insert(category.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  // Method to fetch all categories from the database
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await _supabase.from("categories").select();
    return response
        .map((data) => CategoryModel.fromMap(data, data['id']))
        .toList();
  }
}
