import 'dart:io';
import 'package:edu_bridge_app/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to upload user profile image to Supabase Storage
  Future<String?> uploadUserProfileImage(File imageFile) async {
    try {
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'user/$fileName';

      // Uploading the file to Supabase storage
      await _supabase.storage.from('user').upload(filePath, imageFile);

      // Returning the public URL of the uploaded image
      return _supabase.storage.from('user').getPublicUrl(filePath);
    } catch (e) {
      return null;
    }
  }

  // Method to add a new user to the database
  Future<bool> addUser(UserModel userModel) async {
    try {
      final userData = userModel.toMap();
      print("User Data being sent to Supabase: $userData"); // Debugging

      // Inserting into Supabase
      await _supabase.from("user").insert(userData);

      print("User added successfully!");
      return true;
    } catch (e) {
      print("Error adding user: $e"); // Debugging
      return false;
    }
  }

  // Method to fetch users by account type
  Future<List<UserModel>> fetchUser(String email) async {
    try {
      final response =
          await _supabase.from('users').select().eq('email', email);

      return response
          .map<UserModel>((data) => UserModel.fromMap(data))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
