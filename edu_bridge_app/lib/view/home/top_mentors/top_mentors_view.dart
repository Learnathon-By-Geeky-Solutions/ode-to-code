import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/view_model/home/mentors_controller.dart';

class TopMentorsView extends StatefulWidget {
  const TopMentorsView({super.key});

  @override
  State<TopMentorsView> createState() => _TopMentorsViewState();
}

class _TopMentorsViewState extends State<TopMentorsView> {
  final MentorController mentorController = Get.put(MentorController());

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
      body: Column(
        children: [
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
                  scrollDirection: Axis.vertical,
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
      ),
    );
  }

  Widget buildMentorCard(String imageUrl, String name, String specialty) {
    return Card(
      color: AppColors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 363,
          height: 93,
          child: Row(
            children: [
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(66),
                    color: Colors.black),
                child: imageUrl.isEmpty
                    ? const Icon(Icons.person, color: AppColors.white, size: 40)
                    : Image.network(imageUrl,
                        height: 134, width: 280, fit: BoxFit.contain),
              ),
              Padding(
                padding: EdgeInsets.all(2.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: name,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: specialty,
                      fontSize: 13,
                      color: AppColors.blackGray,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
