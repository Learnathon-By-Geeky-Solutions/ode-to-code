import 'package:edu_bridge_app/resources/export.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const CustomScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: CustomText(
          text: title,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      backgroundColor: AppColors.white,
      body: body,
    );
  }
}
