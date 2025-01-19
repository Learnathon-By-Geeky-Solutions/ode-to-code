import 'package:edu_bridge_app/resources/export.dart';

class PopularCourseModel {
  final String categories;
  final String courseName;
  final String price;

  PopularCourseModel({
    required this.categories,
    required this.courseName,
    required this.price,
  });
}

final popularCourseList = [
  PopularCourseModel(
    categories: "Graphics Design",
    courseName: "Graphics Design Advanced",
    price: "1000",
  ),
  PopularCourseModel(
    categories: "Programming",
    courseName: "Flutter Development Bootcamp",
    price: "1500",
  ),
  PopularCourseModel(
    categories: "Data Science",
    courseName: "Data Science with Python",
    price: "2000",
  ),
  PopularCourseModel(
    categories: "Marketing",
    courseName: "Digital Marketing Masterclass",
    price: "1200",
  ),
  PopularCourseModel(
    categories: "Web Development",
    courseName: "Full Stack Web Development",
    price: "1800",
  ),
  PopularCourseModel(
    categories: "UI/UX Design",
    courseName: "UI/UX Design Essentials",
    price: "1400",
  ),
  PopularCourseModel(
    categories: "Cybersecurity",
    courseName: "Ethical Hacking and Cybersecurity",
    price: "2200",
  ),
  PopularCourseModel(
    categories: "Photography",
    courseName: "Professional Photography Basics",
    price: "800",
  ),
  PopularCourseModel(
    categories: "Video Editing",
    courseName: "Adobe Premiere Pro Essentials",
    price: "1100",
  ),
  PopularCourseModel(
    categories: "Finance",
    courseName: "Personal Finance Management",
    price: "1000",
  ),
];

class PopularCourseController extends GetxController {
  bool isLoading = false;
}
