import 'package:edu_bridge_app/feature/user_saved_item/model/user_saved_item_model.dart';

abstract class IUserSavedItemRepository {
  Future<bool> addSavedItem(UserSavedItemModel model);
  Future<List<UserSavedItemModel>> fetchSavedItemsByUserId(String userId);
  Future<bool> deleteSavedItem(String itemId);
}
