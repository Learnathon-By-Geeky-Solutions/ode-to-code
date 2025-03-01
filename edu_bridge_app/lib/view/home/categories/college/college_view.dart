import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';

class CollegeView extends StatefulWidget {
  const CollegeView({super.key});

  @override
  State<CollegeView> createState() => _CollegeViewState();
}

class _CollegeViewState extends State<CollegeView> {
  final List<String> college = [
    AssetsPath.hsc1Sci,
    AssetsPath.hsc2Sci,
    AssetsPath.hsc1Com,
    AssetsPath.hsc2Com,
    AssetsPath.hsc1Hum,
    AssetsPath.hsc2Hum,
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "College",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 1, // This makes the height and width equal
          ),
          itemCount: college.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 50, // Fixed width for the Card
                height: 50, // Fixed height for the Card
                child: Card(
                  elevation: 3,
                  color: AppColors.white,
                  child: Center(
                    child: SvgPicture.asset(
                      college[index],
                      fit: BoxFit.contain,
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
