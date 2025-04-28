import 'package:edu_bridge_app/core/export.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfileModel profile;

  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.green, width: 4),
            color: AppColors.greenAccent,
          ),
          child: CircleAvatar(
            backgroundImage: profile.image.isNotEmpty
                ? NetworkImage(profile.image)
                : const AssetImage('assets/images/default_avatar.png')
                    as ImageProvider,
          ),
        ),
        const SizedBox(height: 16),
        CustomText(text: profile.name),
        CustomText(text: profile.email),
        const SizedBox(height: 24),
      ],
    );
  }
}
