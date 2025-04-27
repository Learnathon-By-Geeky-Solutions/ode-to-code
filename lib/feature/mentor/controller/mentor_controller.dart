import 'package:edu_bridge_app/core/resources/export.dart';

class MentorController extends GetxController {
  final MentorRepository _repository = MentorRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  File? _mentorImage;
  File? get mentorImage => _mentorImage;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<MentorModel> _mentors = [];
  List<MentorModel> get mentors => _mentors;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchMentors();
  }

  void pickMentorImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _mentorImage = File(pickedFile.path);
      update();
    }
  }

  Future<bool> addMentor(String name, String designation, String whatHeDo,
      String description) async {
    if (name.isEmpty ||
        designation.isEmpty ||
        whatHeDo.isEmpty ||
        description.isEmpty ||
        _mentorImage == null) {
      SnackBarUtil.showError(
          "Error", "Please fill all the fields and select an image");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      final imageUrl = await _repository.uploadMentorImage(_mentorImage!);
      if (imageUrl != null) {
        final newMentor = MentorModel(
          name: name,
          designation: designation,
          whatHeDo: whatHeDo,
          description: description,
          image: imageUrl,
        );

        final success = await _repository.addMentor(newMentor);
        if (success) {
          isSuccess = true;
          SnackBarUtil.showSuccess("Success", "Mentor added successfully!");
          fetchMentors();
        } else {
          _errorMessage = "Failed to add mentor.";
          SnackBarUtil.showError("Error", _errorMessage!);
        }
      } else {
        _errorMessage = "Image upload failed.";
        SnackBarUtil.showError("Error", _errorMessage!);
      }
    } catch (e) {
      _errorMessage = "An error occurred while adding mentor: $e";
      SnackBarUtil.showError("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<void> fetchMentors() async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _mentors = await _repository.fetchMentors();
    } catch (e) {
      _errorMessage = 'Failed to load mentors: $e';
      SnackBarUtil.showError("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
  }

  void clearFields() {
    _mentorImage = null;
    update();
  }
}
