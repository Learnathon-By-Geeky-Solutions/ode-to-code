import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/admin_content_post/widget/add_offer_slider.dart';
import 'package:edu_bridge_app/view/admin_content_post/widget/add_popular_course.dart';
import 'package:edu_bridge_app/view/admin_content_post/widget/add_top_mentor.dart';

class AdminContentPostView extends StatefulWidget {
  const AdminContentPostView({super.key});

  @override
  State<AdminContentPostView> createState() => _AdminContentPostViewState();
}

class _AdminContentPostViewState extends State<AdminContentPostView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      name: "Hi, There\nUpload your content",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Slider
              const AddOfferSlider(),
              SizedBox(height: 3.h),
              // Popular Course
              const AddPopularCourse(),
              // Top Mentor
              const AddTopMentor(),
            ],
          ),
        ),
      ),
    );
  }
}
