/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_bridge_app/view_model/test/subject_model/subject_model.dart';

class SubjectRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSubject({
    required String categoryId,
    required String classId,
    required String subjectName,
  }) async {
    await _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('classes')
        .doc(classId)
        .collection('subjects')
        .add({'name': subjectName});
  }

  Future<List<SubjectModel>> fetchSubjects({
    required String categoryId,
    required String classId,
  }) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('classes')
        .doc(classId)
        .collection('subjects')
        .get();

    return querySnapshot.docs
        .map((doc) => SubjectModel.fromFirestore(
              doc.data() as Map<String, dynamic>,
              doc.id,
            ))
        .toList();
  }
}
*/
