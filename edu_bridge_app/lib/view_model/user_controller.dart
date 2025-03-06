import 'dart:io';
import 'package:edu_bridge_app/data/models/user_model.dart';
import 'package:edu_bridge_app/data/repositories/user_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository _repository = UserRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  File? _userImage;
  File? get userImage => _userImage;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void pickUserImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _userImage = File(pickedFile.path);
      update();
    }
  }

  Future<bool> addUser(String fullName, String email, String whatYouDo,
      String gender, String accountType) async {
    if (fullName.isEmpty ||
        email.isEmpty ||
        whatYouDo.isEmpty ||
        gender.isEmpty ||
        _userImage == null) {
      Get.snackbar("Error", "Please fill all the details and select an image");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final imageUrl = await _repository.uploadUserImage(_userImage!);
    if (imageUrl != null) {
      final newUser = UserModel(
        fullName: fullName,
        email: email,
        whatYouDo: whatYouDo,
        createdAt: DateTime.now().toString(),
        accountType: accountType, // Default value, adjust as needed
        image: imageUrl,
        dateOfBirth: null, // Can be added later
        gender: gender,
      );

      final success = await _repository.addUser(newUser);
      if (success) {
        isSuccess = true;
        fetchUsers();
        Get.snackbar("Success", "User added successfully!");
      } else {
        _errorMessage = "Failed to add user.";
        Get.snackbar("Error", _errorMessage!);
      }
    } else {
      _errorMessage = "Image upload failed.";
      Get.snackbar("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<void> fetchUsers() async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _users = await _repository.fetchUsers();
    } catch (e) {
      _errorMessage = 'Failed to load users: $e';
    }

    _inProgress = false;
    update();
  }

  Future<bool> updateUser(UserModel user) async {
    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    if (_userImage != null) {
      final imageUrl = await _repository.uploadUserImage(_userImage!);
      if (imageUrl != null) {
        user = user.copyWith(image: imageUrl); // Updating the image URL
      }
    }

    final success = await _repository.updateUser(user);
    if (success) {
      isSuccess = true;
      fetchUsers();
      Get.snackbar("Success", "User updated successfully!");
    } else {
      _errorMessage = "Failed to update user.";
      Get.snackbar("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  void clearFields() {
    _userImage = null;
    update();
  }
}
