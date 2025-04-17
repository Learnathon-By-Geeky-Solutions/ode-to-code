import 'package:edu_bridge_app/core/resources/export.dart';

abstract class IBannerRepository {
  Future<String?> uploadBannerImage(File imageFile);
  Future<bool> addBanner(BannerModel banner);
  Future<List<BannerModel>> fetchBanners();
}
