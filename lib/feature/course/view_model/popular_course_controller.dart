import 'package:edu_bridge_app/core/resources/export.dart';

class PopularCourseController extends GetxController {
  final IPopularCourseRepository _repository;

  PopularCourseController({required IPopularCourseRepository repository})
      : _repository = repository;
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  File? _courseImage;
  File? get courseImage => _courseImage;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<PopularCourseModel> _popularCourses = [];
  List<PopularCourseModel> get popularCourses => _popularCourses;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchPopularCourses();
  }

  void pickCourseImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _courseImage = File(pickedFile.path);
      update();
    } else {
      _courseImage = null;
      update();
    }
  }

  Future<bool> addPopularCourse(
      String courseTitle, String price, String type) async {
    if (courseTitle.isEmpty || _courseImage == null) {
      Get.snackbar("Error",
          "Please enter course title, price, type, and select an image");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      final imageUrl = await _repository.uploadCourseImage(_courseImage!);
      if (imageUrl != null) {
        final newCourse = PopularCourseModel(
          imageLink: imageUrl,
          title: courseTitle,
          price: price,
          type: type,
        );

        final success = await _repository.addPopularCourse(newCourse);
        if (success) {
          isSuccess = true;
          Future.delayed(const Duration(milliseconds: 200), () {
            Get.snackbar("Success", "Course added successfully!");
          });
        }
      } else {
        _errorMessage = "Image upload failed.";
        Get.snackbar("Error", _errorMessage!);
      }
    } catch (e) {
      _errorMessage = "An error occurred: $e";
      Get.snackbar("Error", _errorMessage!);
    } finally {
      _inProgress = false;
      update();
    }

    return isSuccess;
  }

  Future<void> fetchPopularCourses() async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _popularCourses = await _repository.fetchPopularCourses() ?? [];
    } catch (e) {
      _errorMessage = 'Failed to load popular courses: $e';
      Get.snackbar("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
  }

  void clearFields() {
    _courseImage = null;
    update();
  }
}
