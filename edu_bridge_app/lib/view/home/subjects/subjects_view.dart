import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/home/categories/college/college_view.dart';
import 'package:edu_bridge_app/view/home/categories/school/school_view.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectsView extends StatefulWidget {
  const SubjectsView({super.key});

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  final List<String> subjects = [
    "BANGLA",
    "ENGLISH",
    "MATH",
    "H MATH",
    "SCIENCE",
    "ICT",
    "BGS",
  ];
  final List<Widget> views = [
    const SchoolView(),
    const CollegeView(),
  ];

  void navigateToView(int index) {
    Get.to(
      views[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Subjects View",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of items per row
            crossAxisSpacing: 8, // Horizontal spacing
            mainAxisSpacing: 1, // Vertical spacing
            childAspectRatio:
                1, // Adjust for smaller grid items // This makes the height and width equal
          ),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            return InkWell(
              //onTap: () => navigateToView(index),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Card(
                    elevation: 3,
                    color: AppColors.white,
                    child: Center(
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            AssetsPath.subjectsBook,
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            top: 20,
                            left: 15,
                            right: 1,
                            bottom: 1,
                            child: Center(
                              child: Text(
                                subjects[index],
                                style: GoogleFonts.murecho(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff507C5C)),
                              ),
                            ),
                          )
                        ],
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
