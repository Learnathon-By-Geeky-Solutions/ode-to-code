import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/view_model/test/class_model/class_model.dart';

class ClassRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addClass(String categoryId, String className) async {
    await _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('classes')
        .add({'name': className});
  }

  Future<List<ClassModel>> fetchClasses(String categoryId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('classes')
        .get();

    return querySnapshot.docs
        .map((doc) => ClassModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
