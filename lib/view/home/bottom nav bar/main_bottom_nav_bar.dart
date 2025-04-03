import 'package:edu_bridge_app/resources/app_colors.dart';
import 'package:edu_bridge_app/view/home/categories/categories_view.dart';
import 'package:edu_bridge_app/view/home/home_view.dart';
import 'package:edu_bridge_app/view/home/popular_courses/popular_courses_view.dart';
import 'package:edu_bridge_app/view/user/fetch_user_profile_view.dart';
import 'package:flutter/material.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const CategoriesView(),
    const PopularCoursesView(),
    const FetchUserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: Colors.grey.shade300, // Change this for selected items
        shadowColor: Colors.grey, // Change this for unselected items

        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.category), label: 'Categories'),
          NavigationDestination(icon: Icon(Icons.star), label: 'Popular'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
