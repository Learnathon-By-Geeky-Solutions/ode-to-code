import 'package:edu_bridge_app/core/resources/export.dart';

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
        Positioned.fill(
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
        ),
      ],
    );
  }

  void showAddBanner(BuildContext context) {
    final bannerTitle = TextEditingController();
    _showAddBannerDialog(context, bannerTitle);
  }

  void _showAddBannerDialog(
      BuildContext context, TextEditingController bannerTitle) {
    Get.dialog(
      GetBuilder<BannerController>(
        builder: (controller) {
          return AlertDialog(
            title: CustomText(text: "add_banner".tr),
            content: SizedBox(
              width: double.maxFinite,
              child: AddBannerForm(
                bannerTitleController: bannerTitle,
                controller: controller,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  final bannerTitleText = bannerTitle.text.trim();
                  if (bannerTitleText.isNotEmpty) {
                    final success = await controller.addBanner(bannerTitleText);
                    if (success) Get.back();
                  }
                },
                child: CustomText(text: "add".tr),
              ),
            ],
          );
        },
      ),
    );
  }
}
