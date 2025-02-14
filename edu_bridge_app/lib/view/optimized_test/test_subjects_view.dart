import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/optimized_test/test_chapters_view.dart';
import 'package:edu_bridge_app/view_model/test/subjects_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

class TestSubjectsView extends StatelessWidget {
  final String categoryId;
  final String classId;
  final String classTitle;

  const TestSubjectsView({
    required this.categoryId,
    required this.classId,
    required this.classTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SubjectsController controller = Get.put(SubjectsController());
    controller.fetchSubjects(categoryId, classId);

    return CustomScaffold(
      title: classTitle,
      body: Obx(() {
        if (controller.subjects.isEmpty) {
          return const Center(child: Text("No subjects available"));
        } else {
          /*return ListView.builder(
            itemCount: controller.subjects.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.subjects[index]),
                onTap: () {
                  Get.to(() => TestChaptersView(
                        categoryId: categoryId,
                        classId: classId,
                        subjectId: controller
                            .subjects[index], // Subject name used as ID
                        subjectTitle:
                            controller.subjects[index], // Subject title
                      ));
                },
              );
            },
          );*/
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 1,
              childAspectRatio: 1, // Ensures square aspect ratio
            ),
            itemCount:
                controller.subjects.length, // Total number of items in the grid
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // Navigate to TestChaptersView with the selected subject
                  Get.to(() => TestChaptersView(
                        categoryId: categoryId,
                        classId: classId,
                        subjectId:
                            controller.subjects[index], // Subject name as ID
                        subjectTitle:
                            controller.subjects[index], // Subject title
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Card(
                      elevation: 3,
                      color: AppColors.white,
                      child: Center(
                        child: Stack(
                          children: [
                            // Background image of the subject
                            SvgPicture.asset(
                              AssetsPath.subjectsBook,
                              width: 100,
                              height: 100,
                            ),
                            // Positioned text on top of the background image
                            Positioned(
                              top: 20,
                              left: 15,
                              right: 1,
                              bottom: 1,
                              child: Center(
                                child: Text(
                                  controller.subjects[index],
                                  style: GoogleFonts.murecho(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.bookColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(AlertDialog(
            title: const Text("Add Subject"),
            content: TextField(
              controller: controller.subjectController,
              decoration: const InputDecoration(hintText: "Enter subject name"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.addSubject(categoryId, classId);
                  Get.back();
                },
                child: const Text("Add"),
              ),
            ],
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
