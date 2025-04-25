import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/feature/user_saved_item/repo/i_user_saved_item_repository.dart';

class UserSavedItemController extends GetxController {
  final IUserSavedItemRepository _repository;

  UserSavedItemController({required IUserSavedItemRepository repository})
      : _repository = repository;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<UserSavedItemModel> _savedItems = [];
  List<UserSavedItemModel> get savedItems => _savedItems;

  bool _isDataFetched = false; // Flag to check if data has been fetched

  // Add saved item to the repository
  Future<bool> addSavedItem(
    String userId,
    String type,
    String title, {
    String? link,
    String? note,
  }) async {
    if (userId.isEmpty || title.isEmpty || type.isEmpty) {
      SnackBarUtil.showError("Error", "All fields except note are required.");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final newItem = UserSavedItemModel(
      userId: userId,
      type: type,
      title: title,
      link: link ?? '', // Ensure link is not null here
      note: note,
      createdAt: DateTime.now().toIso8601String(),
    );

    final success = await _repository.addSavedItem(newItem);
    if (success) {
      isSuccess = true;
      SnackBarUtil.showSuccess("Success", "Item saved successfully!");
    } else {
      _errorMessage = "Failed to save item.";
      SnackBarUtil.showError("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<void> fetchSavedItems(String userId) async {
    // Skip fetching if data has already been loaded
    if (_isDataFetched) {
      return;
    }

    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _savedItems = await _repository.fetchSavedItemsByUserId(userId);
      _isDataFetched = true; // Mark data as fetched
    } catch (e) {
      _errorMessage = 'Failed to load saved items: $e';
      SnackBarUtil.showError("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
  }

  // Delete a saved item from the repository
  Future<bool> deleteSavedItem(String itemId) async {
    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final success = await _repository.deleteSavedItem(itemId);
    if (success) {
      isSuccess = true;
      _savedItems.removeWhere((item) => item.id == itemId);
      SnackBarUtil.showSuccess("Success", "Item deleted successfully!");
    } else {
      _errorMessage = "Failed to delete item.";
      SnackBarUtil.showError("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  void resetData() {
    _savedItems = [];
    _isDataFetched = false;
    update();
  }
}
