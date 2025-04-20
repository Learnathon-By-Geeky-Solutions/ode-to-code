import 'package:edu_bridge_app/core/resources/export.dart';

class ChapterController extends GetxController {
  final IChapterRepository _repository;
  ChapterController({required IChapterRepository repository})
      : _repository = repository;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ChapterModel> _chapters = [];
  List<ChapterModel> get chapters => _chapters;

  Future<bool> addChapter(String subjectId, String chapterName) async {
    if (chapterName.isEmpty || subjectId.isEmpty) {
      SnackbarUtil.showError(
          "Error", "Please enter chapter name and select subject");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final newChapter = ChapterModel(
      subjectId: subjectId,
      chapterName: chapterName,
    );

    final success = await _repository.addChapter(newChapter);
    if (success) {
      isSuccess = true;
      SnackbarUtil.showSuccess("Success", "Chapter added successfully!");
    } else {
      _errorMessage = "Failed to add chapter.";
      SnackbarUtil.showError("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<void> fetchChapters(String subjectId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _chapters = await _repository.fetchChaptersBySubjectId(subjectId);
    } catch (e) {
      _errorMessage = 'Failed to load chapters: $e';
      SnackbarUtil.showError("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
  }
}
