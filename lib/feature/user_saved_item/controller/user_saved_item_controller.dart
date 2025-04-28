import 'package:edu_bridge_app/core/export.dart';

class UserSavedItemController extends GetxController {
  final IUserSavedItemRepository _repository;

  UserSavedItemController({required IUserSavedItemRepository repository})
      : _repository = repository;

  static UserSavedItemController get to => Get.find<UserSavedItemController>();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<UserSavedItemModel> _savedItems = [];
  List<UserSavedItemModel> get savedItems => _savedItems;

  // Add new saved item
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
      link: link ?? '',
      note: note,
      createdAt: DateTime.now().toIso8601String(),
    );

    try {
      final success = await _repository.addSavedItem(newItem);
      if (success) {
        isSuccess = true;
        SnackBarUtil.showSuccess("Success", "Item saved successfully!");

        await fetchSavedItems(userId);
      } else {
        _errorMessage = "Failed to save item.";
        SnackBarUtil.showError("Error", _errorMessage!);
      }
    } catch (e) {
      _errorMessage = "Error while saving item: $e";
      SnackBarUtil.showError("Error", _errorMessage!);
    } finally {
      _inProgress = false;
      update();
    }

    return isSuccess;
  }

  // Fetch saved items
  Future<void> fetchSavedItems(String userId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _savedItems = await _repository.fetchSavedItemsByUserId(userId);
    } catch (e) {
      _errorMessage = 'Failed to load saved items: $e';
      SnackBarUtil.showError("Error", _errorMessage!);
    } finally {
      _inProgress = false;
      update();
    }
  }

  // Delete saved item
  Future<bool> deleteSavedItem(String itemId) async {
    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      final success = await _repository.deleteSavedItem(itemId);
      if (success) {
        isSuccess = true;
        _savedItems.removeWhere((item) => item.id == itemId);
      } else {
        _errorMessage = "Failed to delete item.";
        SnackBarUtil.showError("Error", _errorMessage!);
      }
    } catch (e) {
      _errorMessage = "Error while deleting item: $e";
      SnackBarUtil.showError("Error", _errorMessage!);
    } finally {
      _inProgress = false;
      update();
    }

    return isSuccess;
  }

  // Reset saved items
  void resetData() {
    _savedItems = [];
    update();
  }
}
