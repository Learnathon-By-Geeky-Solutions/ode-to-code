import 'dart:io';
import 'package:edu_bridge_app/data/models/class_model.dart';
import 'package:edu_bridge_app/data/repositories/classes_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ClassController extends GetxController {
  final ClassRepository _repository = ClassRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  File? _classImage;
  File? get classImage => _classImage;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ClassModel> _classes = [];
  List<ClassModel> get classes => _classes;

  final ImagePicker _picker = ImagePicker();

  void pickClassImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _classImage = File(pickedFile.path);
      update();
    }
  }

  Future<bool> addClass(String categoryId, String className) async {
    if (className.isEmpty || categoryId.isEmpty || _classImage == null) {
      Get.snackbar(
          "Error", "Please enter class name, select category, and an image");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final imageUrl = await _repository.uploadClassImage(_classImage!);
    if (imageUrl != null) {
      final newClass = ClassModel(
        categoryId: categoryId,
        className: className,
        image: imageUrl,
      );

      print('Test : ${newClass}');

      final success = await _repository.addClass(newClass);
      if (success) {
        isSuccess = true;

        Get.snackbar("Success", "Class added successfully!");
      } else {
        _errorMessage = "Failed to add class.";
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

  Future<void> fetchClasses(String categoryId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _classes = await _repository.fetchClassesByCategoryId(categoryId);
    } catch (e) {
      _errorMessage = 'Failed to load classes: $e';
    }

    _inProgress = false;
    update();
  }

  void clearFields() {
    _classImage = null;
    update();
  }
}
