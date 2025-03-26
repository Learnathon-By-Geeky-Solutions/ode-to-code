import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/auth/sign_in/Sign_In_view.dart';
import 'package:edu_bridge_app/view/user/user_profile_view.dart';
import 'package:edu_bridge_app/view/user/user_view.dart';
import 'package:edu_bridge_app/view_model/user_controller.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: AppColors.bg,
      title: GetBuilder<UserController>(builder: (controller) {
        return InkWell(
          onTap: () =>
              Get.to(() => UserProfileView()), // Navigate to User Profile
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: name ?? "Welcome!", // Handle null case
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              /*Text(
                "What would you like to learn today? \nSearch below",
                style: GoogleFonts.mulish(
                  color: AppColors.blackGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),*/
            ],
          ),
        );
      }),
      /*actions: [
        ...?actions, // Include additional actions if provided
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
      ],*/
    );
  }
}
