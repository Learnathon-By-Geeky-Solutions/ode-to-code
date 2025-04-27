import 'package:edu_bridge_app/core/resources/export.dart';

class UserSavedItemRepository extends IUserSavedItemRepository {
  final INetworkCaller _networkCaller;

  UserSavedItemRepository({required INetworkCaller networkCaller})
      : _networkCaller = networkCaller;

  @override
  Future<bool> addSavedItem(UserSavedItemModel model) async {
    final response = await _networkCaller.postRequest(
      tableName: "user_saved_item",
      data: model.toMap(),
    );

    return _handlePostResponse(response);
  }

  @override
  Future<List<UserSavedItemModel>> fetchSavedItemsByUserId(
      String userId) async {
    final response = await _networkCaller.getRequest(
      tableName: 'user_saved_item',
      eqColumn: 'user_id',
      eqValue: userId,
    );

    return _handleGetResponse(response, userId);
  }

  @override
  @override
  Future<bool> deleteSavedItem(String itemId) async {
    final response = await _networkCaller.deleteRequest(
      tableName: 'user_saved_item',
      queryParams: {'id': itemId},
    );

    return _handleDeleteResponse(response);
  }

  List<UserSavedItemModel> _handleGetResponse(
      ApiResponse response, String userId) {
    if (response.isSuccess) {
      if (response.responseData != null && response.responseData.isNotEmpty) {
        final filteredData = (response.responseData as List).where((data) {
          return data['user_id'] == userId;
        }).toList();

        return filteredData
            .map<UserSavedItemModel>((data) => UserSavedItemModel.fromMap(data))
            .toList();
      }
    }
    return [];
  }

  bool _handlePostResponse(ApiResponse response) {
    return response.isSuccess;
  }

  bool _handleDeleteResponse(ApiResponse response) {
    return response.isSuccess;
  }
}
