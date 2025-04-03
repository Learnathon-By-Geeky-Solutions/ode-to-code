import 'package:edu_bridge_app/data/models/content_model.dart';
import 'package:edu_bridge_app/data/models/popular_course_content_model.dart';
import 'package:edu_bridge_app/data/repositories/content_repository.dart';
import 'package:edu_bridge_app/data/repositories/popular_course_content_repository.dart';
import 'package:get/get.dart';

class PopularCourseContentController extends GetxController {
  final PopularCourseContentRepository _repository =
      PopularCourseContentRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<PopularCourseContentModel> _contents = [];
  List<PopularCourseContentModel> get contents => _contents;

  Future<bool> addContent(
      String courseId, String number, String title, String link) async {
    if (title.isEmpty || link.isEmpty || courseId.isEmpty) {
      Get.snackbar(
          "Error", "Please enter content name, link, and select chapter");
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
      link: link,
    );

    print('Test : \$newContent');

    final success = await _repository.addPopularCourseContent(newContent);
    if (success) {
      isSuccess = true;
      // Using Future.delayed to ensure snackbar appears immediately
      Future.delayed(Duration.zero, () {
        Get.snackbar("Success", "Content added successfully!");
      });
    } else {
      _errorMessage = "Failed to add content.";
      // Using Future.delayed to ensure snackbar appears immediately
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
      // Log the fetched contents for debugging
      print("Fetched contents: $_contents");
    } catch (e) {
      _errorMessage = 'Failed to load contents: \$e';
      // Using Future.delayed to ensure snackbar appears immediately
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update();
  }
}
