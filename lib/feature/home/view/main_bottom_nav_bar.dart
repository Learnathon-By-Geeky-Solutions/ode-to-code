import 'package:edu_bridge_app/core/resources/export.dart';

class MainBottomNavView extends StatelessWidget {
  MainBottomNavView({super.key});

  final MainBottomNavBarController controller =
      Get.put(MainBottomNavBarController());

  final List<Widget> _screens = const [
    HomeView(),
    PopularCoursesView(),
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
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
              icon: Icon(Icons.menu_book),
              label: 'Saved Item',
            ),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
