import 'package:carousel_slider/carousel_slider.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/auth/sign_in/Sign_In_view.dart';
import 'package:edu_bridge_app/view/home/widget/all_categories.dart';
import 'package:edu_bridge_app/view/home/widget/category_section.dart';
import 'package:edu_bridge_app/view/home/widget/popular_courses.dart';
import 'package:edu_bridge_app/view/home/widget/top_mentors.dart';
import 'package:edu_bridge_app/view_model/banner_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
              const CategoriesSection(),
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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: "Hi, ALEX",
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          Text(
            "What Would you like to learn Today? \nSearch Below",
            style: GoogleFonts.mulish(
              color: AppColors.blackGray,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            final supabase = Supabase.instance.client;
            await supabase.auth.signOut();
            Get.offAll(() => SignInView()); // Logs out the user
            // You can also add navigation here if needed, for example:
            // Get.offAll(SignInScreen()); // Redirect to the SignIn screen after logout
          },
          child: const Icon(Icons.logout),
        ),
      ],
    );
  }

  Widget _buildCarouselSlider() {
    return GetBuilder<BannerController>(
      builder: (controller) {
        if (controller.inProgress) {
          return const Center(
              child: CircularProgressIndicator()); // Loading indicator
        }

        if (controller.banners.isEmpty) {
          return const Center(
              child: Text("No banners available")); // No banners case
        }

        return CarouselSlider(
          options: CarouselOptions(
            height: 180.0,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: controller.banners.map((banner) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.network(
                      banner.imageLink,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported, size: 50);
                      },
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
