import 'package:edu_bridge_app/core/export.dart';

class CustomScaffold extends StatelessWidget {
  final String? name;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const CustomScaffold({
    super.key,
    this.name,
    required this.body,
    this.floatingActionButton,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.bg,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: _buildTitle(),
      actions: actions, // ← Add this line!
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: name ?? 'welcome'.tr,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
