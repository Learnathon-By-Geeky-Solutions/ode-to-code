import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/home/chapters/chapters_view.dart';
import 'package:edu_bridge_app/view_model/subject_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectsView extends StatefulWidget {
  const SubjectsView({super.key, required this.classId});
  final String classId;

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  final SubjectController _controller = Get.put(SubjectController());

  @override
  void initState() {
    super.initState();
    _controller.fetchSubjects(widget.classId);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      name: "Subjects View",
      floatingActionButton: OutlinedButton(
        onPressed: showAddSubjectDialog,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<SubjectController>(builder: (controller) {
          return controller.inProgress
              ? const Center(child: CircularProgressIndicator())
              : controller.subjects.isEmpty
                  ? Center(child: CustomText(text: 'no_content_available'.tr))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 1,
                        childAspectRatio: 1,
                      ),
                      itemCount: controller.subjects.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => ChaptersView(
                                  subjectId: controller.subjects[index].id!,
                                  subjectName:
                                      controller.subjects[index].subjectName!),
                            );
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
                                          child: controller.subjects[index]
                                                  .image.isNotEmpty
                                              ? Text(
                                                  controller.subjects[index]
                                                      .subjectName, // Placeholder text
                                                  style: GoogleFonts.murecho(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.bookColor,
                                                  ),
                                                )
                                              : const Icon(
                                                  Icons.image_not_supported,
                                                  size: 50),
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
                    );
        }),
      ),
    );
  }

  void showAddSubjectDialog() {
    final TextEditingController subjectNameController = TextEditingController();

    Get.dialog(
      GetBuilder<SubjectController>(
        builder: (controller) {
          return AlertDialog(
            title: CustomText(text: 'add_subject_name'.tr),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: subjectNameController,
                    decoration:
                        const InputDecoration(hintText: "Enter Subject Name"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: controller.pickSubjectImage,
                    child: CustomText(text: 'add_image'.tr),
                  ),
                  const SizedBox(height: 10),
                  if (controller.subjectImage != null)
                    Image.file(
                      controller.subjectImage!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (subjectNameController.text.isNotEmpty) {
                    bool success = await controller.addSubject(
                      widget.classId,
                      subjectNameController.text,
                    );
                    if (success) {
                      controller.fetchSubjects(
                        widget.classId,
                      );
                      Get.back();
                    }
                    print(widget.classId);
                    print(subjectNameController.text);
                  } else {
                    Get.snackbar("Error", "Class name cannot be empty");
                  }
                },
                child: CustomText(text: 'add'.tr),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: CustomText(text: 'cancel'.tr),
              ),
            ],
          );
        },
      ),
    );
  }
}
