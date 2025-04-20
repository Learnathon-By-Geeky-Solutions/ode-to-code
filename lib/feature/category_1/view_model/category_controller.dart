import 'package:edu_bridge_app/core/resources/export.dart';

class CategoryController extends GetxController {
  final ICategoryRepository _repository;
  CategoryController({required ICategoryRepository repository})
      : _repository = repository;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  File? _categoryImage;
  File? get categoryImage => _categoryImage;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void pickCategoryImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _categoryImage = File(pickedFile.path);
      update();
    }
  }

  Future<bool> addCategory(String categoryName) async {
    if (categoryName.isEmpty || _categoryImage == null) {
      SnackbarUtil.showError(
          "Error", "Please enter category name and select an image");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final imageUrl = await _repository.uploadCategoryImage(_categoryImage!);
    if (imageUrl != null) {
      final newCategory = CategoryModel(
        categoryName: categoryName,
        imageUrl: imageUrl,
      );

      final success = await _repository.addCategory(newCategory);
      if (success) {
        isSuccess = true;
        fetchCategories();
        SnackbarUtil.showSuccess("Success", "Category added successfully!");
      } else {
        _errorMessage = "Failed to add category.";
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

  Future<void> fetchCategories() async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _categories = await _repository.fetchCategories();
    } catch (e) {
      _errorMessage = 'Failed to load categories: $e';
      SnackbarUtil.showError("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
  }

  void clearFields() {
    _categoryImage = null;
    update();
  }
}
