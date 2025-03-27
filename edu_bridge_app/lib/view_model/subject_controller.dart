import 'dart:io';
import 'package:edu_bridge_app/data/models/subject_model.dart';
import 'package:edu_bridge_app/data/repositories/subjects_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class SubjectController extends GetxController {
  final SubjectRepository _repository = SubjectRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  File? _subjectImage;
  File? get subjectImage => _subjectImage;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<SubjectModel> _subjects = [];
  List<SubjectModel> get subjects => _subjects;

  final ImagePicker _picker = ImagePicker();

  void pickSubjectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _subjectImage = File(pickedFile.path);
      update();
    }
  }

  Future<bool> addSubject(String classId, String subjectName) async {
    if (subjectName.isEmpty || classId.isEmpty || _subjectImage == null) {
      Get.snackbar(
          "Error", "Please enter subject name, select class, and an image");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final imageUrl = await _repository.uploadSubjectImage(_subjectImage!);
    if (imageUrl != null) {
      final newSubject = SubjectModel(
        classId: classId,
        subjectName: subjectName,
        image: imageUrl,
      );

      final success = await _repository.addSubject(newSubject);
      if (success) {
        isSuccess = true;
        Get.snackbar("Success", "Subject added successfully!");
      } else {
        _errorMessage = "Failed to add subject.";
        Get.snackbar("Error", _errorMessage!);
      }
    } else {
      _errorMessage = "Image upload failed.";
      Get.snackbar("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<void> fetchSubjects(String classId) async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _subjects = await _repository.fetchSubjectsByClassId(classId);
    } catch (e) {
      _errorMessage = 'Failed to load subjects: $e';
    }

    _inProgress = false;
    update();
  }

  void clearFields() {
    _subjectImage = null;
    update();
  }
}
