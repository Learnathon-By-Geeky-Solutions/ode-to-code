import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view/home/top_mentors/top_mentors_view.dart';
import 'package:edu_bridge_app/view_model/home/mentors_controller.dart';

class TopMentors extends StatelessWidget {
  TopMentors({super.key});
  final MentorController mentorController = Get.put(MentorController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: "Popular Mentors",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => TopMentorsView());
                },
                child: CustomText(
                  text: "SEE ALL",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () {
            if (mentorController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (mentorController.mentorList.isEmpty) {
              return const Center(child: Text("No Mentors Available"));
            }
            return SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mentorController.mentorList.length,
                itemBuilder: (context, index) {
                  var mentor = mentorController.mentorList[index];
                  return buildMentorCard(
                    mentor["imageUrl"] ?? "",
                    mentor["name"] ?? "Unknown",
                    mentor["specialty"] ?? "No specialty",
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildMentorCard(String imageUrl, String name, String specialty) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 85,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: imageUrl.isEmpty
                  ? const Icon(Icons.person, color: AppColors.white, size: 40)
                  : Image.network(imageUrl,
                      height: 134, width: 280, fit: BoxFit.fill),
            ),
          ),
          CustomText(
            text: name,
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            text: specialty,
            color: Colors.black,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
