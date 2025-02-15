import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/auth/profile/profile_view.dart';
import 'package:edu_bridge_app/view/home/widget/all_categories.dart';
import 'package:edu_bridge_app/view/home/widget/banner_carousel.dart';
import 'package:edu_bridge_app/view/home/widget/category_section.dart';
import 'package:edu_bridge_app/view/home/widget/popular_courses.dart';
import 'package:edu_bridge_app/view/home/widget/top_mentors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _nicName = "Loading...";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    String userId = _auth.currentUser!.uid;
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();
    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      setState(() {
        _nicName = userData['nickName'] ?? "No Name";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Column(
            children: [
              BannerCarousel(),
              SizedBox(height: 3.h),
              CategoriesSection(widgets: AllCategories()),
              SizedBox(height: 1.h),
              PopularCourse(),
              SizedBox(height: 1.h),
              TopMentors(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            AssetsPath.notification,
          ),
        )
      ],
      title: InkWell(
        onTap: () {
          Get.to(ProfileView());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Hi, $_nicName",
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            Text(
              "What Would you like to learn Today?",
              style: GoogleFonts.mulish(
                color: AppColors.blackGray,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      /*actions: [
        GestureDetector(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Get.snackbar('Logged Out', 'User successfully logged out',
                snackPosition: SnackPosition.TOP);
            Get.offAll(const SignInView());
          },
          child: const Icon(Icons.logout),
        ),
      ],*/
    );
  }
}
