import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/home/chapters/chapters_view.dart';
import 'package:edu_bridge_app/view_model/subject_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectsView extends StatefulWidget {
  const SubjectsView({super.key});

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  final SubjectsController controller = Get.put(SubjectsController());

  void navigateToView(String subject) {
    Get.to(() => ChaptersView(subject: subject));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Subjects View",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 1,
              childAspectRatio: 1,
            ),
            itemCount: controller.subjects.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => navigateToView(controller.subjects[index]),
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
                                  controller.subjects[index],
                                  style: GoogleFonts.murecho(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.bookColor,
                                  ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddSubjectDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddSubjectDialog() {
    TextEditingController subjectController = TextEditingController();
    Get.defaultDialog(
      title: "Add New Subject",
      content: TextField(
        controller: subjectController,
        decoration: const InputDecoration(
          hintText: "Enter subject name",
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (subjectController.text.trim().isNotEmpty) {
            controller.addSubject(subjectController.text.trim());
            Get.back();
          }
        },
        child: const Text("Add"),
      ),
    );
  }
}
