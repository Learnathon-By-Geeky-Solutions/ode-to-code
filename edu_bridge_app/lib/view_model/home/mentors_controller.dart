import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MentorController extends GetxController {
  var mentorList = <Map<String, dynamic>>[].obs; // Observable list for mentors
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchMentors();
    super.onInit();
  }

  void fetchMentors() async {
    try {
      isLoading(true);
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('mentors').get();
      mentorList.value = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load mentors: $e');
    } finally {
      isLoading(false);
    }
  }
}
