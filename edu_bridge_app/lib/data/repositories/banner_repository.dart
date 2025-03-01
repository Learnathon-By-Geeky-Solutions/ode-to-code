import 'package:edu_bridge_app/data/models/banner_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BannerRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to add a new banner to the database
  Future<bool> addBanner(BannerModel bannerModel) async {
    try {
      // Insert the banner into the "banners" table
      await _supabase.from("banners").insert(bannerModel.toMap());
      return true;
    } catch (e) {
      print("Error adding banner: $e");
      return false;
    }
  }

  // Method to fetch all banners from the database
  Future<List<BannerModel>> fetchBanners() async {
    final response = await _supabase.from("banners").select();
    if (response is List) {
      return response.map((data) => BannerModel.fromMap(data)).toList();
    }
    return [];
  }

  // Method to fetch a banner by its ID
  Future<BannerModel?> fetchBannerById(String id) async {
    final response =
        await _supabase.from("banners").select().eq('id', id).single();
    if (response != null) {
      return BannerModel.fromMap(response);
    }
    return null;
  }

  // Method to update a banner's information
  Future<bool> updateBanner(BannerModel bannerModel) async {
    try {
      await _supabase
          .from("banners")
          .update(bannerModel.toMap())
          .eq('id', bannerModel.id!);
      return true;
    } catch (e) {
      print("Error updating banner: $e");
      return false;
    }
  }

  // Method to delete a banner by its ID
  Future<bool> deleteBanner(String id) async {
    try {
      await _supabase.from("banners").delete().eq('id', id);
      return true;
    } catch (e) {
      print("Error deleting banner: $e");
      return false;
    }
  }
}
