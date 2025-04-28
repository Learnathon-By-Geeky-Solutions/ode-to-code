import 'package:edu_bridge_app/core/resources/export.dart';

class SubjectGridItem extends StatelessWidget {
  final SubjectModel subjectModel;

  const SubjectGridItem({super.key, required this.subjectModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ChaptersView(
              subjectId: subjectModel.id!,
              subjectName: subjectModel.subjectName,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          color: AppColors.white,
          child: Stack(
            children: [
              Center(
                child: SvgPicture.asset(
                  AssetsPath.subjectsBook,
                  fit: BoxFit.contain,
                  height: 10.h,
                  width: 10.w,
                ),
              ),
              Positioned(
                top: 20,
                left: 15,
                right: 1,
                bottom: 1,
                child: Center(
                  child: Text(
                    subjectModel.subjectName,
                    style: GoogleFonts.murecho(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.bookColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
