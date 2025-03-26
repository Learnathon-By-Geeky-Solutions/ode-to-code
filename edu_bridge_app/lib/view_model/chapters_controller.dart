import 'package:edu_bridge_app/data/repositories/chapters_repository.dart';
import 'package:get/get.dart';
import 'package:edu_bridge_app/data/models/chapter_model.dart';

class ChapterController extends GetxController {
  final ChapterRepository _repository = ChapterRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ChapterModel> _chapters = [];
  List<ChapterModel> get chapters => _chapters;

  Future<bool> addChapter(String subjectId, String chapterName) async {
    if (chapterName.isEmpty || subjectId.isEmpty) {
      Get.snackbar("Error", "Please enter chapter name and select subject");
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

    print('Test : \$newChapter');

    final success = await _repository.addChapter(newChapter);
    if (success) {
      isSuccess = true;
      Get.snackbar("Success", "Chapter added successfully!");
    } else {
      _errorMessage = "Failed to add chapter.";
      Get.snackbar("Error", _errorMessage!);
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
      _errorMessage = 'Failed to load chapters: \$e';
    }

    _inProgress = false;
    update();
  }
}
