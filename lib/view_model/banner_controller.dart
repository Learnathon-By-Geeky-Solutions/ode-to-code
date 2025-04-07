import 'dart:io';
import 'package:edu_bridge_app/data/models/banner_model.dart';
import 'package:edu_bridge_app/data/repositories/banner_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  final BannerRepository _repository = BannerRepository();
  final ImagePicker _picker = ImagePicker();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  File? _bannerImage;
  File? get bannerImage => _bannerImage;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<BannerModel> _banners = [];
  List<BannerModel> get banners => _banners;

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  void _setInProgress(bool value) {
    _inProgress = value;
    update();
  }

  void _handleError(String message) {
    _errorMessage = message;
    Get.snackbar("Error", message);
  }

  void pickBannerImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _bannerImage = File(pickedFile.path);
      update();
    }
  }

  Future<bool> addBanner(String details) async {
    if (details.isEmpty || _bannerImage == null) {
      _handleError("Please enter banner details and select an image");
      return false;
    }

    _setInProgress(true);
    bool isSuccess = false;

    try {
      final imageUrl = await _repository.uploadBannerImage(_bannerImage!);
      if (imageUrl == null) {
        _handleError("Image upload failed.");
        return false;
      }

      final banner = BannerModel(details: details, imageLink: imageUrl);
      isSuccess = await _repository.addBanner(banner);

      if (isSuccess) {
        Get.snackbar("Success", "Banner added successfully!");
        fetchBanners();
      } else {
        _handleError("Failed to add banner.");
      }
    } catch (e) {
      _handleError("An error occurred: $e");
    }

    _setInProgress(false);
    return isSuccess;
  }

  Future<void> fetchBanners() async {
    _setInProgress(true);
    _errorMessage = null;

    try {
      _banners = await _repository.fetchBanners();
      // No snackbar for successful fetch
    } catch (e) {
      _handleError("Failed to load banners: $e");
    }

    _setInProgress(false);
  }

  void clearFields() {
    _bannerImage = null;
    update();
  }
}
