import 'package:edu_bridge_app/core/resources/export.dart';

class UserProfileRepository {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<String?> uploadUserProfileImage(File imageFile) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = 'user/$fileName';

    final response = await _networkCaller.uploadFile(
      bucketName: 'user',
      filePath: filePath,
      file: imageFile,
    );

    return _handleFileUploadResponse(response);
  }

  Future<ApiResponse> addUserProfile(UserProfileModel userProfile) async {
    final userData = userProfile.toMap();
    final response = await _networkCaller.postRequest(
      tableName: 'users_profile',
      data: userData,
    );

    return _handlePostResponse(response);
  }

  Future<UserProfileModel?> fetchUserProfileByEmail(String email) async {
    final response = await _networkCaller.getRequest(
      tableName: 'users_profile',
      eqColumn: 'email',
      eqValue: email,
    );

    return _handleGetResponse(response);
  }

  Future<ApiResponse> updateUserProfile(UserProfileModel userProfile) async {
    final userData = userProfile.toMap();
    final response = await _networkCaller.postRequest(
      tableName: 'users_profile',
      data: userData,
    );

    return _handlePostResponse(response);
  }

  String? _handleFileUploadResponse(ApiResponse response) {
    if (response.isSuccess) {
      return response.responseData;
    }
    return null;
  }

  ApiResponse _handlePostResponse(ApiResponse response) {
    if (response.isSuccess) {
      return response;
    } else {
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        errorMessage: response.errorMessage,
      );
    }
  }

  UserProfileModel? _handleGetResponse(ApiResponse response) {
    if (response.isSuccess && response.responseData != null) {
      return UserProfileModel.fromMap(response.responseData[0]);
    }
    return null;
  }
}
