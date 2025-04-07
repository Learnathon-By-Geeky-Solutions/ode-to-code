import 'package:edu_bridge_app/data/models/mentor_model.dart';
import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view_model/mentor_controller.dart';

class TopMentorsView extends StatefulWidget {
  const TopMentorsView({super.key});

  @override
  State<TopMentorsView> createState() => _TopMentorsViewState();
}

class _TopMentorsViewState extends State<TopMentorsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const CustomText(
          text: "Top Mentors",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: GetBuilder<MentorController>(
        init: MentorController(), // Initialize the controller
        builder: (controller) {
          // Show loading indicator if still fetching mentors
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error message if fetching mentors failed
          if (controller.errorMessage != null) {
            return Center(
              child: CustomText(
                text: controller.errorMessage!,
                color: Colors.red,
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.mentors.length,
                  itemBuilder: (context, index) {
                    final mentor = controller.mentors[index];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: buildContainer(mentor),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildContainer(MentorModel mentor) {
    return Card(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 363,
          height: 93,
          child: Row(
            children: [
              // Display mentor's image
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(66),
                  image: DecorationImage(
                    image:
                        NetworkImage(mentor.image), // Image URL of the mentor
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: mentor.name,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: mentor.designation,
                      fontSize: 13,
                      color: AppColors.blackGray,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
