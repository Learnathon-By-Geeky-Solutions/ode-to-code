import 'package:edu_bridge_app/core/export.dart';

class ProfileAvatar extends StatelessWidget {
  final UserProfileModel profile;

  const ProfileAvatar({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.green, width: 4),
          color: AppColors.green,
        ),
        child: CircleAvatar(
          backgroundImage: profile.image.isNotEmpty
              ? NetworkImage(profile.image)
              : const AssetImage('assets/images/default_avatar.png')
                  as ImageProvider,
        ),
      ),
    );
  }
}
