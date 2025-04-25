import 'package:edu_bridge_app/core/resources/export.dart';

class SubjectController extends GetxController {
  final ISubjectRepository _repository;

  SubjectController({required ISubjectRepository repository})
      : _repository = repository;

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
      _showSnackbar(
          "Error", "Please enter subject name, select class, and an image");
      return false;
    }

    _setLoadingState(true);

    final imageUrl = await _repository.uploadSubjectImage(_subjectImage!);
    if (imageUrl != null) {
      final newSubject = SubjectModel(
        classId: classId,
        subjectName: subjectName,
        image: imageUrl,
      );

      final success = await _repository.addSubject(newSubject);
      if (success) {
        _showSnackbar("Success", "Subject added successfully!");
        fetchSubjects(classId); // Re-fetch subjects after adding
      } else {
        _showSnackbar("Error", "Failed to add subject.");
      }
    } else {
      _showSnackbar("Error", "Image upload failed.");
    }

    _setLoadingState(false);
    return true;
  }

  Future<void> fetchSubjects(String classId) async {
    _setLoadingState(true);

    try {
      _subjects = await _repository.fetchSubjectsByClassId(classId);
    } catch (e) {
      _errorMessage = 'Failed to load subjects: $e';
      _showSnackbar("Error", _errorMessage!);
    }

    _setLoadingState(false);
  }

  void clearFields() {
    _subjectImage = null;
    update();
  }

  void _setLoadingState(bool isLoading) {
    _inProgress = isLoading;
    _errorMessage = null;
    update();
  }

  void _showSnackbar(String title, String message) {
    Get.snackbar(title, message);
  }
}
