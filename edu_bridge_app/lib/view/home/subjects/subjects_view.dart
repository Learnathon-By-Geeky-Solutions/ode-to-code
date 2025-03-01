import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectsView extends StatelessWidget {
  const SubjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Subjects View",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 1,
            childAspectRatio: 1,
          ),
          itemCount: 6, // Static count for UI purpose
          itemBuilder: (context, index) {
            return Padding(
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
                              "Subject ${index + 1}", // Placeholder text
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
            );
          },
        ),
      ),
    );
  }
}
