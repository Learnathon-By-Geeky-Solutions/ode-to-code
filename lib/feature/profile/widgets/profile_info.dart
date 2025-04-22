import 'package:edu_bridge_app/core/resources/export.dart';

class ProfileInfo extends StatelessWidget {
  final UserProfileModel profile;

  const ProfileInfo({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: profile.name.isEmpty ? 'No name available' : profile.name,
          textAlign: TextAlign.center,
        ),
        CustomText(
          text: profile.email.isEmpty ? 'No email available' : profile.email,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
