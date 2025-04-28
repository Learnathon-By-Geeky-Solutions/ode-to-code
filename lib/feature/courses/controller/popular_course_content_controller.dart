import 'package:edu_bridge_app/core/export.dart';

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
    String? link,
    String? note,
  }) async {
    if (title.isEmpty || courseId.isEmpty) {
      SnackBarUtil.showError(
          "Error", "Please enter content title and select course");
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

    final success = await _repository.addPopularCourseContent(newContent);
    if (success) {
      isSuccess = true;
      SnackBarUtil.showSuccess("Success", "Content added successfully!");
    } else {
      _errorMessage = "Failed to add content.";
      SnackBarUtil.showError("Error", _errorMessage!);
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
    } catch (e) {
      _errorMessage = 'Failed to load contents: $e';
      SnackBarUtil.showError("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
  }
}
