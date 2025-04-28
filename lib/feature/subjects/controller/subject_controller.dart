import 'package:edu_bridge_app/core/export.dart';

class SubjectController extends GetxController {
  final ISubjectRepository _repository;

  SubjectController({required ISubjectRepository repository})
      : _repository = repository;

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<SubjectModel> _subjects = [];
  List<SubjectModel> get subjects => _subjects;

  Future<bool> addSubject(String classId, String subjectName) async {
    if (subjectName.isEmpty || classId.isEmpty) {
      SnackBarUtil.showError(
          "Error", "Please enter subject name, select class");
      return false;
    }

    _setLoadingState(true);

    final newSubject = SubjectModel(
      classId: classId,
      subjectName: subjectName,
      image: '',
    );

    final success = await _repository.addSubject(newSubject);
    if (success) {
      SnackBarUtil.showSuccess("Success", "Subject added successfully!");
      fetchSubjects(classId);
    } else {
      SnackBarUtil.showError("Error", "Failed to add subject.");
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
      SnackBarUtil.showError("Error", _errorMessage!);
    }

    _setLoadingState(false);
  }

  void clearFields() {
    update();
  }

  void _setLoadingState(bool isLoading) {
    _inProgress = isLoading;
    _errorMessage = null;
    update();
  }
}
