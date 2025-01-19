import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/home/categories/college/college_view.dart';
import 'package:edu_bridge_app/view/home/categories/school/school_view.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final List<String> categories = [
    AssetsPath.school,
    AssetsPath.college,
    AssetsPath.english,
    AssetsPath.creativity,
    AssetsPath.skill,
  ];
  final List<Widget> views = [
    const SchoolView(),
    const CollegeView(),
  ];

  void navigateToView(int index) {
    Get.to(views[index]);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "All Categories",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 1, // This makes the height and width equal
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => navigateToView(index),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 50, // Fixed width for the Card
                  height: 50, // Fixed height for the Card
                  child: Card(
                    elevation: 3,
                    color: AppColors.white,
                    child: Center(
                      child: SvgPicture.asset(
                        categories[index],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
