import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/auth/profile/profile_view.dart';
import 'package:edu_bridge_app/view/home/widget/all_categories.dart';
import 'package:edu_bridge_app/view/home/widget/category_section.dart';
/*import 'package:edu_bridge_app/view/home/widget/all_categories.dart';
import 'package:edu_bridge_app/view/home/widget/category_section.dart';*/
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
  final List<String> categories = [
    AssetsPath.school,
    AssetsPath.college,
    AssetsPath.english,
    AssetsPath.creativity,
    AssetsPath.skill
  ];

  String _fullName = "Loading...";

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
        _fullName = userData['fullName'] ?? "No Name";
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
              _buildCarouselSlider(),
              SizedBox(height: 3.h),
              CategoriesSection(
                  widgets: AllCategories(categoriesList: categories)),
              SizedBox(height: 1.h),
              const PopularCourses(),
              SizedBox(height: 1.h),
              const TopMentorSection(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      title: InkWell(
        onTap: () {
          Get.to(ProfileView());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: _fullName,
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

  Widget _buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: List.generate(5, (index) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: AppColors.themeColor,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Image.asset(AssetsPath.sliderCard),
            );
          },
        );
      }),
    );
  }
}
