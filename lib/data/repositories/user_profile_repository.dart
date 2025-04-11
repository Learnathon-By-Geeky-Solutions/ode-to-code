import 'package:edu_bridge_app/data/models/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'package:edu_bridge_app/data/network_caller/network_caller.dart'; // Ensure to import your NetworkCaller

class UserProfileRepository {
  final NetworkCaller _networkCaller = NetworkCaller();

  // Method to upload user profile image to Supabase Storage
  Future<String?> uploadUserProfileImage(File imageFile) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = 'user/$fileName';

      final response = await _networkCaller.uploadFile(
        bucketName: 'user',
        filePath: filePath,
        file: imageFile,
      );

      if (response.isSuccess) {
        return response.responseData;
      } else {
        print("Error uploading user profile image: ${response.errorMessage}");
        return null;
      }
    } catch (e) {
      print("Error uploading user profile image: $e");
      return null;
    }
  }

  // Method to add a new user profile to the database
  Future<ApiResponse> addUserProfile(UserProfileModel userProfile) async {
    try {
      final userData = userProfile.toMap();
      print("User Data being sent to Supabase: $userData");

      final response = await _networkCaller.postRequest(
        tableName: 'users_profile',
        data: userData,
      );

      return response;
    } catch (e) {
      print("Error adding user profile: $e");
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  // Method to fetch a user profile by email
  Future<UserProfileModel?> fetchUserProfileByEmail(String email) async {
    try {
      final response = await _networkCaller.getRequest(
        tableName: 'users_profile',
        eqColumn: 'email',
        eqValue: email,
      );

      if (response.isSuccess) {
        return UserProfileModel.fromMap(response.responseData[0]);
      } else {
        print("Error fetching user profile: ${response.errorMessage}");
        return null;
      }
    } catch (e) {
      print("Error fetching user profile: $e");
      return null;
    }
  }

  // Method to update user profile
  Future<ApiResponse> updateUserProfile(UserProfileModel userProfile) async {
    try {
      final userData = userProfile.toMap();
      print("User Data being updated: $userData");

      final response = await _networkCaller.postRequest(
        tableName: 'users_profile',
        data: userData,
      );

      return response;
    } catch (e) {
      print("Error updating user profile: $e");
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }
}
