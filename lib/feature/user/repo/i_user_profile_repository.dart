import 'package:edu_bridge_app/core/resources/export.dart';

abstract class IUserProfileRepository {
  Future<bool> createUserProfile(UserProfileModel profile);
  Future<UserProfileModel?> getUserProfileByEmail(String email);
  Future<String?> uploadUserProfileImage(File imageFile);
}
