import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PopularCourseController extends GetxController {
  var courseList = <Map<String, dynamic>>[].obs; // Observable list for courses
  var isLoading = true.obs; // Loading indicator

  @override
  void onInit() {
    fetchCourses(); // Fetch data on initialization
    super.onInit();
  }

  void fetchCourses() async {
    try {
      isLoading(true); // Set loading to true
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('courses').get();
      courseList.value = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load courses: $e');
    } finally {
      isLoading(false); // Set loading to false
    }
  }
}
