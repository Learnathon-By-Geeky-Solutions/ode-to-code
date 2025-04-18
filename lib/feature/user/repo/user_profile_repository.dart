import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/api_response.dart';

class UserProfileRepository {
  final NetworkCaller _networkCaller = NetworkCaller();

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
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse> addUserProfile(UserProfileModel userProfile) async {
    try {
      final userData = userProfile.toMap();

      final response = await _networkCaller.postRequest(
        tableName: 'users_profile',
        data: userData,
      );

      return response;
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

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
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse> updateUserProfile(UserProfileModel userProfile) async {
    try {
      final userData = userProfile.toMap();

      final response = await _networkCaller.postRequest(
        tableName: 'users_profile',
        data: userData,
      );

      return response;
    } catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }
}
