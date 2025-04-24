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
      name: "Hi, There\nUpload your content here",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Wrap(children: [AddOfferSlider()]),
                SizedBox(height: 3.h),
                const Wrap(children: [AddPopularCourse()]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
