import 'package:edu_bridge_app/core/export.dart';
import 'package:edu_bridge_app/feature/admin_content_post/widget/add_banner_dialog.dart';

class AddOfferSlider extends StatelessWidget {
  const AddOfferSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomText(
          text: "Add Banner or Offer Post here",
          fontSize: 22,
        ),
        SizedBox(height: 2.h),
        GestureDetector(
          onTap: () => showAddBanner(context),
          child: _buildBannerContent(),
        ),
      ],
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
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }

  void showAddBanner(BuildContext context) {
    final bannerTitleController = TextEditingController();
    final bannerController = Get.find<BannerController>();

    Get.dialog(
      AddBannerDialog(bannerTitleController: bannerTitleController),
      barrierDismissible: true,
    ).then((_) {
      bannerController.clearFields();
      bannerTitleController.clear();
    });
  }
}
