import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/home/widget/category_section.dart';
import 'package:edu_bridge_app/view/home/widget/custom_scaffold_home.dart';
import 'package:edu_bridge_app/view/home/widget/home_banner.dart';
import 'package:edu_bridge_app/view/home/widget/popular_courses.dart';
import 'package:edu_bridge_app/view/home/widget/top_mentors.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHome(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 1.h),
              const HomeBanner(),
              SizedBox(height: 1.h),
              const CategoriesSection(),
              // SizedBox(height: 1.h),
              const PopularCourses(),
              /*SizedBox(height: 1.h),
              const TopMentorSection(),*/
            ],
          ),
        ),
      ),
    );
  }
}
