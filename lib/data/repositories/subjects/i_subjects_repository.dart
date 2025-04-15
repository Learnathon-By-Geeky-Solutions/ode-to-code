import 'dart:io';
import 'package:edu_bridge_app/data/models/subject_model.dart';

abstract class ISubjectRepository {
  Future<String?> uploadSubjectImage(File imageFile);
  Future<bool> addSubject(SubjectModel subjectModel);
  Future<List<SubjectModel>> fetchSubjectsByClassId(String classId);
}
