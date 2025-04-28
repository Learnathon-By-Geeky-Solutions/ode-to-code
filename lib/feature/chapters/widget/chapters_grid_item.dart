import 'package:edu_bridge_app/core/export.dart';

class ChapterGridItem extends StatelessWidget {
  final ChapterModel chapterModel;

  const ChapterGridItem({super.key, required this.chapterModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ContentView(
              chapterTitle: chapterModel.chapterName,
              chaptersId: chapterModel.id!,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.green,
        ),
        child: Center(
          child: CustomText(
            text: chapterModel.chapterName,
            customStyle: GoogleFonts.mulish(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
