import 'dart:io';
import 'package:edu_bridge_app/data/models/banner_model.dart';
import 'package:edu_bridge_app/data/repositories/banner_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  final BannerRepository _repository = BannerRepository();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  File? _bannerImage;
  File? get bannerImage => _bannerImage;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<BannerModel> _banners = [];
  List<BannerModel> get banners => _banners;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchBanners(); // Fetch banners when controller is initialized
  }

  // Picking banner image from gallery
  void pickBannerImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _bannerImage = File(pickedFile.path);
      update();
    }
  }

  // Method to add a banner with details
  Future<bool> addBanner(String details) async {
    if (details.isEmpty || _bannerImage == null) {
      Get.snackbar("Error", "Please enter banner details and select an image");
      return false;
    }

    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final imageUrl = await _repository.uploadBannerImage(_bannerImage!);

    if (imageUrl != null) {
      final newBanner = BannerModel(details: details, imageLink: imageUrl);
      final success = await _repository.addBanner(newBanner);

      if (success) {
        isSuccess = true;
        // Show success message before fetching banners23
        Future.delayed(Duration(milliseconds: 200), () {
          Get.snackbar("Success", "Banner added successfully!");
        });
        fetchBanners(); // Fetch banners after success
      } else {
        _errorMessage = "Failed to add banner.";
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

  // Fetching all banners from the database
  Future<void> fetchBanners() async {
    _inProgress = true;
    _errorMessage = null;
    update(); // Update UI for loading state

    try {
      // Fetch banners from the repository
      _banners = await _repository.fetchBanners();
    } catch (e) {
      _errorMessage = 'Failed to load banners: $e';
      Get.snackbar(
          "Error", _errorMessage!); // Show error message if fetching fails
    }

    _inProgress = false;
    update(); // Update the UI after fetching
  }

  // Clearing the fields (image and other states)
  void clearFields() {
    _bannerImage = null;
    update(); // Update the UI state
  }
}
