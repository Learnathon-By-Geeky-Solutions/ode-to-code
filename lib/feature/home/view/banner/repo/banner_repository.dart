import 'package:edu_bridge_app/core/export.dart';

class BannerRepository extends IBannerRepository {
  BannerRepository({required INetworkCaller networkCaller});
  final NetworkCaller _networkCaller = NetworkCaller();

  @override
  Future<String?> uploadBannerImage(File imageFile) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = 'banners/$fileName';

    final response = await _networkCaller.uploadFile(
      bucketName: 'banners',
      filePath: filePath,
      file: imageFile,
    );

    return response.isSuccess ? response.responseData : null;
  }

  @override
  Future<bool> addBanner(BannerModel banner) async {
    final response = await _networkCaller.postRequest(
      tableName: 'banners',
      data: banner.toMap(),
    );
    return response.isSuccess;
  }

  @override
  Future<List<BannerModel>> fetchBanners() async {
    final response = await _networkCaller.getRequest(tableName: 'banners');
    if (response.isSuccess) {
      return (response.responseData as List)
          .map((data) => BannerModel.fromMap(data))
          .toList();
    }
    return [];
  }
}
