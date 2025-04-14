import 'package:edu_bridge_app/resources/export.dart';
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
                      color: Colors.white),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: bannerTitle,
                    decoration:
                        const InputDecoration(hintText: "Enter banner name"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      controller.pickBannerImage();
                    },
                    child: const Text("Add Image"),
                  ),
                  const SizedBox(height: 10),
                  controller.bannerImage != null
                      ? Image.file(
                          controller.bannerImage!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        )
                      : const Text('No image selected'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  final bannerTitleText = bannerTitle.text.trim();
                  // Ensure that the controller is being accessed correctly here.

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
