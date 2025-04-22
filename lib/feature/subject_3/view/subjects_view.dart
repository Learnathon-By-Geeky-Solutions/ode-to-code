import 'package:edu_bridge_app/core/resources/export.dart';

class SubjectsView extends StatefulWidget {
  const SubjectsView({super.key, required this.classId});
  final String classId;

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  final SubjectController _controller = Get.find();

  @override
  void initState() {
    super.initState();
    _controller.fetchSubjects(widget.classId);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      name: "Subjects View",
      floatingActionButton: _buildFloatingActionButton(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<SubjectController>(builder: (controller) {
          if (controller.inProgress) return _buildLoadingState();
          if (controller.subjects.isEmpty) return _buildEmptyState();
          return _buildSubjectGrid(controller);
        }),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return OutlinedButton(
      onPressed: showAddSubjectDialog,
      child: const Icon(Icons.add),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyState() {
    return Center(child: CustomText(text: 'no_content_available'.tr));
  }

  Widget _buildSubjectGrid(SubjectController controller) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 1,
        childAspectRatio: 1,
      ),
      itemCount: controller.subjects.length,
      itemBuilder: (context, index) {
        return _buildSubjectCard(controller, index);
      },
    );
  }

  Widget _buildSubjectCard(SubjectController controller, int index) {
    return InkWell(
      onTap: () => _onSubjectTap(controller.subjects[index]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Card(
            elevation: 3,
            color: AppColors.white,
            child: Center(
              child: Stack(
                children: [
                  SvgPicture.asset(AssetsPath.subjectsBook,
                      fit: BoxFit.contain),
                  _buildSubjectName(controller, index),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectName(SubjectController controller, int index) {
    return Positioned(
      top: 20,
      left: 15,
      right: 1,
      bottom: 1,
      child: Center(
        child: controller.subjects[index].image.isNotEmpty
            ? Text(
                controller.subjects[index].subjectName,
                style: GoogleFonts.murecho(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.bookColor,
                ),
              )
            : const Icon(
                Icons.image_not_supported,
                size: 50,
              ),
      ),
    );
  }

  void _onSubjectTap(SubjectModel subject) {
    Get.to(
      () => ChaptersView(
        subjectId: subject.id!,
        subjectName: subject.subjectName,
      ),
    );
  }

  void showAddSubjectDialog() {
    final TextEditingController subjectNameController = TextEditingController();
    Get.dialog(
      GetBuilder<SubjectController>(builder: (controller) {
        return AlertDialog(
          title: CustomText(text: 'add_subject_name'.tr),
          content:
              _buildSubjectDialogContent(controller, subjectNameController),
          actions: [
            _buildAddButton(controller, subjectNameController),
            _buildCancelButton(),
          ],
        );
      }),
    );
  }

  Widget _buildSubjectDialogContent(SubjectController controller,
      TextEditingController subjectNameController) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: subjectNameController,
            decoration: const InputDecoration(hintText: "Enter Subject Name"),
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
    );
  }

  Widget _buildAddButton(SubjectController controller,
      TextEditingController subjectNameController) {
    return TextButton(
      onPressed: () async {
        if (subjectNameController.text.isNotEmpty) {
          bool success = await controller.addSubject(
            widget.classId,
            subjectNameController.text,
          );
          if (success) {
            controller.fetchSubjects(widget.classId);
            Get.back();
          }
        } else {
          Get.snackbar("Error", "Class name cannot be empty");
        }
      },
      child: CustomText(text: 'add'.tr),
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () => Get.back(),
      child: CustomText(text: 'cancel'.tr),
    );
  }
}
