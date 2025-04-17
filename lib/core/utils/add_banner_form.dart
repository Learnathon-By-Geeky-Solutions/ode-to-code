import 'package:edu_bridge_app/core/resources/export.dart';

class AddBannerForm extends StatelessWidget {
  final TextEditingController bannerTitleController;
  final BannerController controller;

  const AddBannerForm({
    super.key,
    required this.bannerTitleController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextFormField(
          controller: bannerTitleController,
          labelText: 'Enter banner name',
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            controller.pickBannerImage();
          },
          child: CustomText(
            text: 'add_image'.tr,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        controller.bannerImage != null
            ? Image.file(
                controller.bannerImage!,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              )
            : CustomText(text: 'no_image_selected'.tr),
      ],
    );
  }
}
