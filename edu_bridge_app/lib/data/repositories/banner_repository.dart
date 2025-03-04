import 'dart:io';
import 'package:edu_bridge_app/data/models/banner_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BannerRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to upload banner image to Supabase Storage
  Future<String?> uploadBannerImage(File imageFile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'banners/$fileName';

      // Uploading the file to Supabase storage
      await _supabase.storage.from('banners').upload(filePath, imageFile);

      // Returning the public URL of the uploaded image
      return _supabase.storage.from('banners').getPublicUrl(filePath);
    } catch (e) {
      return null;
    }
  }

  // Method to add a new banner to the database
  Future<bool> addBanner(BannerModel banner) async {
    try {
      // Inserting the banner into the "banners" table
      await _supabase.from("banners").insert(banner.toMap());
      print("Banner added successfully!");
      return true;
    } catch (e) {
      print("Error adding class: $e"); // Debugging
      return false;
    }
  }

  // Method to fetch all banners from the database
  Future<List<BannerModel>> fetchBanners() async {
    final response = await _supabase.from("banners").select();
    return response.map((data) => BannerModel.fromMap(data)).toList();
  }
}
