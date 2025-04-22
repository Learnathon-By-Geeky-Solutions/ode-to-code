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
    return response.isSuccess ? response.responseData : null;
  }

  Future<ApiResponse> addUserProfile(UserProfileModel userProfile) =>
      _submitUserProfile(userProfile);

  Future<ApiResponse> updateUserProfile(UserProfileModel userProfile) =>
      _submitUserProfile(userProfile);

  Future<UserProfileModel?> fetchUserProfileByEmail(String email) async {
    final response = await _networkCaller.getRequest(
      tableName: 'users_profile',
      eqColumn: 'email',
      eqValue: email,
    );

    if (response.isSuccess &&
        response.responseData is List &&
        response.responseData.isNotEmpty) {
      return UserProfileModel.fromMap(response.responseData[0]);
    }
    return null;
  }

  Future<ApiResponse> _submitUserProfile(UserProfileModel userProfile) async {
    final response = await _networkCaller.postRequest(
      tableName: 'users_profile',
      data: userProfile.toMap(),
    );
    return response.isSuccess
        ? response
        : ApiResponse(
      isSuccess: false,
      responseData: null,
      errorMessage: response.errorMessage
    );
  }
}
