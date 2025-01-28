import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/home/subjects/subjects_view.dart';

class SchoolView extends StatefulWidget {
  const SchoolView({super.key});

  @override
  State<SchoolView> createState() => _SchoolViewState();
}

class _SchoolViewState extends State<SchoolView> {
  final List<String> school = [
    AssetsPath.class6,
    AssetsPath.class7,
    AssetsPath.class8,
    AssetsPath.class9,
    AssetsPath.class10
  ];

  final List<Widget> views = [
    const SubjectsView(),
    const SubjectsView(),
    const SubjectsView(),
    const SubjectsView(),
    const SubjectsView(),
  ];

  void navigateToViews(int index) {
    if (index < views.length) {
      Get.to(views[index]);
    } else {
      debugPrint("Invalid index: $index");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "School ",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 1, // This makes the height and width equal
          ),
          itemCount: school.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => navigateToViews(index),
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
                        school[index],
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
