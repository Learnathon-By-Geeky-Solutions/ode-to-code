import 'package:edu_bridge_app/core/export.dart';

class ProfileStateBuilder extends StatelessWidget {
  final UserProfileController controller;
  final Widget Function(UserProfileModel) builder;

  const ProfileStateBuilder({
    super.key,
    required this.controller,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.inProgress) {
      return const Center(child: CircularProgressIndicator());
    }
    if (controller.errorMessage != null) {
      return Center(
        child: CustomText(
          text: controller.errorMessage!,
          customStyle: const TextStyle(color: AppColors.red, fontSize: 16),
        ),
      );
    }
    if (controller.userProfile != null) {
      return builder(controller.userProfile!);
    }
    return Center(
      child: CustomText(
        text: 'no_content_available'.tr,
        color: AppColors.grey,
        fontSize: 16,
      ),
    );
  }
}
