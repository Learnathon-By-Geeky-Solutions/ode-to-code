import 'package:edu_bridge_app/core/resources/export.dart';

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

  // Helper to manage the loading state
  void _setInProgress(bool value) {
    _inProgress = value;
    update();
  }

  // Helper to handle errors and show them through Snackbar
  void _handleError(String message) {
    _errorMessage = message;
    Get.snackbar("Error", message);
    update(); // Ensure UI updates on error message change
  }

  // Set profile image and update UI
  void setProfileImage(File image) {
    _profileImage = image;
    update();
  }

  // Add user profile with proper validations
  Future<bool> addUserProfile({
    required String fullName,
    required String email,
    required String whatYouDo,
    required String accountType,
    required String dateOfBirth,
    required String gender,
  }) async {
    if ([fullName, email, whatYouDo, accountType, dateOfBirth, gender]
            .any((element) => element.isEmpty) ||
        _profileImage == null) {
      _handleError("Please fill in all fields and select a profile image.");
      return false;
    }

    _setInProgress(true);
    bool isSuccess = false;

    try {
      // Upload image first and check result
      final imageUrl = await _repository.uploadUserProfileImage(_profileImage!);
      if (imageUrl == null) {
        _handleError("Failed to upload profile image.");
        return false;
      }

      // Proceed to create profile if image upload is successful
      final profile = UserProfileModel(
        name: fullName,
        email: email,
        whatYouDo: whatYouDo,
        accountType: accountType,
        image: imageUrl,
        dateOfBirth: dateOfBirth,
        gender: gender,
      );

      final response = await _repository
          .addUserProfile(profile); // This returns an ApiResponse
      if (response.isSuccess) {
        Get.snackbar("Success", "User profile added successfully!");
        isSuccess = true;
      } else {
        _handleError("Failed to add user profile: ${response.errorMessage}");
      }
    } catch (e) {
      _handleError("An error occurred: $e");
    }

    _setInProgress(false);
    return isSuccess;
  }

  // Fetch user profile based on email
  Future<void> fetchUserProfile(String email) async {
    _setInProgress(true);
    _errorMessage = null; // Reset error message

    try {
      _userProfile = await _repository.fetchUserProfileByEmail(email);
      if (_userProfile == null) {
        _handleError("No user profile found for this email.");
      }
    } catch (e) {
      _handleError("Failed to load user profile: $e");
    }

    _setInProgress(false);
  }
}
