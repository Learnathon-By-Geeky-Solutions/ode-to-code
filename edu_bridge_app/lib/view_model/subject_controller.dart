/*
import 'package:edu_bridge_app/resources/export.dart';

class SubjectsController extends GetxController {
  RxList<String> subjects = ["Math", "Science", "English"].obs;
  RxMap<String, List<String>> subjectChapters = <String, List<String>>{}.obs;

  void addSubject(String subject) {
    subjects.add(subject);
    subjectChapters[subject] = [];
  }

  void addChapter(String subject, String chapter) {
    if (subjectChapters.containsKey(subject)) {
      subjectChapters[subject]?.add(chapter);
    }
  }

  List<String> getChapters(String subject) {
    return subjectChapters[subject] ?? [];
  }
}
*/
