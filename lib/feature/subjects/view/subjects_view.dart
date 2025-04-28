import 'package:edu_bridge_app/core/export.dart';
import 'package:edu_bridge_app/feature/subjects/widget/add_subject_dialog.dart';
import 'package:edu_bridge_app/feature/subjects/widget/subject_grid_item.dart';

class SubjectsView extends StatefulWidget {
  const SubjectsView({super.key, required this.classId});
  final String classId;

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  final SubjectController _controller = Get.find();
  final isAdmin = Get.find<UserProfileController>().isAdmin;

  @override
  void initState() {
    super.initState();
    _controller.fetchSubjects(widget.classId);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      name: "subjects".tr,
      floatingActionButton: isAdmin
          ? OutlinedButton(
              onPressed: () => Get.dialog(
                AddSubjectDialog(classId: widget.classId),
              ),
              child: const Icon(Icons.add),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<SubjectController>(
          builder: (controller) {
            if (controller.inProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.subjects.isEmpty) {
              return Center(child: CustomText(text: 'no_content_available'.tr));
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1,
                ),
                itemCount: controller.subjects.length,
                itemBuilder: (context, index) {
                  return SubjectGridItem(
                      subjectModel: controller.subjects[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
