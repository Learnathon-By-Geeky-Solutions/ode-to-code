import 'package:edu_bridge_app/core/resources/export.dart';

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
              const AddOfferSlider(),
              SizedBox(height: 3.h),
              const AddPopularCourse(),
              const AddTopMentor(),
            ],
          ),
        ),
      ),
    );
  }
}
