import 'package:edu_bridge_app/core/resources/export.dart';

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
      actions: _buildActions(),
    );
  }

  Widget _buildTitle() {
    return InkWell(
      onTap: () => Get.to(() => const UserProfileView()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: name ?? 'welcome'.tr,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActions() {
    return [
      ...?actions,
      _buildLogoutAction(),
    ];
  }

  Widget _buildLogoutAction() {
    return GestureDetector(
      onTap: _handleLogout,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Icon(Icons.logout),
      ),
    );
  }

  Future<void> _handleLogout() async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signOut();
    Get.offAll(const SignInView());
  }
}
