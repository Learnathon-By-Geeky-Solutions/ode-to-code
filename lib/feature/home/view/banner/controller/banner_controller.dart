import 'package:edu_bridge_app/core/export.dart';

class BannerController extends GetxController {
  final IBannerRepository _repository;

  BannerController({required IBannerRepository repository})
      : _repository = repository;

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

  void pickBannerImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _bannerImage = File(pickedFile.path);
      update();
    } else {
      _bannerImage = null;
      update();
    }
  }

  Future<bool> addBanner(String details) async {
    if (details.isEmpty || _bannerImage == null) {
      SnackBarUtil.showError(
          "Error", "Please enter banner details and select an image");
      return false;
    }

    _inProgress = true;
    _errorMessage = null;
    update();

    bool isSuccess = false;

    try {
      final imageUrl = await _repository.uploadBannerImage(_bannerImage!);
      if (imageUrl != null) {
        final banner = BannerModel(details: details, imageLink: imageUrl);
        isSuccess = await _repository.addBanner(banner);

        if (isSuccess) {
          SnackBarUtil.showSuccess("Success", "Banner added successfully!");
          fetchBanners();
        } else {
          _errorMessage = "Failed to add banner.";
          SnackBarUtil.showError("Error", _errorMessage!);
        }
      } else {
        _errorMessage = "Image upload failed.";
        SnackBarUtil.showError("Error", _errorMessage!);
      }
    } catch (e) {
      _errorMessage = "An error occurred: $e";
      SnackBarUtil.showError("Error", _errorMessage!);
    } finally {
      _inProgress = false;
      update();
    }

    return isSuccess;
  }

  Future<void> fetchBanners() async {
    _inProgress = true;
    _errorMessage = null;
    update();

    try {
      _banners = await _repository.fetchBanners();
    } catch (e) {
      _errorMessage = "Failed to load banners: $e";
      SnackBarUtil.showError("Error", _errorMessage!);
    }

    _inProgress = false;
    update();
  }

  void clearFields() {
    _bannerImage = null;
    update();
  }
}
