import 'package:edu_bridge_app/core/resources/export.dart';

class ClassController extends GetxController {
  final IClassRepository _repository;
  ClassController({required IClassRepository repository})
      : _repository = repository;

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
      SnackbarUtil.showError(
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

      final success = await _repository.addClass(newClass);
      if (success) {
        isSuccess = true;
        SnackbarUtil.showSuccess("Success", "Class added successfully!");
      } else {
        _errorMessage = "Failed to add class.";
        SnackbarUtil.showError("Error", _errorMessage!);
      }
    } else {
      _errorMessage = "Image upload failed.";
      SnackbarUtil.showError("Error", _errorMessage!);
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
      SnackbarUtil.showError("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
  }

  void clearFields() {
    _classImage = null;
    update();
  }
}
