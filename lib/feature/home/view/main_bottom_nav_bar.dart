import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/feature/profile/view/fetch_user_profile_view.dart';
import 'package:edu_bridge_app/feature/user_saved_item/view/user_saved_item_view.dart';

class MainBottomNavView extends StatelessWidget {
  MainBottomNavView({super.key});

  final MainBottomNavBarController controller =
      Get.put(MainBottomNavBarController());

  final List<Widget> _screens = const [
    HomeView(),
    UserSavedItemView(),
    FetchUserProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavBarController>(
      builder: (controller) => Scaffold(
        body: _screens[controller.selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.selectedIndex,
          onDestinationSelected: (value) {
            controller.changeIndex(value);
          },
          backgroundColor: AppColors.bg,
          indicatorColor: AppColors.shadowGrey,
          shadowColor: AppColors.grey,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'home'.tr),
            NavigationDestination(
              icon: const Icon(Icons.menu_book),
              label: 'saved_item'.tr,
            ),
            NavigationDestination(
                icon: const Icon(Icons.person), label: 'profile'.tr),
          ],
        ),
      ),
    );
  }
}
