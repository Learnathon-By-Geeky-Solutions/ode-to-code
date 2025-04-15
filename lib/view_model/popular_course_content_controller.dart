import 'package:edu_bridge_app/data/models/popular_course_content_model.dart';
import 'package:edu_bridge_app/data/repositories/popular_course_content/i_popular_course_content_repository.dart';
import 'package:edu_bridge_app/data/repositories/popular_course_content/popular_course_content_repository.dart';
import 'package:get/get.dart';

class PopularCourseContentController extends GetxController {
  final IPopularCourseContentRepository _repository;

  PopularCourseContentController({
    required IPopularCourseContentRepository repository,
  }) : _repository = repository;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<PopularCourseContentModel> _contents = [];
  List<PopularCourseContentModel> get contents => _contents;

  Future<bool> addContent(
    String courseId,
    String number,
    String title, {
    String? link, // Link is now optional
    String? note, // Note is now optional
  }) async {
    if (title.isEmpty || courseId.isEmpty) {
      Get.snackbar("Error", "Please enter content title and select course");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final newContent = PopularCourseContentModel(
      coursesId: courseId,
      title: title,
      number: number,
      link: link, // Use the optional link
      note: note, // Use the optional note
    );

    print('Test: $newContent');

    final success = await _repository.addPopularCourseContent(newContent);
    if (success) {
      isSuccess = true;
      Future.delayed(Duration.zero, () {
        Get.snackbar("Success", "Content added successfully!");
      });
    } else {
      _errorMessage = "Failed to add content.";
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<void> fetchContents(String courseId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _contents = await _repository.fetchPopularCourseContentById(courseId);
      print("Fetched contents: $_contents");
    } catch (e) {
      _errorMessage = 'Failed to load contents: $e';
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update();
  }
}
