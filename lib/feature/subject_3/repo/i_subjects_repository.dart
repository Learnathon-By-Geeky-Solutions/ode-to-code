import 'package:edu_bridge_app/core/resources/export.dart';

abstract class ISubjectRepository {
  Future<String?> uploadSubjectImage(File imageFile);
  Future<bool> addSubject(SubjectModel subjectModel);
  Future<List<SubjectModel>> fetchSubjectsByClassId(String classId);
}
