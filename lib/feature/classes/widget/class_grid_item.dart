import 'package:edu_bridge_app/core/resources/export.dart';

class ClassGridItem extends StatelessWidget {
  final ClassModel classModel;

  const ClassGridItem({super.key, required this.classModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => SubjectsView(classId: classModel.id!));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          color: AppColors.white,
          child: Center(
            child: classModel.image.isNotEmpty
                ? Image.network(classModel.image)
                : const Icon(Icons.image_not_supported, size: 50),
          ),
        ),
      ),
    );
  }
}
