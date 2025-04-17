import 'package:edu_bridge_app/core/resources/export.dart';

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
              _buildCustomText('top_mentor'.tr),
              InkWell(
                onTap: () {},
                child: _buildCustomText(
                  'see_all'.tr,
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

  Widget _buildCustomText(String text, {Color? color, double fontSize = 18}) {
    return CustomText(
      text: text,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      color: color ?? Colors.black,
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
        _buildCustomText('add_mentor_name'.tr, fontSize: 12),
      ],
    );
  }
}
