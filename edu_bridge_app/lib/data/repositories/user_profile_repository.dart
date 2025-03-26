import 'package:edu_bridge_app/data/models/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

class UserProfileRepository {
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
      print("Error uploading user profile image: $e");
      return null;
    }
  }

  // Method to add a new user profile to the database
  Future<bool> addUserProfile(UserProfileModel userProfile) async {
    try {
      final userData = userProfile.toMap();
      print("User Data being sent to Supabase: $userData"); // Debugging

      // Inserting into Supabase
      await _supabase.from('users_profile').insert(userData);

      print("User profile added successfully!");
      return true;
    } catch (e) {
      print("Error adding user profile: $e"); // Debugging
      return false;
    }
  }

  // Method to fetch a user profile by email
  Future<UserProfileModel?> fetchUserProfileByEmail(String email) async {
    try {
      // Query to fetch user profile based on email
      final response = await _supabase
          .from('users_profile')
          .select()
          .eq('email', email)
          .single();

      return UserProfileModel.fromMap(response);
    } catch (e) {
      print("Error fetching user profile: $e");
      return null;
    }
  }

  // Method to update user profile
  Future<bool> updateUserProfile(UserProfileModel userProfile) async {
    try {
      final userData = userProfile.toMap();
      print("User Data being updated: $userData"); // Debugging

      // Updating user profile in Supabase
      await _supabase.from('users_profile').update(userData).eq('id',
          userProfile); // Ensure the correct column is used for the condition

      print("User profile updated successfully!");
      return true;
    } catch (e) {
      print("Error updating user profile: $e");
      return false;
    }
  }
}
