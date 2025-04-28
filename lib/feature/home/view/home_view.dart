import 'package:edu_bridge_app/core/resources/export.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<void> _onRefresh() async {
    await Get.find<BannerController>().fetchBanners();
    await Get.find<CategoryController>().fetchCategories();
    await Get.find<PopularCourseController>().fetchPopularCourses();
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldHome(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            _buildHomeContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return Column(
      children: [
        SizedBox(height: 1.h),
        const HomeBanner(),
        SizedBox(height: 1.h),
        CategoriesSection(),
        const PopularCourses(),
      ],
    );
  }
}
