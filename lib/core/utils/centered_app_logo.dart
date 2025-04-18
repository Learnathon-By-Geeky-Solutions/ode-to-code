import 'package:edu_bridge_app/core/resources/export.dart';

class CenteredAppLogo extends StatelessWidget {
  final double topSpacing;
  final double bottomSpacing;

  const CenteredAppLogo({
    super.key,
    this.topSpacing = 10.0,
    this.bottomSpacing = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: topSpacing.h),
        Image.asset(AssetsPath.appLogo),
        SizedBox(height: bottomSpacing.h),
      ],
    );
  }
}
