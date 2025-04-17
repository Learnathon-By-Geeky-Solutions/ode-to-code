import 'package:edu_bridge_app/core/resources/export.dart';

class TopMentorDetailsView extends StatelessWidget {
  const TopMentorDetailsView({
    super.key,
    required this.name,
    required this.designation,
    required this.whatHeDo,
    required this.description,
    required this.image,
  });
  final String name;
  final String designation;
  final String whatHeDo;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      name: 'your_profile'.tr,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.bgWhite,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 4),
                  color: Colors.greenAccent,
                ),
                child: CircleAvatar(
                  backgroundImage: image.trim().isNotEmpty
                      ? NetworkImage(image)
                      : const AssetImage('assets/images/default_avatar.png')
                          as ImageProvider,
                ),
              ),
              const SizedBox(height: 12),
              CustomText(
                text: "${'label_name'.tr} : $name",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              VerticalSpacing(1.h),
              CustomText(
                text: "${'label_designation'.tr} : $designation",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              VerticalSpacing(1.h),
              CustomText(
                text: "${'label_what_he_do'.tr} : $whatHeDo",
              ),
              VerticalSpacing(1.h),
              CustomText(
                text: "${'label_description'.tr} : $description",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(
    String title,
    IconData leading,
    IconData trailing,
    VoidCallback onTap,
  ) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title, style: const TextStyle(fontSize: 16)),
        leading: Icon(leading),
        trailing: Icon(trailing),
      ),
    );
  }
}
