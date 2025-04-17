import 'package:edu_bridge_app/core/resources/export.dart';

class TopMentorSection extends StatelessWidget {
  const TopMentorSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.0.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'top_mentor'.tr,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const TopMentorsView());
                  },
                  child: CustomText(
                    text: 'see_all'.tr,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.themeColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<MentorController>(
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

                return ListView.builder(
                  itemCount: controller.mentors.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final mentor = controller.mentors[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
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
                        child: SizedBox(
                          width: 80,
                          height: 96,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  mentor.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                mentor.name,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
