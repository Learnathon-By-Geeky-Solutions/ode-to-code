import 'dart:io';
import 'package:edu_bridge_app/data/models/banner_model.dart';

abstract class IBannerRepository {
  Future<String?> uploadBannerImage(File imageFile);
  Future<bool> addBanner(BannerModel banner);
  Future<List<BannerModel>> fetchBanners();
}
