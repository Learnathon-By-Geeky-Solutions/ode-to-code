import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/custom_scaffold.dart';
import 'package:edu_bridge_app/view/admin_content_post/widget/add_offer_slider.dart';
import 'package:edu_bridge_app/view/admin_content_post/widget/add_popular_course.dart';
import 'package:edu_bridge_app/view/admin_content_post/widget/add_top_mentor.dart';
import 'package:edu_bridge_app/view/home/widget/all_categories.dart';
import 'package:edu_bridge_app/view/home/widget/category_section.dart';

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

              AddOfferSlider(),
              SizedBox(height: 3.h),
              /* CategoriesSection(
                widgets: AllCategories(categoriesList: []),
              ),*/
              // Popular Course
              AddPopularCourse(),
              // Top Mentor
              AddTopMentor(),
            ],
          ),
        ),
      ),
    );
  }
}
