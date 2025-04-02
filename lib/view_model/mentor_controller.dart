import 'dart:io';
import 'package:edu_bridge_app/data/models/mentor_model.dart';
import 'package:edu_bridge_app/data/repositories/mentor_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

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

  // Method to pick mentor image from gallery
  void pickMentorImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _mentorImage = File(pickedFile.path);
      update();
    }
  }

  // Method to add a new mentor
  Future<bool> addMentor(String name, String designation, String whatHeDo,
      String description) async {
    if (name.isEmpty ||
        designation.isEmpty ||
        whatHeDo.isEmpty ||
        description.isEmpty ||
        _mentorImage == null) {
      Get.snackbar("Error", "Please fill all the fields and select an image");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    // Upload the mentor image
    final imageUrl = await _repository.uploadMentorImage(_mentorImage!);
    if (imageUrl != null) {
      final newMentor = MentorModel(
        name: name,
        designation: designation,
        whatHeDo: whatHeDo,
        description: description,
        image: imageUrl, // Ensure the image URL is part of the model
      );

      // Add the mentor to the database
      final success = await _repository.addMentor(newMentor);
      if (success) {
        isSuccess = true;
        Future.delayed(Duration(milliseconds: 200), () {
          Get.snackbar("Success", "Mentor added successfully!");
        });
        fetchMentors();
      } else {
        _errorMessage = "Failed to add mentor.";
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

  // Method to fetch mentors from the database
  Future<void> fetchMentors() async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _mentors = await _repository.fetchMentors();
    } catch (e) {
      _errorMessage = 'Failed to load mentors: $e';
    }

    _inProgress = false;
    update();
  }

  // Method to clear the mentor fields (image, name, designation, etc.)
  void clearFields() {
    _mentorImage = null;
    update();
  }
}
