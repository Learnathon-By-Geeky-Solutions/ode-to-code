import 'package:edu_bridge_app/core/export.dart';

abstract class ISubjectRepository {
  Future<bool> addSubject(SubjectModel subjectModel);
  Future<List<SubjectModel>> fetchSubjectsByClassId(String classId);
}
