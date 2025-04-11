import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/auth/sign_in/sign_in_view.dart';
import 'package:edu_bridge_app/view/user/user_profile_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      title: InkWell(
        onTap: () => Get.to(() => const UserProfileView()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: name ?? "Welcome!",
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      actions: [
        ...?actions,
        GestureDetector(
          onTap: () async {
            final supabase = Supabase.instance.client;
            await supabase.auth.signOut();
            Get.offAll(const SignInView());
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.logout),
          ),
        ),
      ],
    );
  }
}
