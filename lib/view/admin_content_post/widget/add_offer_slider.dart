import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/add_banner_form.dart';
import 'package:edu_bridge_app/view_model/banner_controller.dart';

class AddOfferSlider extends StatelessWidget {
  const AddOfferSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAddBanner(context);
      },
      child: Stack(
        children: [
          Image.asset(AssetsPath.sliderCard),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
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
      ),
    );
  }

  void showAddBanner(BuildContext context) {
    final TextEditingController bannerTitle = TextEditingController();
    Get.dialog(
      GetBuilder<BannerController>(
        builder: (controller) {
          return AlertDialog(
            title: const Text("Add Banner"),
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
                    if (success) {
                      Get.back(); // Close the dialog on success
                    }
                  }
                },
                child: const Text("Add"),
              ),
            ],
          );
        },
      ),
    );
  }
}
