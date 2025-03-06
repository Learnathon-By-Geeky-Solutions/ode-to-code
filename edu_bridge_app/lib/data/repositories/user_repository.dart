import 'dart:io';
import 'package:edu_bridge_app/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Method to upload user image to Supabase Storage
  Future<String?> uploadUserImage(File imageFile) async {
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
  Future<bool> addUser(UserModel user) async {
    try {
      // Inserting the user into the "users" table
      await _supabase.from("user").insert(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  // Method to fetch all users from the database
  Future<List<UserModel>> fetchUsers() async {
    final response = await _supabase.from("user").select();
    return response.map((data) => UserModel.fromMap(data)).toList();
  }

  // Method to fetch a user by ID
  Future<UserModel?> fetchUserById(String id) async {
    final response =
        await _supabase.from("user").select().eq('id', id).single();
    if (response != null) {
      return UserModel.fromMap(response);
    } else {
      return null;
    }
  }

  // Method to update user details in the database
  Future<bool> updateUser(UserModel user) async {
    try {
      // Updating the user in the "users" table
      await _supabase.from("user").upsert(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
