import 'package:edu_bridge_app/core/resources/export.dart';

class TopMentorsView extends StatefulWidget {
  const TopMentorsView({super.key});

  @override
  State<TopMentorsView> createState() => _TopMentorsViewState();
}

class _TopMentorsViewState extends State<TopMentorsView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      name: 'top_mentor'.tr,
      body: GetBuilder<MentorController>(
        init: MentorController(),
        builder: (controller) {
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

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
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            () => TopMentorDetailsView(
                              name: mentor.name,
                              designation: mentor.designation,
                              whatHeDo: mentor.whatHeDo,
                              description: mentor.description,
                              image: mentor.image,
                            ),
                          );
                        },
                        child: buildContainer(mentor),
                      ),
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
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(66),
                  image: DecorationImage(
                    image: NetworkImage(mentor.image),
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
