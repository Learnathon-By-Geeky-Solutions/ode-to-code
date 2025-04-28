import 'package:edu_bridge_app/core/export.dart';
import 'package:edu_bridge_app/feature/user/repo/i_user_profile_repository.dart';

class UserProfileController extends GetxController {
  final IUserProfileRepository _repository;

  UserProfileController({required IUserProfileRepository repository})
      : _repository = repository;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserProfileModel? _userProfile;
  UserProfileModel? get userProfile => _userProfile;

  File? _profileImage;
  File? get profileImage => _profileImage;

  bool get isAdmin => _userProfile?.accountType.toLowerCase() == 'admin';

  void _setInProgress(bool value) {
    _inProgress = value;
    update();
  }

  void _handleError(String message) {
    _errorMessage = message;
    SnackBarUtil.showError("Error", message);
    update();
  }

  void setProfileImage(File image) {
    _profileImage = image;
    update();
  }

  Future<bool> addUserProfile({
    required String fullName,
    required String email,
    required String whatYouDo,
    required String accountType,
    required String dateOfBirth,
    required String gender,
  }) async {
    if ([fullName, email, whatYouDo, accountType, dateOfBirth, gender]
            .any((element) => element.trim().isEmpty) ||
        _profileImage == null) {
      _handleError("Please fill in all fields and select a profile image.");
      return false;
    }

    _setInProgress(true);

    try {
      final imageUrl = await _repository.uploadUserProfileImage(_profileImage!);

      if (imageUrl == null) {
        _handleError("Failed to upload profile image.");
        return false;
      }

      final profile = UserProfileModel(
        name: fullName,
        email: email,
        whatYouDo: whatYouDo,
        accountType: accountType,
        image: imageUrl,
        dateOfBirth: dateOfBirth,
        gender: gender,
      );

      final isSuccess = await _repository.createUserProfile(profile);
      if (isSuccess) {
        SnackBarUtil.showSuccess("Success", "User profile added successfully!");
        return true;
      } else {
        _handleError("Failed to add user profile.");
        return false;
      }
    } catch (e) {
      _handleError("An error occurred: $e");
      return false;
    } finally {
      _setInProgress(false);
    }
  }

  Future<void> fetchUserProfile(String email) async {
    _setInProgress(true);
    _errorMessage = null;
    try {
      _userProfile = await _repository.getUserProfileByEmail(email);
      if (_userProfile == null) {
        _handleError("No user profile found for this email.");
      }
    } catch (e) {
      _handleError("Failed to load user profile: $e");
    } finally {
      _setInProgress(false);
    }
  }
}
