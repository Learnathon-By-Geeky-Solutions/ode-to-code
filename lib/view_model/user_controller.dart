import 'dart:io';
import 'package:edu_bridge_app/data/models/user_model.dart';
import 'package:edu_bridge_app/data/repositories/user_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository _repository = UserRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  File? _profileImage;
  File? get profileImage => _profileImage;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserModel? _user;
  UserModel? get user => _user;

  final ImagePicker _picker = ImagePicker();

  void pickProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      update();
    }
  }

  Future<bool> addUser(
    String fullName,
    String email,
    String whatYouDo,
    String accountType,
    String dateOfBirth,
    String gender,
  ) async {
    if (fullName.isEmpty ||
        email.isEmpty ||
        whatYouDo.isEmpty ||
        accountType.isEmpty ||
        dateOfBirth.isEmpty ||
        gender.isEmpty ||
        _profileImage == null) {
      Get.snackbar(
          "Error", "Please fill in all fields and select a profile image.");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final imageUrl = await _repository.uploadUserProfileImage(_profileImage!);
    if (imageUrl != null) {
      final newUser = UserModel(
        fullName: fullName,
        email: email,
        whatYouDo: whatYouDo,
        accountType: accountType,
        image: imageUrl,
        dateOfBirth: dateOfBirth,
        gender: gender,
      );

      final success = await _repository.addUser(newUser);
      if (success) {
        isSuccess = true;
        Get.snackbar("Success", "Subject added successfully!");
      } else {
        _errorMessage = "Failed to add subject.";
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

  void clearFields() {
    _profileImage = null;
    _user = null;
    update();
  }
}
