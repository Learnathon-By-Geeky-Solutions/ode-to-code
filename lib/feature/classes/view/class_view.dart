import 'package:edu_bridge_app/core/resources/export.dart';


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
  final ClassController _controller = Get.find();

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
        onPressed: () =>
            Get.dialog(AddClassDialog(categoryId: widget.categoryId)),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<ClassController>(
          builder: (controller) {
            if (controller.inProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.classes.isEmpty) {
              return CustomText(text: 'no_content_available'.tr);
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1,
                ),
                itemCount: controller.classes.length,
                itemBuilder: (context, index) {
                  return ClassGridItem(classModel: controller.classes[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
