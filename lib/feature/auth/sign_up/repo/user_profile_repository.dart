import 'package:edu_bridge_app/core/export.dart';

class UserProfileRepository extends IUserProfileRepository {
  final INetworkCaller _networkCaller;

  UserProfileRepository({required INetworkCaller networkCaller})
      : _networkCaller = networkCaller;

  @override
  Future<String?> uploadUserProfileImage(File imageFile) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = 'user/$fileName';

    final response = await _networkCaller.uploadFile(
      bucketName: 'user',
      filePath: filePath,
      file: imageFile,
    );

    return response.isSuccess ? response.responseData as String? : null;
  }

  @override
  Future<bool> createUserProfile(UserProfileModel profile) async {
    final response = await _networkCaller.postRequest(
      tableName: 'users_profile',
      data: profile.toMap(),
    );
    return _handlePostResponse(response);
  }

  @override
  Future<UserProfileModel?> getUserProfileByEmail(String email) async {
    final response = await _networkCaller.getRequest(
      tableName: 'users_profile',
      eqColumn: 'email',
      eqValue: email,
    );

    return _handleGetResponse(response, email);
  }

  bool _handlePostResponse(ApiResponse response) {
    return response.isSuccess;
  }

  UserProfileModel? _handleGetResponse(ApiResponse response, String email) {
    if (response.isSuccess && response.responseData is List) {
      final filteredData = (response.responseData as List).where((data) {
        return data['email'] == email;
      }).toList();

      if (filteredData.isNotEmpty) {
        return UserProfileModel.fromMap(filteredData.first);
      }
    }
    return null;
  }
}
