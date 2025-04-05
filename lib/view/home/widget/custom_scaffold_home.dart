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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // Custom height for AppBar
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
          child: AppBar(
            backgroundColor: AppColors.bg,
            elevation: 0,
            title: Column(
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
            actions: [
              ...?actions,
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.bg,
      body: body,
      floatingActionButton: floatingActionButton,
      endDrawer: _buildDrawer(context),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: name ?? "User Email",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackGray,
                ),
                CustomText(
                  text: email ?? "",
                  fontSize: 16,
                  color: AppColors.blackGray,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Your Profile"),
            onTap: () {
              Get.to(() => const FetchUserProfileView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Sign Out"),
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
