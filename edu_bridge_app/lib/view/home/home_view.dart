import 'package:carousel_slider/carousel_slider.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/auth/sign_in/Sign_In_view.dart';
import 'package:edu_bridge_app/view/home/widget/all_categories.dart';
import 'package:edu_bridge_app/view/home/widget/category_section.dart';
import 'package:edu_bridge_app/view/home/widget/custom_scaffold_home.dart';
import 'package:edu_bridge_app/view/home/widget/home_banner.dart';
import 'package:edu_bridge_app/view/home/widget/popular_courses.dart';
import 'package:edu_bridge_app/view/home/widget/top_mentors.dart';
import 'package:edu_bridge_app/view_model/banner_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHome(
      email: widget.email,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 1.h),
              const HomeBanner(),
              SizedBox(height: 1.h),
              const CategoriesSection(),
              // SizedBox(height: 1.h),
              const PopularCourses(),
              SizedBox(height: 1.h),
              const TopMentorSection(),
            ],
          ),
        ),
      ),
    );
  }
}
