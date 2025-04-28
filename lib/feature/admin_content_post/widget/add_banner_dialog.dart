import 'package:edu_bridge_app/core/export.dart';

class AddBannerDialog extends StatelessWidget {
  final TextEditingController bannerTitleController;

  const AddBannerDialog({super.key, required this.bannerTitleController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      builder: (controller) {
        return AlertDialog(
          backgroundColor: AppColors.bg,
          title: CustomText(text: "add_banner".tr),
          content: SizedBox(
            width: double.maxFinite,
            child: AddBannerForm(
              bannerTitleController: bannerTitleController,
              controller: controller,
            ),
          ),
          actions: [
            // Add button
            TextButton(
              onPressed: () async {
                final title = bannerTitleController.text.trim();
                if (title.isNotEmpty) {
                  final success = await controller.addBanner(title);

                  if (success) {
                    Get.back();
                    SnackBarUtil.showSuccess(
                        "Success", "Banner added successfully!");
                  }
                }
              },
              child: controller.inProgress
                  ? const CircularProgressIndicator()
                  : CustomText(text: "add".tr),
            ),
          ],
        );
      },
    );
  }
}
