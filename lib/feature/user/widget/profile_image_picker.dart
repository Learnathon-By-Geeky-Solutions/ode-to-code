import 'package:edu_bridge_app/core/export.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    return GetBuilder<UserProfileController>(
      builder: (controller) {
        return InkWell(
          onTap: () async {
            final pickedFile =
                await picker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              controller.setProfileImage(File(pickedFile.path));
            }
          },
          child: Column(
            children: [
              controller.profileImage != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(controller.profileImage!),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(Icons.person,
                          size: 95, color: Colors.white),
                    ),
            ],
          ),
        );
      },
    );
  }
}
