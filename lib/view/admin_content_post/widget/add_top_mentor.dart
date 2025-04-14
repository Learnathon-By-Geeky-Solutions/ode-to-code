import 'package:edu_bridge_app/resources/export.dart';
import 'package:edu_bridge_app/utils/add_mentor_dialog.dart';

class AddTopMentor extends StatefulWidget {
  const AddTopMentor({super.key});

  @override
  State<AddTopMentor> createState() => _AddTopMentorState();
}

class _AddTopMentorState extends State<AddTopMentor> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                onTap: () {},
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
        InkWell(
          onTap: () {
            Get.dialog(const AddMentorDialog());
          },
          child: topMentor(),
        ),
      ],
    );
  }

  Widget topMentor() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 85,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        CustomText(
          text: 'add_mentor_name'.tr,
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
