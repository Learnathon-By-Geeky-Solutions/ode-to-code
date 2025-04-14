import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_text_field.dart';
import 'package:edu_bridge_app/view_model/banner_controller.dart';

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
    );
  }
}
