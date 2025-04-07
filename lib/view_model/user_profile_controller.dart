import 'dart:io';
import 'package:edu_bridge_app/data/models/user_profile.dart';
import 'package:edu_bridge_app/data/repositories/user_profile_repository.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  final UserProfileRepository _repository = UserProfileRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserProfileModel? _userProfile;
  UserProfileModel? get userProfile => _userProfile;

  File? _profileImage;
  File? get profileImage => _profileImage;

  // Method to set the profile image
  void setProfileImage(File image) {
    _profileImage = image;
    update(); // Update UI state
  }

  // Method to add a new user profile
  Future<bool> addUserProfile({
    required String fullName,
    required String email,
    required String whatYouDo,
    required String accountType,
    required String dateOfBirth,
    required String gender,
  }) async {
    if (fullName.isEmpty ||
        email.isEmpty ||
        whatYouDo.isEmpty ||
        accountType.isEmpty ||
        dateOfBirth.isEmpty ||
        gender.isEmpty ||
        _profileImage == null) {
      Get.snackbar(
          "Error", "Please fill in all fields and select a profile image.");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update(); // Update UI state

    try {
      // Step 1: Upload the profile image
      final imageUrl = await _repository.uploadUserProfileImage(_profileImage!);
      if (imageUrl == null) {
        _errorMessage = "Failed to upload profile image.";
        Get.snackbar("Error", _errorMessage!);
        return false;
      }

      // Step 2: Create the user profile with the image URL
      final newUserProfile = UserProfileModel(
        name: fullName,
        email: email,
        whatYouDo: whatYouDo,
        accountType: accountType,
        image: imageUrl,
        dateOfBirth: dateOfBirth,
        gender: gender,
      );

      // Step 3: Add the user profile to the database
      final success = await _repository.addUserProfile(newUserProfile);
      if (success) {
        isSuccess = true;
        Get.snackbar("Success", "User profile added successfully!");
      } else {
        _errorMessage = "Failed to add user profile.";
        Get.snackbar("Error", _errorMessage!);
      }
    } catch (e) {
      _errorMessage = "An error occurred: $e";
      Get.snackbar("Error", _errorMessage!);
    } finally {
      _inProgress = false;
      update(); // Update UI state
    }

    return isSuccess;
  }

  // Method to fetch a user profile by email
  Future<void> fetchUserProfile(String email) async {
    _inProgress = true;
    _errorMessage = null;
    update(); // Update UI state

    try {
      _userProfile = await _repository.fetchUserProfileByEmail(email);
      if (_userProfile != null) {
        Get.snackbar("Success", "User profile fetched successfully!");
      } else {
        _errorMessage = "No user profile found for this email.";
        Get.snackbar("Error", _errorMessage!);
      }
    } catch (e) {
      _errorMessage = 'Failed to load user profile: $e';
      Get.snackbar("Error", _errorMessage!);
    }

    _inProgress = false;
    update(); // Update UI state
  }
}
