import 'package:edu_bridge_app/data/models/content_model.dart';
import 'package:edu_bridge_app/data/repositories/content_repository.dart';
import 'package:get/get.dart';

class CourseContentController extends GetxController {
  final ContentRepository _repository = ContentRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ContentModel> _contents = [];
  List<ContentModel> get contents => _contents;

  Future<bool> addContent(
      String chaptersId, String number, String name, String link) async {
    if (name.isEmpty || link.isEmpty || chaptersId.isEmpty) {
      Get.snackbar(
          "Error", "Please enter content name, link, and select chapter");
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
      createdAt: DateTime.now().toIso8601String(),
    );

    print('Test : \$newContent');

    final success = await _repository.addContent(newContent);
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

  Future<void> fetchContents(String chaptersId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _contents = await _repository.fetchContentsByChapterId(chaptersId);
      print("Fetched contents: $_contents");
    } catch (e) {
      _errorMessage = 'Failed to load contents: \$e';
      Future.delayed(Duration.zero, () {
        Get.snackbar("Error", _errorMessage!);
      });
    }

    _inProgress = false;
    update();
  }
}
