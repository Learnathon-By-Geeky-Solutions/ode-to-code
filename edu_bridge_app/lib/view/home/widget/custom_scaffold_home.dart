import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/auth/sign_in/Sign_In_view.dart';
import 'package:edu_bridge_app/view/user/fetch_user_profile_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomScaffoldHome extends StatelessWidget {
  final String? name;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final String? email;

  const CustomScaffoldHome({
    super.key,
    this.name,
    required this.body,
    this.floatingActionButton,
    this.actions,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(email!),
      backgroundColor: AppColors.bg,
      body: body,
      floatingActionButton: floatingActionButton,
      endDrawer: _buildDrawer(context),
    );
  }

  AppBar _buildAppBar(String email) {
    return AppBar(
      backgroundColor: AppColors.white,
      title: InkWell(
        onTap: () => Get.to(() => FetchUserProfileScreen(email: email)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: name ?? "Hi there!",
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            Text(
              "What would you like to learn today? \nSearch below",
              style: GoogleFonts.mulish(
                color: AppColors.blackGray,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      actions: [
        ...?actions,
      ],
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: name ?? "User",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
                CustomText(
                  text: email ?? "",
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Fetch Profile"),
            onTap: () {
              Get.to(() => FetchUserProfileScreen(email: email!));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Sign Out"),
            onTap: () async {
              final supabase = Supabase.instance.client;
              await supabase.auth.signOut();
              Get.offAll(const SignInView());
            },
          ),
        ],
      ),
    );
  }
}
