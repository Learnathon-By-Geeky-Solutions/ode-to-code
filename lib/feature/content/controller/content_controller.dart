import 'package:edu_bridge_app/core/export.dart';

class CourseContentController extends GetxController {
  final IContentRepository _repository;
  CourseContentController({required IContentRepository repository})
      : _repository = repository;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ContentModel> _contents = [];
  List<ContentModel> get contents => _contents;

  Future<bool> addContent(
    String chaptersId,
    String number,
    String name, {
    String? link,
    String? note,
  }) async {
    if (name.isEmpty || chaptersId.isEmpty) {
      SnackBarUtil.showError(
          "Error", "Please enter content name and select chapter");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final newContent = ContentModel(
      chaptersId: chaptersId,
      number: number,
      name: name,
      link: link,
      note: note,
      createdAt: DateTime.now().toIso8601String(),
    );

    final success = await _repository.addContent(newContent);
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

  Future<void> fetchContents(String chaptersId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _contents = await _repository.fetchContentsByChapterId(chaptersId);
    } catch (e) {
      _errorMessage = 'Failed to load contents: $e';
      SnackBarUtil.showError("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
  }
}
