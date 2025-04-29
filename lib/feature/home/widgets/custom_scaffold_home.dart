import 'package:edu_bridge_app/core/export.dart';

class CustomScaffoldHome extends StatelessWidget {
  final String? name;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final String? email;

  const CustomScaffoldHome({
    super.key,
    this.name,
    required this.body,
    this.floatingActionButton,
    this.actions,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocalizationController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 16.0),
          child: AppBar(
            toolbarHeight: 100,
            backgroundColor: AppColors.bg,
            surfaceTintColor: AppColors.bg,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name ?? 'hi_there'.tr,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: 'search_prompt'.tr,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackGray,
                ),
              ],
            ),
            actions: [
              ...?actions,
              // Language Toggle Icon
              IconButton(
                onPressed: () {
                  final isEnglish = Get.locale?.languageCode == 'en';
                  localeController.changeLocale(isEnglish ? 'bn' : 'en');
                },
                icon: SvgPicture.asset(
                  Get.locale?.languageCode == 'en'
                      ? AssetsPath.en // Bangla flag
                      : AssetsPath.bn, // English flag
                  width: 30,
                  height: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.bg,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
