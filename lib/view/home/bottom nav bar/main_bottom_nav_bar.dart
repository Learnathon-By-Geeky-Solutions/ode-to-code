import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:edu_bridge_app/view/home/categories/categories_view.dart';
import 'package:edu_bridge_app/view/home/home_view.dart';
import 'package:edu_bridge_app/view/home/popular_courses/popular_courses_view.dart';
import 'package:edu_bridge_app/view/user/fetch_user_profile_view.dart';
import 'package:edu_bridge_app/view_model/main_bottom_navbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavScreen extends StatelessWidget {
  MainBottomNavScreen({super.key});

  final MainBottomNavBarController controller =
      Get.put(MainBottomNavBarController());

  final List<Widget> _screens = const [
    HomeView(),
    CategoriesView(),
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
          backgroundColor: AppColors.white,
          indicatorColor: AppColors.shadowGrey,
          shadowColor: AppColors.grey,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.category), label: 'Categories'),
            NavigationDestination(icon: Icon(Icons.star), label: 'Popular'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
