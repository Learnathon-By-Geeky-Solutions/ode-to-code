import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/home/subjects/subjects_view.dart';
import 'package:edu_bridge_app/view_model/class_controller.dart';

class ClassView extends StatefulWidget {
  const ClassView({
    super.key,
    required this.categoryId,
    required this.className,
  });

  final String categoryId;
  final String className;

  @override
  State<ClassView> createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {
  final ClassController _controller = Get.put(ClassController());

  @override
  void initState() {
    super.initState();
    _controller.fetchClasses(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      name: widget.className,
      floatingActionButton: OutlinedButton(
        onPressed: showAddClassDialog,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<ClassController>(
          builder: (controller) {
            return controller.inProgress
                ? const Center(child: CircularProgressIndicator())
                : controller.classes.isEmpty
                    ? const Center(child: Text("No content available"))
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: 1,
                        ),
                        itemCount: controller.classes.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(() => SubjectsView(
                                    classId: controller.classes[index].id!,
                                  ));
                              print(controller.classes[index].id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 3,
                                color: AppColors.white,
                                child: Center(
                                  child: controller
                                          .classes[index].image.isNotEmpty
                                      ? Image.network(
                                          controller.classes[index].image)
                                      : const Icon(Icons.image_not_supported,
                                          size: 50),
                                ),
                              ),
                            ),
                          );
                        },
                      );
          },
        ),
      ),
    );
  }

  void showAddClassDialog() {
    final TextEditingController classNameController = TextEditingController();

    Get.dialog(
      GetBuilder<ClassController>(
        builder: (controller) {
          return AlertDialog(
            title: const Text("Add Class"),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: classNameController,
                    decoration:
                        const InputDecoration(hintText: "Enter Class Name"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: controller.pickClassImage,
                    child: const Text("Add Image"),
                  ),
                  const SizedBox(height: 10),
                  if (controller.classImage != null)
                    Image.file(
                      controller.classImage!,
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
                  if (classNameController.text.isNotEmpty) {
                    bool success = await controller.addClass(
                      widget.categoryId,
                      classNameController.text,
                    );
                    if (success) {
                      controller.fetchClasses(widget.categoryId);
                      Get.back();
                    }
                  } else {
                    Get.snackbar("Error", "Class name cannot be empty");
                  }
                },
                child: const Text("Add"),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Cancel"),
              ),
            ],
          );
        },
      ),
    );
  }
}
