import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/feature/admin_content_post/widget/add_banner_dialog.dart';

class AddOfferSlider extends StatelessWidget {
  const AddOfferSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showAddBanner(context),
      child: _buildBannerContent(),
    );
  }

  Widget _buildBannerContent() {
    return Stack(
      children: [
        Image.asset(AssetsPath.sliderCard),
        _buildBannerOverlay(),
      ],
    );
  }

  Widget _buildBannerOverlay() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, color: AppColors.white),
            CustomText(
              text: 'insert_banner_instruction'.tr,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void showAddBanner(BuildContext context) {
    final bannerTitle = TextEditingController();
    Get.dialog(AddBannerDialog(bannerTitleController: bannerTitle));
  }
}
