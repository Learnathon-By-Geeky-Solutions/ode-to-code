import 'package:edu_bridge_app/core/resources/export.dart';

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
